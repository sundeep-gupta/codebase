/************************************************************************
 * UDPClient.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/

#include <UDPClient.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <MSGHeader.h>
namespace TestAutomationFramework
{

// Constructor
UDPClient::UDPClient(int port, string serverip):
    m_port(port),
    m_serverIp(serverip)
{

    bzero(&m_serversaddr_in,sizeof(struct sockaddr_in));
    if ((m_fd=socket(AF_INET, SOCK_DGRAM, 0))==-1)
    {
        // TODO cleanup and do proper error handling
        printf("\n Failed to create socket \n");
        exit(-1);
    }
    m_serversaddr_in.sin_family = AF_INET;
    m_serversaddr_in.sin_port=m_port;
    if (inet_aton(m_serverIp.c_str(), &m_serversaddr_in.sin_addr)<=0) 
    {
        printf( "inet_aton() failed\n");
        exit(1);
    }
    // ADDR to recieve response from server.
    bzero(&m_clientaddr,sizeof(struct sockaddr_in));
    m_clientaddr.sin_family = AF_INET;
    m_clientaddr.sin_addr.s_addr=htonl(INADDR_ANY);
    m_clientaddr.sin_port = htons(0);  
    
    if (bind(m_fd, (struct sockaddr *)&m_clientaddr, sizeof(m_clientaddr))==-1)
    {
        printf("\n bind failed\n");
        exit(-1);
    }
    
}
void 
UDPClient::sendDataToServer(size_t len, char * data)
{    
    socklen_t slen = sizeof(struct sockaddr_in);
    if(sendto(m_fd,data,len,0,(struct sockaddr*) &m_serversaddr_in,slen) == -1)
    {
        printf("\n Error in sending data %s\n",strerror(errno));
        exit(-1);
    }
  
}  
void
UDPClient::getDataFromServer(size_t len, char * buffer)
{
    socklen_t slen;
    struct sockaddr_in saddr;
    saddr.sin_port = htons(m_port);
    saddr.sin_family=AF_INET;
    saddr.sin_addr.s_addr=ntohl(INADDR_ANY);
    if(recvfrom(m_fd, buffer,len, 0, (struct sockaddr *)&saddr,&slen) == -1)
    {
        printf("\n Error in getting data\n");
        exit(-1);
    }
}
//Destructor
UDPClient::~UDPClient()
{
    if(m_fd >=0)
    {
        close(m_fd);
    }
}
MessageType 
UDPClient::getMessagesFromServer(size_t &datasize)
{    
    socklen_t slen;

    MSGHeader hdr;
    struct sockaddr_in addr;
    bzero(&addr,sizeof(struct sockaddr_in));

    if(recvfrom(m_fd, &hdr,sizeof(hdr), 0, (struct sockaddr *)&addr,&slen) == -1)
    {
        printf("\n Error in receving data %s\n",strerror(errno));
        exit(-1);
    }
    datasize=hdr.m_dataSize;
    return hdr.m_type;
    
}

}; // End of namespace
