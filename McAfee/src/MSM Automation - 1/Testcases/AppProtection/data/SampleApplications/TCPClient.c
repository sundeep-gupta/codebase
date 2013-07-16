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

		if(argc<4)
		{ 
			printf("Provide hostIP and Port Number and data");
			return -1;
		}  
	    int sock;  
        char send_data[1024];
        struct hostent *host;
        struct sockaddr_in server_addr;  

        host = gethostbyname(argv[1]);

        if ((sock = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
            perror("Socket");
            return -1;
         }

        server_addr.sin_family = AF_INET;     
        server_addr.sin_port = htons(atoi(argv[2]));   
        server_addr.sin_addr = *((struct in_addr *)host->h_addr);
        bzero(&(server_addr.sin_zero),8); 

        if (connect(sock, (struct sockaddr *)&server_addr,
                    sizeof(struct sockaddr)) == -1) 
        {
            perror("Connect");
            close(sock);
            return -1;
        }

       if(send(sock,argv[3],strlen(argv[3]), 0)==-1)
       {
          printf("sending data failed..\n");
          return -1;
       } 
	   return 0;
}


