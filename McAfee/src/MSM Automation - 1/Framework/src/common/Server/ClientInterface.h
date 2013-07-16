/************************************************************************
* ClientInterface.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/


#ifndef CLIENTINTERFACE_H
#define CLIENTINTERFACE_H

#include <string>

#include <UDPServer.h>
namespace TestAutomationFramework
{
class ClientInterface
{
public:

     /**
     * \brief Empty Constructor
     */
    ClientInterface (int port );

    /**
     * \brief Empty Destructor
     */
    virtual ~ClientInterface ( );

    /** \brief Waits for client requests on the given socket. 
     * When the message arrives, reads the message headers and 
     * calls appropriate handler function
     */
    void getClientRequests ( );

    /** \brief Sets the termination variable to true and shutsdown the sever socket.
     */
    void terminate();
    
    /** \brief handles the test node addition request from CLI and responds to it. 
     */
    void handleAddNodeRequest (size_t datasize);
    
    /** \brief handles the test node deletion request from CLI and responds to it. 
     */
    void handleNodeDeletion ( size_t datasize);
   
    /** \brief handles the test node list request from CLI and responds to it.
     */
    void handleListNodes (size_t datasize );

    /** \brief handles thestart test run request from CLI and responds to it.
     */
    void handleStartTestRun (size_t datasize );
    
    /** \brief handles the stop test run request from CLI and responds to it.
     */
    void handleStopTestRun (size_t datasize );
    
    /** \brief handles the list test run request from CLI and responds to it.
     */
    void handleListTestRuns ( size_t datasize);

    
    private:
    /** \brief port where our server will provide service */
    int m_port;
        
    /** \brief our server socket */
    UDPServer m_server;
        
    /** \brief flag to handle termination */
    bool m_terminate;
        
};
}; // End of namespace
#endif // CLIENTINTERFACE_H


