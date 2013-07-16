/*
 *  Copyright (C) 2010 McAfee, Inc.  All rights reserved.
 */
#include <curl/curl.h>
#include <curl/types.h>
#include <curl/easy.h>
#include <string>
#include <iostream>
int CurlWriteFun(char *data, size_t size, size_t nmemb,std::string *receiveBuffer)
{
    if (receiveBuffer != NULL)
    {
        receiveBuffer->append(data, size * nmemb);
    }

    return (size * nmemb);
}

int main(void) {
  // ...
    CURL *curl;
    CURLcode res;
    curl = curl_easy_init();
   if (curl) {
    curl_easy_setopt(curl, CURLOPT_URL, "http://www.browsarity.com/");

    std::string response;
    //curl_easy_setopt(curl, CURLOPT_POSTFIELDS, m_data.c_str());
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, CurlWriteFun);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);

    res = curl_easy_perform(curl);
	   printf("Value of  Response %s\n",response.c_str());
  	  
  	curl_easy_cleanup(curl);
	   
	printf("return value of easy perform %d\n",res);
    // The "response" variable should now contain the contents of the HTTP response
  }
  return res;
}

