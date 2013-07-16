#include <sys/vfs.h>
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"


MODULE = Mytest5		PACKAGE = Mytest5		

void
statfs(path)
	char* path
INIT:
	int i;
	struct statfs buf;
PPCODE:
	i = statfs(path, &buf);
	if (i==0) {
	
			XPUSHs(sv_2mortal(newSVnv(buf.f_bavail)));
			XPUSHs(sv_2mortal(newSVnv(buf.f_bfree)));
			XPUSHs(sv_2mortal(newSVnv(buf.f_blocks)));
			XPUSHs(sv_2mortal(newSVnv(buf.f_bsize)));
			XPUSHs(sv_2mortal(newSVnv(buf.f_ffree)));
			XPUSHs(sv_2mortal(newSVnv(buf.f_files)));
			XPUSHs(sv_2mortal(newSVnv(buf.f_type)));
	} else {
		XPUSHs(sv_2mortal(newSVnv(errno)));	
	}