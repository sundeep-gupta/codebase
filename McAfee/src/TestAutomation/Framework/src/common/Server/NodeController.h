/************************************************************************
* NodeController.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/


#ifndef NODECONTROLLER_H
#define NODECONTROLLER_H


// STD headers
#include <list>
using namespace std;

// boost headers
#include <boost/thread/mutex.hpp>

// our headers
#include <ErrorCodes.h>
#include <TestNode.h>
#include <STAFInterface.h>
namespace TestAutomationFramework
{
/**
  * class NodeController
  * This class will capture all the business logic wrt to test nodes. It will be
  * responsible for keeping track of test node status in memory and also persist the
  * information on the disk.
  */

#define NODE_INFORMATION_FILE "/usr/local/TAF/var/testNodes"
class NodeController
{
public:

    /**
     *  Constructor
     */
    
    NodeController ( );

    /**
     * Empty Destructor
     */
    virtual ~NodeController ( );

    /** \brief Adds a new node to the rig
     * @param  testnode
     */
    TAF_ERROR_CODES addNewNode (TestNode testnode );


    /** \brief deletes node from the rig
     * @param  testnode
     */
    TAF_ERROR_CODES deleteTestNode (TestNode testnode );

    /** \brief lists all the nodes which are part of the rig
     */
    list<TestNode> getAllNodes ( );

    /** \brief Checks if the given node is alive or not.
     */
    TAF_ERROR_CODES pingNode (TestNode testnode);
    
    /**
     * \brief Hostnames will be passed. If all are valid nodes and alive then we return true
    * If even one is wrong we return false; If all are available we make them busy, before returning.
     */ 
    bool blockNodesForRun(vector<string> hostnames);
    
    /** \brief marks the nodes as free */
    void unblockNodes(vector<string> hostnames);
    
    /** \brief Get test node given a hostname
    *
    */
    TestNode  getNodeFromHostName(string hostname);
    private:
    
    /** \brief Loads the node information from the persistant store.
     */
    void loadNodeInformation ( );
    
    /** \brief Stores the node information to a persistant store
     */
    void persistNodeInformation ( ); 
    
    //list where we will keep our node information 
    list<TestNode> m_nodeVector;
    
    /** \brief mutex to gaurd the vecotr of nodes.*/
    boost::mutex m_nodeVectorMutex;;
    
    /** \brief node id index. */
    int m_nodeIdIndex;
      

};
}; // End of namespace

#endif // NODECONTROLLER_H
