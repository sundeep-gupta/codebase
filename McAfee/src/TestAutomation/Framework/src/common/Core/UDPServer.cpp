/************************************************************************
 * UDPServer.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/

#include <UDPServer.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <MSGHeader.h>
namespace TestAutomationFramework
{

// Constructor
UDPServer::UDPServer(int port):
    m_port(port),
    m_terminate(false)
{
    bzero(&m_serversaddr_in,sizeof(struct sockaddr_in));
    if ((m_fd=socket(AF_INET, SOCK_DGRAM, 0))==-1)
    {
        // TODO cleanup and do proper error handling
        printf("\n Failed to create socket \n");
        exit(-1);
    }
    m_serversaddr_in.sin_family = AF_INET;
    m_serversaddr_in.sin_addr.s_addr = htonl(INADDR_ANY);
    m_serversaddr_in.sin_port=m_port;
    
    // ADDR to recieve response from server.
    bzero(&m_clientaddr,sizeof(struct sockaddr_in));

    if (bind(m_fd, (struct sockaddr *)&m_serversaddr_in, sizeof(m_serversaddr_in))==-1)
    {
        printf("\n bind failed\n");
        exit(-1);
    }


}
    
//Destructor
UDPServer::~UDPServer()
{
    m_terminate = true;
    if(m_fd >=0)
    {
        close(m_fd);
    }
}

void
UDPServer::terminate()
{
    m_terminate = true;
}
void 
UDPServer::sendDataToClient(size_t len, const char * data)
{    
    
    if(sendto(m_fd,data,len,0,(struct sockaddr*) &m_clientaddr,sizeof(struct sockaddr_in)) == -1)
    {
        printf("\n Error in  sending data to specific command %s\n",strerror(errno));
        exit(-1);
    }


}

void
UDPServer::getDataFromClient(size_t len, char * buffer)
{
    socklen_t slen;
    struct sockaddr_in saddr;

    if(recvfrom(m_fd, buffer,len, 0, (struct sockaddr *)&saddr,&slen) == -1)
    {
        printf("\n Error in getting data\n");
        exit(-1);
    }
}

MessageType  
UDPServer::waitForClientRequests(size_t &datasize)
{    
    
    while (m_terminate == false)
    {        
        int retval = 0;
        int n = 0;
        fd_set fdR;
        FD_ZERO(&fdR);
        FD_SET(m_fd, &fdR);
        // Lets set a timeout of 5 sec.
        
        struct timeval tv = { 5,0 };
        retval = select(m_fd + 1, &fdR, NULL, NULL, &tv);
        if(retval == 0)
        {
            //timedout;
            continue;
        }
        else if (retval < 0) 
        {
            if (errno == EINTR) 
            {
                continue;
            }
            printf("\n select failed \n");
            exit(-1);
        }
        else if (FD_ISSET(m_fd, &fdR))
        {
            static char *pmsgstart = NULL, *p1 = NULL, *p2 = NULL;
            /*receive message from network*/
            memset(&m_clientaddr, 0, sizeof(struct sockaddr_in));
            socklen_t len = sizeof(struct sockaddr_in);
            // Lets read the message header first
            MSGHeader hdr;
            n= recvfrom(m_fd, &hdr, sizeof(hdr), 0,
                        (struct sockaddr*)&m_clientaddr, &len);
            
            //printf(" Got a message of type %d from %s:%d\n",
            //       hdr.m_type, inet_ntoa(m_clientaddr.sin_addr), ntohs(m_clientaddr.sin_port));
            datasize = hdr.m_dataSize;
            return hdr.m_type;
            
        }/*if ISSET(sockfd_dvs)*/
    }/*while*/
    
}
}; // End of namespace
