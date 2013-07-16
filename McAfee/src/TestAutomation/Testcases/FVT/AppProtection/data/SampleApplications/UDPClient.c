/*  
 *  Copyright (C) 2010 McAfee, Inc.  All rights reserved.
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

int main(int argc , char* argv[])
{
	
	if(argc<4)
	{ 
		printf("Provide hostIP and Port Number and Data");
		return -1;
	}
	int sock;
	struct sockaddr_in server_addr;
	struct hostent *host;
	char send_data[1024];

	host= (struct hostent *) gethostbyname(argv[1]);


	if ((sock = socket(AF_INET, SOCK_DGRAM, 0)) == -1)
	{
		perror("socket");
        return -1;
	}

	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(atoi(argv[2]));
	server_addr.sin_addr = *((struct in_addr *)host->h_addr);
	bzero(&(server_addr.sin_zero),8);

	if(sendto(sock, argv[3], strlen(argv[3]), 0,(struct sockaddr *)&server_addr, sizeof(struct sockaddr))==-1)
    {
       printf("sending data failed\n");
    	return -1;
    }
    else
    {
       printf("sending data is passed\n");
    }
    return 0;
}

