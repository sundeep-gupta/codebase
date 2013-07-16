/************************************************************************
 * UDPServer.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/
#ifndef UDPSERVER_H
#define UDPSERVER_H

using namespace std;
#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <MSGHeader.h>
namespace TestAutomationFramework
{

class UDPServer 
{
    public:
    // Constructor
    UDPServer(int port);
    
    //Destructor
    ~UDPServer();
    
    // Start listening for client requests;
    // This will be a blocking call.
    MessageType waitForClientRequests(size_t &datasize);
    
    // Send data specified in the data buffer to the client we are connected to
    void sendDataToClient(size_t type, const char* data);
   
    // This reads len bytes of data into buffer.
    void getDataFromClient(size_t len, char * buffer);  
    
    //This method will close the server
    void terminate();
    
    private:
    
    // client address is stored in thei variable. We will be serving only cone client at any point of time.
    struct sockaddr_in m_clientaddr;
    
    // FD representing the scoket
    int m_fd;
    
    // sockaddr_in for server
    struct sockaddr_in m_serversaddr_in;
    
    // port num where we are supposed to listen/send to.
    int m_port;
    
    // flag to tell us if we need to terminate
    bool m_terminate;
};
}; // End of namespace
#endif
