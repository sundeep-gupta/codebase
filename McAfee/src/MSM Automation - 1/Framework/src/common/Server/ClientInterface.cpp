/************************************************************************
* ClientInterface.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/
#include "ClientInterface.h"
#include <TestNode.h>
#include <TestNodeDetails.h>
#include <ServerController.h>
#include <TestRunDetails.h>
#include "trace.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables();
namespace TestAutomationFramework
{
/**
* \brief Empty Constructor
*/
ClientInterface::ClientInterface (int port ):
    m_server(port),
    m_port(port),
    m_terminate(false)
{
}
/**
* \brief Empty Destructor
*/
ClientInterface::~ClientInterface ( ) 
{
    m_terminate = true;
}

/** \brief Waits for client requests on the given socket. 
* When the message arrives, reads the message headers and 
* calls appropriate handler function
*/
void 
ClientInterface::getClientRequests ( )
{
    trace(serverTrace,1,"Entering ClientInterface::getClientRequests");
    while(m_terminate == false)
    {
        
        size_t datasize;
        MessageType msgType = m_server.waitForClientRequests(datasize);
        if(m_terminate == true)
        {
            break;
        }
        switch (msgType) 
        {
            case NODE_ADDITION_REQUEST:
                trace(serverTrace,2,"ClientInterface::getClientRequests - Received NODE_ADDITION_REQUEST");
                handleAddNodeRequest(datasize);
                break;
            case NODE_DELETION_REQUEST:
                trace(serverTrace,2,"ClientInterface::getClientRequests - Received NODE_DELETION_REQUEST");
                handleNodeDeletion(datasize);
                break;
            case NODE_LIST_REQUEST:
                trace(serverTrace,2,"ClientInterface::getClientRequests - Received NODE_LIST_REQUEST");
                handleListNodes(datasize);
                break;
            case START_TEST_REQUEST:
                trace(serverTrace,2,"ClientInterface::getClientRequests - Received START_TEST_REQUEST");
                handleStartTestRun(datasize);
                break;
            case STOP_TEST_REQUEST:
                trace(serverTrace,2,"ClientInterface::getClientRequests - Received STOP_TEST_REQUEST");
                handleStopTestRun(datasize);
                break;
            case LIST_TESTS_REQUEST:
                trace(serverTrace,2,"ClientInterface::getClientRequests - Received LIST_TESTS_REQUEST");
                handleListTestRuns(datasize);
                break;
            default:
              trace(serverTrace,2,"ClientInterface::getClientRequests - Received INVALID_REQUEST");

        }
    }

}

/** \brief Sets the termination variable to true and shutsdown the sever socket.
*/
void 
ClientInterface::terminate()
{
    trace(serverTrace,1,"Entering ClientInterface::terminate");
    m_terminate = true;
    m_server.terminate();
}

/** \brief handles the test node addition request from CLI and responds to it. 
 */
void 
ClientInterface::handleAddNodeRequest (size_t datasize )
{
    trace(serverTrace,1,"Entering ClientInterface::handleAddNodeRequest");
    char *buffer = new char[datasize+1];
    bzero(buffer, datasize+1);
    m_server.getDataFromClient(datasize, buffer);
    // create the node from the buffer
    bool retVal= false;

    try
    {
        TestNode node(buffer);
        
        if( ServerController::getInstance()->addTestNode(node) == TAF_SUCCESS )
        {
            retVal = true;
        }
        else 
        {
            retVal = false;
        }
    }
    catch(...)
    {
        trace(serverTrace,1,"ClientInterface::handleAddNodeRequest Unable to create test node object from the buffer");
        
    }
    // Create a response and send it to the client
    
    MSGHeader hdr;
    hdr.m_type = NODE_ADDITION_RESPONSE;
    hdr.m_dataSize = sizeof(bool);
    m_server.sendDataToClient(sizeof(hdr), (char *) &hdr);
    m_server.sendDataToClient(sizeof(bool), (char *) &retVal);
    trace(serverTrace,1,"Exiting ClientInterface::handleAddNodeRequest");
}


/** \brief handles the test node deletion request from CLI and responds to it. 
 */
void 
ClientInterface::handleNodeDeletion (size_t size)
{
    trace(serverTrace,1,"Entering ClientInterface::handleNodeDeletion");
    char * buffer = new char [size+1];
    bzero(buffer,size+1);
    // Lets just assume 1k buffer for now.
    m_server.getDataFromClient(size, buffer);
    // create the node from the buffer
    TestNode node;
    trace(serverTrace,3,"ClientInterface::handleNodeDeletion buffer = %s",buffer);
    node.setNodeHostName(string(buffer));
    delete [] buffer;
    
    bool retVal= false;
    if( ServerController::getInstance()->deleteTestNode(node) == TAF_SUCCESS )
    {
        retVal = true;
    }
    else 
    {
        retVal = false;
    }
    // Create a response and send it to the client
    
    MSGHeader hdr;
    hdr.m_type = NODE_DELETION_RESPONSE;
    hdr.m_dataSize = sizeof(bool);
    m_server.sendDataToClient(sizeof(hdr), (char *) &hdr);
    m_server.sendDataToClient(sizeof(bool), (char *) &retVal);
    trace(serverTrace,1,"Exiting ClientInterface::handleNodeDeletion");

}


/** \brief handles the test node list request from CLI and responds to it.
 */
