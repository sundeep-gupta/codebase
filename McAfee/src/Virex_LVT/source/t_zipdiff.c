/* $Id: t_zipdiff.c,v 1.2 2003/11/21 15:12:49 mhopkins Exp $ */
/*!
 * \file
 *
 * \brief
 * Simple file compare with relaxed rules for zip files
 *
 * Simple compare for two files that ignores time and date stamps in
 * zip file local file and central file headers
 *
 * \par Copyright
 * Copyright (C) 2003 Networks Associates Technology Inc.
 * All rights reserved.
 *
 * $Revision: 1.2 $
 *
 * \todo
 * Doesn't handle streamed members in zip files (bit 3 of the general pupose flags)
 *
 * \internal
 * This is a quick implementation that is not intended to be portable
 *
 */
#include <stdio.h>

#define _XOPEN_SOURCE 500
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <assert.h>
#include <errno.h>
#include <string.h>
#include <stdbool.h>
#define uint32_t int
/* ========================= Private definitions ========================== */
#define LOCAL_FILE_HEADER			"\x50\x4b\x03\x04"
#define LOCAL_FILE_HEADER_LEN			(sizeof(LOCAL_FILE_HEADER) - 1)
#define LOCAL_FILE_HEADER_SIZE			30
#define LOCAL_FILE_HEADER_FLAGS_OFFSET		6
#define LOCAL_FILE_HEADER_FLAG_
#define LOCAL_FILE_HEADER_TIME_OFFSET		10
#define LOCAL_FILE_HEADER_TIME_SIZE		2
#define LOCAL_FILE_HEADER_DATE_OFFSET		12
#define LOCAL_FILE_HEADER_DATE_SIZE		2
#define LOCAL_FILE_HEADER_COMP_SIZE_OFFSET	18
#define LOCAL_FILE_HEADER_FILENAME_SIZE_OFFSET	26
#define LOCAL_FILE_HEADER_EXTRA_SIZE_OFFSET	28


#define DATA_DESCRIPTOR				"\x50\x4b\x07\x08"
#define DATA_DESCRIPTOR_LEN			(sizeof(DATA_DESCRIPTOR) - 1)
#define DATA_DESCRIPTOR_SIZE			16

#define CENTRAL_FILE_HEADER			"\x50\x4b\x01\x02"
#define CENTRAL_FILE_HEADER_LEN			(sizeof(CENTRAL_FILE_HEADER) - 1)
#define CENTRAL_FILE_HEADER_SIZE		46
#define CENTRAL_FILE_HEADER_TIME_OFFSET		12
#define CENTRAL_FILE_HEADER_TIME_SIZE		2
#define CENTRAL_FILE_HEADER_DATE_OFFSET		14
#define CENTRAL_FILE_HEADER_DATE_SIZE		2
#define CENTRAL_FILE_HEADER_FILENAME_SIZE_OFFSET	28
#define CENTRAL_FILE_HEADER_EXTRA_SIZE_OFFSET		30
#define CENTRAL_FILE_HEADER_FILE_COMMENT_SIZE_OFFSET	32

#define CENTRAL_DIR_END				"\x50\x4b\x05\x06"
#define CENTRAL_DIR_END_LEN			(sizeof(CENTRAL_DIR_END) - 1)

/* =========================== Local prototypes =========================== */
static void fatalError(const char *fmt, ...);
static bool isZip(int fd);
static int zipDiff(int (*fd)[2], off_t len);
static int fileDiff(int (*fd)[2], off_t len);

/* ============================== Local Data ============================== */

/* ============================= Global Data ============================== */

/* ================================= Code ================================= */
int
main(int argc, char **argv)
{
    int retVal = EXIT_FAILURE;
    int fd[2];
    unsigned int idx;
    struct stat statbuf[2];

    argc--;
    while (*++argv && **argv == '-')
    {
	switch ((*argv)[1])
	{
	case 'q':
	case 'u':
	    /* ignore for zipdiff compatability */
	    break;
	default:
	    fatalError("Unrecognised option %s\n", *argv);
	}
	argc--;
    }

    if (argc != 2)
    {
	fatalError("Must specify two filenames\n");
    }

    for (idx = 0; idx < 2; idx++)
    {
	assert(argv[idx] && argv[idx][0]);
	fd[idx] = open(argv[idx], O_RDONLY);
	if (fd[idx] < 0)
	    fatalError("Failed to open %s: %s\n", argv[idx], strerror(errno));
	if (fstat(fd[idx], &statbuf[idx]) < 0)
	    fatalError("Failed to stat %s: %s\n", argv[idx], strerror(errno));
	if (!S_ISREG(statbuf[idx].st_mode))
	    fatalError("%s is not a regular file\n", argv[idx]);
    }

    if ((statbuf[0].st_size == statbuf[1].st_size ))
	{
		if ((statbuf[0].st_size != 0 ))
		{
			if (isZip(fd[0]) && isZip(fd[1]))
			    retVal = zipDiff(&fd, statbuf[0].st_size);
			else
	    		retVal = fileDiff(&fd, statbuf[0].st_size);

			if (retVal)
	    		fprintf(stdout, "Files %s and %s differ\n", argv[0], argv[1]);
    	}
	//	else
	//	{
	 //   	fprintf(stdout, "Zeorbyte files are always same. Moron\n");
	//	}
	}
	else
	{
	    fprintf(stdout, "Files %s and %s differ\n", argv[0], argv[1]);
	}

    close(fd[0]);
    close(fd[1]);

    return retVal;
}

static void
fatalError(const char *fmt, ...)
{
    va_list ap;

    va_start(ap, fmt);
    vfprintf(stderr, fmt, ap);
    va_end(ap);

    exit(EXIT_FAILURE);
}

