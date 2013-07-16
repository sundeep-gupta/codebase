/*
 *  Copyright (C) 2010 McAfee, Inc.  All rights reserved.
 */
#include <stdio.h>
#include <curl/curl.h>
#include <curl/types.h>
#include <curl/easy.h>
 
 
struct FtpFile {
  const char *filename;
  FILE *stream;
};
 
static size_t my_fwrite(void *buffer, size_t size, size_t nmemb, void *stream)
{
  struct FtpFile *out=(struct FtpFile *)stream;
  if(out && !out->stream) {
    /* open file for writing */ 
    out->stream=fopen(out->filename, "wb");
    if(!out->stream)
      return -1; /* failure, can't open file to write */ 
  }
  return fwrite(buffer, size, nmemb, out->stream);
}
 
 
int main(void)
{
  CURL *curl;
  CURLcode res;
  struct FtpFile ftpfile={
    "curl.tar.gz", /* name to store the file as if succesful */ 
    NULL
  };
 
  curl_global_init(CURL_GLOBAL_DEFAULT);
 
  curl = curl_easy_init();
  if(curl) {
   
    curl_easy_setopt(curl, CURLOPT_URL,
                     "ftp://ftp.sunet.se/pub/www/utilities/curl/curl-7.9.2.tar.gz");
    /* Define our callback to get called when there's data to be written */ 
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, my_fwrite);
    /* Set a pointer to our struct to pass to the callback */ 
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &ftpfile);
 
    /* Switch on full protocol/debug output */ 
    curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
 
    res = curl_easy_perform(curl);
 
    /* always cleanup */ 
    curl_easy_cleanup(curl);
 
    if(CURLE_OK != res) {
      /* we failed */ 
      printf("curl told us %d\n", res);
	 return res;
    }
  }
	return 0;
}