void 
ClientInterface::handleListNodes (size_t datasize )
{
    trace(serverTrace,1,"Entering ClientInterface::handleListNodes");
    list<TestNode> nodelist = ServerController::getInstance()->listAllNodes();
    
    // Create a response and send it to the client
    TestNodeDetails nodeDetails;
    list<TestNode>::iterator iter;
    
    for(iter = nodelist.begin() ; iter != nodelist.end(); iter++)
    {
        nodeDetails.SetTestNode(*iter);
    }
    MSGHeader hdr;
    hdr.m_type = NODE_LIST_RESPONSE;
    const char * buffer = nodeDetails.getStreamDataTestNodeDetails();
	if(buffer)
	{
		hdr.m_dataSize=strlen(buffer);
    }
	else
	{
		hdr.m_dataSize=0;
	}
	m_server.sendDataToClient(sizeof(hdr), (char *) &hdr);
	if(hdr.m_dataSize)
		m_server.sendDataToClient(hdr.m_dataSize, buffer);
    trace(serverTrace,1,"Exiting ClientInterface::handleListNodes");

}


/** \brief handles the start test run request from CLI and responds to it.
 */
void 
ClientInterface::handleStartTestRun (size_t datasize )
{
    trace(serverTrace,1,"Entering ClientInterface::handletestRunStart for dat size = %d",datasize);
    
    char *buffer =new char [datasize+1];
    bzero(buffer,datasize+1);
    m_server.getDataFromClient(datasize, buffer);
     TestExecutionRequest tereq(buffer);

    TestRunDetails trstats;
    ExecutionRun *run=NULL;
    delete [] buffer;
    TestRunStatus tcrs;

    if( ServerController::getInstance()->startTestExecution(tereq,&run) != TAF_SUCCESS)
    {
        tcrs.setRunId(-1);
        tcrs.setRunStatus(INVALID);
        tcrs.setTestRequest(tereq);
    }
    else 
    {
        tcrs.setRunId(run->getRunId());
        tcrs.setRunStatus(run->getRunStatus());
        tcrs.setTestRequest(tereq);
        trace(serverTrace,1,"ClientInterface::handletestRunStart  - Started run with id = %d, status =%d",run->getRunId(),run->getRunStatus());

    }

    trstats.addTestRunStatus(tcrs);
    const char * anotherbuffer = trstats.getStreamDataForRunStats();
    MSGHeader hdr;
    hdr.m_type = START_TEST_RESPONSE;
	if(anotherbuffer)
	{
		hdr.m_dataSize=strlen(anotherbuffer);
    }
	else
	{
		hdr.m_dataSize=0;
	}
	m_server.sendDataToClient(sizeof(hdr), (char *) &hdr);
	if(hdr.m_dataSize)
		m_server.sendDataToClient(hdr.m_dataSize, anotherbuffer);
    
    trace(serverTrace,1,"Exiting ClientInterface::handletestRunStart");
}

/** \brief handles the stop test run request from CLI and responds to it.
 */
void 
ClientInterface::handleStopTestRun (size_t datasize )
{
    trace(serverTrace,1,"Entering ClientInterface::handleStopTestRun");

    // we expect int;
    int runId;
    bool retVal = false;
    m_server.getDataFromClient(sizeof(int),(char *)&runId);
    if(ServerController::getInstance()->stopTestExecution(runId) == TAF_SUCCESS)
    {
        retVal = true;
    }
    else
    {
        retVal = false;
    }
    // Create a response and send it to the client
    
    MSGHeader hdr;
    hdr.m_type = STOP_TEST_RESPONSE;
    hdr.m_dataSize = sizeof(bool);
    m_server.sendDataToClient(sizeof(hdr), (char *) &hdr);
    m_server.sendDataToClient(sizeof(bool), (char *) &retVal);

    trace(serverTrace,1,"Exiting ClientInterface::handleStopTestRun");
}

/**  \brief handles the list test run request from CLI and responds to it.
 */
void 
ClientInterface::handleListTestRuns (size_t datasize )
{
    trace(serverTrace,1,"Entering ClientInterface::handleListTestRuns");
    list<ExecutionRun*> currentRuns = ServerController::getInstance()->listAllTestRuns();
    TestRunDetails trstats;
    list<ExecutionRun *>::iterator iter;
    if(currentRuns.empty() == false)
    {
        for (iter = currentRuns.begin(); iter != currentRuns.end(); iter++)
        {
            TestRunStatus tcrs;
            tcrs.setRunId((*iter)->getRunId());
            tcrs.setRunStatus((*iter)->getRunStatus());
            tcrs.setTestRequest((*iter)->getTestRequest());
            trstats.addTestRunStatus(tcrs);
        }
    }
    const char * anotherbuffer = trstats.getStreamDataForRunStats();
    MSGHeader hdr;
    hdr.m_type = LIST_TESTS_RESPONSE;
	if(anotherbuffer)
	{
		hdr.m_dataSize=strlen(anotherbuffer);
    }
	else
	{
		hdr.m_dataSize=0;
	}
	m_server.sendDataToClient(sizeof(hdr), (char *) &hdr);
	if(hdr.m_dataSize)
		m_server.sendDataToClient(hdr.m_dataSize, anotherbuffer);
    

    trace(serverTrace,1,"Exiting ClientInterface::handleListTestRuns");
}


}; // End of namespace
