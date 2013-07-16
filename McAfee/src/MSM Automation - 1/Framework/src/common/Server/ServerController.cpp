/************************************************************************
* ServerController.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/

#include "ServerController.h"
#include <UDPServer.h>
#include <MSGHeader.h>
#include <TestNode.h>
#include <ExecutionRun.h>
#include "trace.h"
#include "LibXmlWrapper.h"
#include <signal.h>
defineTraceFlag(serverTrace,5,"");
defineTraceVariables();

namespace TestAutomationFramework
{

ServerController * ServerController::m_pSelf = NULL;
boost::mutex ServerController::m_instanceMutex;

// Constructors/Destructors
//  

ServerController::ServerController ( ) 
{
}

ServerController::~ServerController ( ) 
{
    if(m_pClientInterface != NULL)
    {
        
        m_pClientInterface->terminate();
        delete m_pClientInterface;
        m_pClientInterface = NULL;
    }
}

bool
ServerController::loadConfigurationData(string configFile)
{
    bool retval = false;
    try
    {
        trace(serverTrace,3,"ServerController::loadConfigurationData  -Invoked ");
        
        LibXmlWrapper xmlParser(configFile.c_str());
        
        m_configData.setServerPort(xmlParser.getXPathUnsignedLongValue("/HarnessServerConfig/ServerPort"));
        m_configData.setServerIP(xmlParser.getXPathStringValue("/HarnessServerConfig/ServerIP"));
        m_configData.setTestLinklURL(xmlParser.getXPathStringValue("/HarnessServerConfig/TestLinkURL"));
        m_configData.setSVNPassword(xmlParser.getXPathStringValue("/HarnessServerConfig/SVNPassword"));
        m_configData.setSVNUsername(xmlParser.getXPathStringValue("/HarnessServerConfig/SVNUsername"));
        m_configData.setLogLevel(xmlParser.getXPathUnsignedLongValue("/HarnessServerConfig/LogLevel"));
        
        retval =true;
        trace(serverTrace,3,"ServerController::loadConfigurationData  -Invoked ");
    }
    catch(...)
    {
        trace(serverTrace,3,"ServerController::loadConfigurationData - Could not complete loading details from %s",
                configFile.c_str());
    }
    return retval;
}
/**
 */
 
ServerController * 
ServerController::getInstance ( )
{
    trace(serverTrace, 5,"ServerController::getInstance invoked ");

    if(m_pSelf == NULL)
    {
        boost::mutex::scoped_lock lck(m_instanceMutex);
        if(m_pSelf == NULL)
        {
            m_pSelf = new ServerController();
        }
    }
    trace(serverTrace, 5,"ServerController::getInstance exiting ");

    return m_pSelf;
}

/**
 */
void 
ServerController::releaseInstance ( )
{
    trace(serverTrace, 1,"ServerController::releaseInstance invoked ");
    if(m_pSelf != NULL)
    {
        boost::mutex::scoped_lock lck(m_instanceMutex);
        delete m_pSelf;
        m_pSelf = NULL;
    }
    trace(serverTrace, 1,"ServerController::releaseInstance exiting ");
}
/**
 */
void 
ServerController::initialize ()
{
    trace(serverTrace, 1,"ServerController::initialize invoked ");
    m_pClientInterface  = new ClientInterface(m_configData.getServerPort());
    // Just wait for client requests; This will block for ever.
    m_pClientInterface->getClientRequests();
}


/**
 * @param  newNode
 */
TAF_ERROR_CODES 
ServerController::addTestNode (TestNode newNode )
{
    trace(serverTrace, 1,"ServerController::addTestNode invoked ");
    return m_nodeController.addNewNode(newNode);
}


/**
 * @param  testnode
 */
TAF_ERROR_CODES 
ServerController::deleteTestNode (TestNode testnode )
{
    trace(serverTrace, 1,"ServerController::deleteTestNode invoked ");
    return m_nodeController.deleteTestNode(testnode);
}

/** \brief Get test node given a hostname
 *
 */
TestNode  
ServerController::getNodeFromHostName(string hostname)
{
    trace(serverTrace, 1,"ServerController::getNodeFromHostName invoked ");
    return m_nodeController.getNodeFromHostName(hostname);
}
/**
 */
list<TestNode> 
ServerController::listAllNodes ( )
{
    trace(serverTrace, 1,"ServerController::listAllNodes invoked ");
    return m_nodeController.getAllNodes();
}


/**
 * @param  req
 */
TAF_ERROR_CODES 
ServerController::startTestExecution (TestExecutionRequest req , ExecutionRun ** run)
{
    trace(serverTrace, 1,"ServerController::startTestExecution invoked ");
	
    // Check if test nodes are present and free
    if(m_nodeController.blockNodesForRun(req.getHostNames()) == true)
    {
        *run = m_executionEngine.startNewTestRun(req);
        return TAF_SUCCESS;
    }
    else 
    {
        return TAF_INVALID_NODE;
    }

}

/**
 * @param  req
 */
TAF_ERROR_CODES 
ServerController::stopTestExecution (int  runId)
{
    trace(serverTrace, 1,"ServerController::stopTestExecution invoked for run = %d",runId);
    if(m_executionEngine.stopTestRun(runId)==true)
    {
        return TAF_SUCCESS;
    }
    else 
    {
        return TAF_FAILURE;
    }

}

/**
 */
list<ExecutionRun*> 
ServerController::listAllTestRuns ( )
{
    trace(serverTrace, 1," ServerController::listAllTestRuns invoked");
    return m_executionEngine.ListAllTestRuns();
}


#pragma mark Signal handlers
/** \brief Static signal handler for handling SIGTERM. This method stops the FMP machinery and 
* sets the shutdown flag to true. 
*/
void ServerController::terminationHandler(int sig)
{
    if(sig == SIGTERM)
    {
        trace(serverTrace, 1," ServerController::terminationHandler - Recieved sigterm. Going down");
        ServerController::releaseInstance();
    }
}  

/** \brief Unblocks the nodes 
 *
 */
void 
ServerController::unblockNodes(vector<string> hostnames)
{
    m_nodeController.unblockNodes(hostnames);
}
}; // End of namespace
using namespace TestAutomationFramework;


#pragma mark Global methods
void usage(int argc,char ** argv)
{
    printf("%s <ConfigFilePath> \n",argv[0]);
}
int main(int argc, char ** argv)
{	
    initTrace("/usr/local/TAF/var/harnessServer.log");
    if(argc < 2)
    {
        usage(argc,argv);
        exit(-1);
    }
    signal(SIGTERM,ServerController::terminationHandler);
     // Get an instance of Server Controller
    if(ServerController::getInstance()->loadConfigurationData(string(argv[1])) == false)
    {
        cerr << "Unable to read configuration data properly" <<endl;
        return -1;
    }
    ServerController::getInstance()->initialize();
}

