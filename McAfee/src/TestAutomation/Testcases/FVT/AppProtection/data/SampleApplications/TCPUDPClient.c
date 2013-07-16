/*  
 *  Copyright (C) 2010 McAfee, Inc.  All rights reserved.
 */

#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>

#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>


int main(int argc , char *argv[])

{
	if(argc<5)
	{ 
		printf("Provide Protocol (UDP|TCP) hostIP and Port Number and data");
		return -1;
	}  

    int sock;  
    struct hostent *host;
	host = gethostbyname(argv[2]);
	struct sockaddr_in server_addr;
    server_addr.sin_family = AF_INET;     
    server_addr.sin_port = htons(atoi(argv[3]));   
    server_addr.sin_addr = *((struct in_addr *)host->h_addr);
    bzero(&(server_addr.sin_zero),8); 
	
	if (strcmp(argv[1], "TCP") == 0)
	{		
        if ((sock = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
            perror("Socket");
            return -1;
         }
		if (connect(sock, (struct sockaddr *)&server_addr,
					sizeof(struct sockaddr)) == -1)
		{
			perror("Connect");
			close(sock);
			return -1;
		}
		
		if(send(sock,argv[4],strlen(argv[4]), 0)==-1)
		{
			printf("sending data failed..\n");
			return -1;
		}
		
	}
	else if (strcmp(argv[1], "UDP") == 0)
	{
		if ((sock = socket(AF_INET, SOCK_DGRAM, 0)) == -1)
		{
			perror("socket");
			return -1;
		}
		if(sendto(sock, argv[4], strlen(argv[4]), 0,(struct sockaddr *)&server_addr, sizeof(struct sockaddr))==-1)
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
	else {
		printf("it allows only TCP/UDP protocols");
	}
	
    close(sock);
	return 0;
}


