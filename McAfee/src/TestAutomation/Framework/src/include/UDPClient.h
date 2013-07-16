/************************************************************************
 * UDPClient.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/
 
#ifndef UDPCLIENT_H
#define UDPCLIENT_H

using namespace std;

#include <MSGHeader.h>
#include <TestNode.h>
#include <string>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
using namespace std;
namespace TestAutomationFramework
{

class UDPClient 
{
    public:
    // Constructor
    UDPClient(int port,string serverip);
    
    //Destructor
    ~UDPClient();
    
  
    // Receive data from server. This will block till server sends the data.
    MessageType getMessagesFromServer(size_t &datasize);  
      
    // Send data specified in the data buffer
    void sendDataToServer(size_t type, char* data);
   
    // This reads len bytes of data into buffer.
    void getDataFromServer(size_t len, char * buffer);  
    
    private: 
    // FD representing the socket
    int m_fd;
    
    // sockaddr_in for server/client
    struct sockaddr_in m_serversaddr_in;
    
    struct sockaddr_in m_clientaddr;
    
    // port num where we are supposed to listen/send to.
    int m_port;
    
    // ip of the server
    string m_serverIp;
};
}; // End of namespace
#endif
