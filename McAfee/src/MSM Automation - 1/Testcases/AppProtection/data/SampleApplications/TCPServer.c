/*  
 *  Copyright (C) 2010 McAfee, Inc.  All rights reserved.
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>


int main(int argc, char *argv[])
{
         if(argc<3)
         { 
			 printf("Provide hostIP and Port Number");
			 return -1;
		 }
		int sock, connected, bytes_recieved , true = 1;  
        char  recv_data[1024];       

        struct sockaddr_in server_addr,client_addr;    
        size_t sin_size;
        struct hostent *host = gethostbyname(argv[1]);
 
        if ((sock = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
            perror("Socket");
            return -1;
          }

        if (setsockopt(sock,SOL_SOCKET,SO_REUSEADDR,&true,sizeof(int)) == -1) {
            perror("Setsockopt");
            return -1;       
        }
        
        server_addr.sin_family = AF_INET;         
        server_addr.sin_port = htons(atoi(argv[2]));     
        server_addr.sin_addr=*((struct in_addr *)host->h_addr);
        bzero(&(server_addr.sin_zero),8); 

        if (bind(sock, (struct sockaddr *)&server_addr, sizeof(struct sockaddr))
                                                                       == -1) {
            perror("Unable to bind");
            close(sock);
            return -1;
        }

        if (listen(sock, 5) == -1) {
            perror("Listen");
            return -1;
        }
		
	    printf("\nTCPServer Waiting for client on port %d \n",ntohs(server_addr.sin_port));
        fflush(stdout);
        while(1)
        {  
            sin_size = sizeof(struct sockaddr_in);

            connected = accept(sock, (struct sockaddr *)&client_addr,&sin_size);

            printf("\n I got a connection from (%s , %d)",
                   inet_ntoa(client_addr.sin_addr),ntohs(client_addr.sin_port));

              bytes_recieved = recv(connected,recv_data,1024,0);

              recv_data[bytes_recieved] = '\0';

              if (strcmp(recv_data , "q") == 0 || strcmp(recv_data , "Q") == 0)
              {
                close(connected);
                break;
              }

              else 
              printf("\n RECIEVED DATA = %s\n " , recv_data);
              fflush(stdout);
        }       

      close(sock);
      return 0;
}