static bool
isZip(int fd)
{
    char buf[LOCAL_FILE_HEADER_LEN];

    /* assume we can read the whole buffer in one go */
    if (pread(fd, buf, sizeof(buf), (off_t) 0) < (ssize_t) sizeof(buf))
	return false;

    if (memcmp(LOCAL_FILE_HEADER, buf, sizeof(buf)))
	return false;

    return true;
}

static int
zipDiff(int (*fd)[2], off_t len)
{
    int retVal = -1;
    unsigned char *p[2];

    p[0] = mmap(NULL, (size_t) len, PROT_READ | PROT_WRITE, MAP_PRIVATE, (*fd)[0], (off_t) 0);
    if (p[0])
    {
	p[1] = mmap(NULL, (size_t) len, PROT_READ | PROT_WRITE, MAP_PRIVATE, (*fd)[1], (off_t) 0);
	if (p[1])
	{
	    unsigned int idx;

	    /* skip through the file to check its format. We don't
	     * support streamed zips. If we can't follow the format
	     * then just do a byte-wise comparison
	     */
	    for (idx = 0; idx < 2; idx++)
	    {
		unsigned char *tmp;
		uint32_t skip;

		/* while we can follow the format, nuke any time and date stamps */
		tmp = p[idx];
		while (tmp >= p[idx] && 
		       tmp < (p[idx] + len - LOCAL_FILE_HEADER_SIZE) &&
		       memcmp(tmp, LOCAL_FILE_HEADER, LOCAL_FILE_HEADER_LEN) == 0)
		{
		    memset(tmp + LOCAL_FILE_HEADER_TIME_OFFSET, 0, (size_t) LOCAL_FILE_HEADER_TIME_SIZE);
		    memset(tmp + LOCAL_FILE_HEADER_DATE_OFFSET, 0, (size_t) LOCAL_FILE_HEADER_DATE_SIZE);

		    /* assume that the compressed size field is 4 bytes
		     * little endian and that the filename and extra field
		     * lengths are two bytes little endian
		     */
		    skip = tmp[LOCAL_FILE_HEADER_COMP_SIZE_OFFSET] |
			(tmp[LOCAL_FILE_HEADER_COMP_SIZE_OFFSET + 1] << 8) |
			(tmp[LOCAL_FILE_HEADER_COMP_SIZE_OFFSET + 2] << 16) |
			(tmp[LOCAL_FILE_HEADER_COMP_SIZE_OFFSET + 3] << 24);
		    skip += tmp[LOCAL_FILE_HEADER_FILENAME_SIZE_OFFSET] |
			(tmp[LOCAL_FILE_HEADER_FILENAME_SIZE_OFFSET + 1] << 8);
		    skip += tmp[LOCAL_FILE_HEADER_EXTRA_SIZE_OFFSET] |
			(tmp[LOCAL_FILE_HEADER_EXTRA_SIZE_OFFSET + 1] << 8);
		    tmp += LOCAL_FILE_HEADER_SIZE + skip;
		    if (tmp < (p[idx] + len - DATA_DESCRIPTOR_LEN) &&
		       memcmp(tmp, DATA_DESCRIPTOR, DATA_DESCRIPTOR_LEN) == 0)
		    {
			/* Shouldn't have a data descriptor but skip it anyway */
			tmp += DATA_DESCRIPTOR_SIZE;
		    }
		}
		while (tmp >= p[idx] && 
		       tmp < (p[idx] + len - CENTRAL_FILE_HEADER_SIZE) &&
		       memcmp(tmp, CENTRAL_FILE_HEADER, CENTRAL_FILE_HEADER_LEN) == 0)
		{
		    memset(tmp + CENTRAL_FILE_HEADER_TIME_OFFSET, 0, (size_t) CENTRAL_FILE_HEADER_TIME_SIZE);
		    memset(tmp + CENTRAL_FILE_HEADER_DATE_OFFSET, 0, (size_t) CENTRAL_FILE_HEADER_DATE_SIZE);

		    skip = tmp[CENTRAL_FILE_HEADER_FILENAME_SIZE_OFFSET] |
			(tmp[CENTRAL_FILE_HEADER_FILENAME_SIZE_OFFSET + 1] << 8);
		    skip += tmp[CENTRAL_FILE_HEADER_EXTRA_SIZE_OFFSET] |
			(tmp[CENTRAL_FILE_HEADER_EXTRA_SIZE_OFFSET + 1] << 8);
		    skip += tmp[CENTRAL_FILE_HEADER_FILE_COMMENT_SIZE_OFFSET] |
			(tmp[CENTRAL_FILE_HEADER_FILE_COMMENT_SIZE_OFFSET + 1] << 8);
		    tmp += CENTRAL_FILE_HEADER_SIZE + skip;
		}
	    }

	    retVal = (memcmp(p[0], p[1], (size_t) len)) ? 1 : 0;
	    munmap(p[0], (size_t) len);
	    munmap(p[1], (size_t) len);
	}
	else
	{
	    munmap(p[0], (size_t) len);
	}
    }

    return retVal;
}

static int
fileDiff(int (*fd)[2], off_t len)
{
    int retVal = -1;
    void *p[2];

    p[0] = mmap(NULL, (size_t) len, PROT_READ, MAP_PRIVATE, (*fd)[0], (off_t) 0);
    if (p[0])
    {
	p[1] = mmap(NULL, (size_t) len, PROT_READ, MAP_PRIVATE, (*fd)[1], (off_t) 0);
	if (p[1])
	{
	    retVal = (memcmp(p[0], p[1], (size_t) len)) ? 1 : 0;
	    munmap(p[0], (size_t) len);
	    munmap(p[1], (size_t) len);
	}
	else
	{
	    munmap(p[0], (size_t) len);
	}
    }

    return retVal;
}
