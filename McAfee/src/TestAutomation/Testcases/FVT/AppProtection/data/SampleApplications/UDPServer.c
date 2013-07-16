/*
 *  Copyright (C) 2010 McAfee, Inc.  All rights reserved.
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
		if(argc<3)
		{ 
			printf("Provide hostIP and Port Number");
			return -1;
		}
	    int sock;
        int addr_len, bytes_read;
        char recv_data[1024];
        struct sockaddr_in server_addr , client_addr;
        struct hostent *host = gethostbyname(argv[1]);

        if ((sock = socket(AF_INET, SOCK_DGRAM, 0)) == -1) {
            perror("Socket");
            return -1;
        }

        server_addr.sin_family = AF_INET;
        server_addr.sin_port = htons(atoi(argv[2]));
        server_addr.sin_addr =*((struct in_addr *)host->h_addr);
        bzero(&(server_addr.sin_zero),8);


        if (bind(sock,(struct sockaddr *)&server_addr,
            sizeof(struct sockaddr)) == -1)
        {
            perror("Bind");
            return -1;
        }

        addr_len = sizeof(struct sockaddr);
		
	printf("\nUDPServer Waiting for client on port %d",ntohs(server_addr.sin_port));
        fflush(stdout);

	while (1)
	{

          bytes_read = recvfrom(sock,recv_data,1024,0,
	                    (struct sockaddr *)&client_addr, &addr_len);
	  

		  recv_data[bytes_read] = '\0';

          printf("\n(%s , %d) said : ",inet_ntoa(client_addr.sin_addr),
                                       ntohs(client_addr.sin_port));
          printf("%s", recv_data);
          if (strcmp(recv_data , "q") == 0 || strcmp(recv_data , "Q") == 0)
              {
                break;
              }

		  fflush(stdout);

     }
       close(sock);
        return 0;
}

