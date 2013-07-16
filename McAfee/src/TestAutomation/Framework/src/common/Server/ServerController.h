/************************************************************************
* ServerController.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/


#ifndef SERVERCONTROLLER_H
#define SERVERCONTROLLER_H
#include <boost/thread/mutex.hpp>

#include <string>
#include <TestNode.h>
#include <TestExecutionRequest.h>
#include <NodeController.h>
#include <ExecutionEngine.h>
#include <ClientInterface.h>
#include <ServerConfigData.h>

namespace TestAutomationFramework
{
class ServerController
{
public:


    /** \brief Creates the server socket and waits for client requests.
     */
    void initialize ();

    /** \brief Adds a new test node to the test rig.
     * @param  newNode
     */
    TAF_ERROR_CODES addTestNode (TestNode newNode );
    
    /** \brief deletes a test node from the test rig
     * @param  testnode
     */
    TAF_ERROR_CODES deleteTestNode (TestNode testnode );
    
    /** \brief Returns all the test nodes present in the rig.
     */
    list<TestNode> listAllNodes ( );
    
    /** \brief Start the execution of given test suites on given test nodes.
     * @param  req
     */
    TAF_ERROR_CODES startTestExecution (TestExecutionRequest req, ExecutionRun  ** run);
    
    /** \brief Stops the execution of the test run
     * @param  req
     */
    TAF_ERROR_CODES stopTestExecution (int  runId);
    
    /** \brief Unblocks the nodes 
     *
     */
    void unblockNodes(vector<string> hostnames);

    /** \brief Get test node given a hostname
     *
     */
    TestNode  getNodeFromHostName(string hostname);
    
    /** \brief Returns all the runs which are active in the system
     */
    list<ExecutionRun *> listAllTestRuns ( );
    
    /** \brief Method to load our configration data */
    bool loadConfigurationData(string configFile);
    
    /** \brief Singleton enty point
     */
    static ServerController * getInstance ( );
  
    /** \brief destroys our instance 
     */
    static void releaseInstance ( );
 
    /** \brief dsignal handler for sigterm
     */   
    static void terminationHandler(int sig);


    /** \brief returns the SVN username */
    string getSVNUsername()
    {
        return m_configData.getSVNUsername();
    }
  
    /** \brief returns the SVN password */
    string getSVNPassword()
    {
        return m_configData.getSVNPassword();
    }
    
    /** \brief returns the servers ip */
    string getServerIP()
    {
        return m_configData.getServerIP();
    }    
    private:
    
    /**
     * Empty Constructor
     */
    ServerController ( );
    
    /**
     * Empty Destructor
     */
    virtual ~ServerController ( );
        
    /** \brief our intance pointer */
    static ServerController *m_pSelf;
    
    /** \brief mutex to gaurd  our singleton instance*/
    static boost::mutex m_instanceMutex;
    
    /** \brief This instance will have all our node information */
    NodeController m_nodeController;
    
    /** \brief This will have all our execution run details. */
    ExecutionEngine m_executionEngine;
    
    /** \brief This will act as mediator for all our client */
    ClientInterface *m_pClientInterface;
    
    /** \brief port num for our server SAP */
    int m_port;
    
    /** \brief object of our configuration data */
    ServerConfigData m_configData;
    

};
}; // End of namespace

#endif // SERVERCONTROLLER_H
