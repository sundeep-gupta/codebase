/************************************************************************
* NodeController.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/

#include "NodeController.h"
#include <STAFInterface.h>

#include <fstream>
#include <boost/serialization/list.hpp>
using namespace std;

#include "trace.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables();
namespace TestAutomationFramework
{
#define INITIAL_NODE_ID 1000
// Constructors/Destructors
//  

NodeController::NodeController ( ) 
{
    loadNodeInformation();
}

NodeController::~NodeController ( ) 
{
    persistNodeInformation();
}

/**
 */
void 
NodeController::loadNodeInformation ( )
{
    trace(serverTrace,1,"Entering NodeController::loadNodeInformation");
    try
	{
			std::ifstream ifs(NODE_INFORMATION_FILE);
			if(ifs.is_open() == true)
			{
				boost::archive::text_iarchive ia(ifs);
				ia >> m_nodeIdIndex;
				ia >> m_nodeVector;
				ifs.close();
			}
			else 
			{
				m_nodeIdIndex = INITIAL_NODE_ID;
			}
    }
	catch(boost::archive::archive_exception &e)
	{
		trace(serverTrace,1,"NodeController::loadNodeInformation - got boost archive exception.");
	}
    trace(serverTrace,1,"Exiting NodeController::loadNodeInformation");

}

/**
 */
void 
NodeController::persistNodeInformation ( )
{
    trace(serverTrace,1,"Entering NodeController::persistNodeInformation");
	try
	{
		std::ofstream ofs(NODE_INFORMATION_FILE);
		if(ofs.is_open() == true)
		{
			boost::archive::text_oarchive oa(ofs);
			oa << m_nodeIdIndex;
			oa << m_nodeVector;
			ofs.close();
		}
	}
	catch(boost::archive::archive_exception &e)
	{
		trace(serverTrace,1,"NodeController::persistNodeInformation - got boost archive exception.");
	}
    trace(serverTrace,1,"Exiting NodeController::persistNodeInformation");

}
/** \brief Get test node given a hostname
 *
 */
TestNode  
NodeController::getNodeFromHostName(string hostname)
{
    trace(serverTrace, 1,"NodeController::getNodeFromHostName invoked for hostname=%s",hostname.c_str());
    // lock
    boost::mutex::scoped_lock lck(m_nodeVectorMutex);
    // Check duplicates
    list<TestNode>::iterator iter;
    for(iter = m_nodeVector.begin() ; iter != m_nodeVector.end() ;iter++)
    {
        if(iter->getHostName() == hostname)
        {
            trace(serverTrace,1,"NodeController::getNodeFromHostName . Found the node . returning.");

            return (*iter);
        }
    }
    // No found. Lets return a blank node
    TestNode tempNode;
    trace(serverTrace,1,"NodeController::getNodeFromHostName .Did not find a node corresponding to the hostname = %s",hostname.c_str());

    return tempNode;
}
/** \brief Adds a new node to the rig
* @param  testnode
*/
TAF_ERROR_CODES 
NodeController::addNewNode(TestNode testnode)
{
    trace(serverTrace,1,"Entering NodeController::addNewNode");

    // lock
    boost::mutex::scoped_lock lck(m_nodeVectorMutex);
    
    // Check duplicates
    list<TestNode>::iterator iter;
    for(iter = m_nodeVector.begin() ; iter != m_nodeVector.end() ;iter++)
    {
        if(iter->getHostName() == testnode.getHostName())
        {
            trace(serverTrace,1,"NodeController::addNewNode Request to add duplicate node.");

            return TAF_DUPLICATE_NODE;
        }
    }

    // Check if the node is valid using Staf
    if (pingNode(testnode) != TAF_SUCCESS )
    {
        trace(serverTrace,1,"NodeController::addNewNode Request to add invalid node.");;
        
        // Do we need to cleanup the entry from staf config file ?
        return TAF_INVALID_NODE;
    }
    
    // Allocate a new node id;
    m_nodeIdIndex++;
    testnode.setNodeId(m_nodeIdIndex);
    testnode.setNodeStatus(eFree);
    
    m_nodeVector.push_back(testnode);
    trace(serverTrace,1,"Exiting NodeController::addNewNode");
    return TAF_SUCCESS;


}

/** \brief deletes node from the rig
* @param  testnode
*/
TAF_ERROR_CODES 
NodeController::deleteTestNode (TestNode testnode )
{
    trace(serverTrace,1,"Entering NodeController::deleteTestNode");

    // lock the vector
    boost::mutex::scoped_lock lck(m_nodeVectorMutex);
    //Check if node exists 
    list<TestNode>::iterator iter;
    bool found = false;
    for(iter = m_nodeVector.begin() ; iter != m_nodeVector.end() ;iter++)
    {
        trace(serverTrace,3,"NodeController::deleteTestNode Looking for %s and found %s",testnode.getHostName().c_str(),iter->getHostName().c_str());
        if(iter->getHostName() == testnode.getHostName())
        {
            found = true;
            break;
        }
    }
    if(found == true)
    {
        m_nodeVector.erase(iter);
        trace(serverTrace,1,"Exiting NodeController::deleteTestNode");
        return TAF_SUCCESS;
    }
    else 
    {
        trace(serverTrace,1,"Exiting NodeController::deleteTestNode  - No such node");
        return TAF_UNKNOWN_NODE;
    }

}


/** \brief lists all the nodes which are part of the rig
 */
list<TestNode> 
NodeController::getAllNodes ( )
{
    trace(serverTrace,1,"Entering NodeController::getAllNodes");

    // Lock and return a copy
    boost::mutex::scoped_lock lck(m_nodeVectorMutex);
    trace(serverTrace,1,"Exiting NodeController::getAllNodes");

    return m_nodeVector;
}


/** \brief Checks if the given node is alive or not.
*/
TAF_ERROR_CODES 
NodeController::pingNode (TestNode node )
{
    trace(serverTrace,1,"Entering NodeController::pingNode");
    if (STAFInterface::getInstance()->pingTestNode(node.getHostName()) == true)
    {
        trace(serverTrace,1,"Exiting NodeController::pingNode - returning pass");

        return TAF_SUCCESS;
    }
    else 
    {
        trace(serverTrace,1,"Exiting NodeController::pingNode - returning fail");
        return TAF_INVALID_NODE;
    }


}
    
    
/**
 * \brief Hostnames will be passed. If all are valid nodes and alive then we return true
* If even one is wrong we return false;
 */ 
bool 
NodeController::blockNodesForRun(vector<string> hostnames)
{
    trace(serverTrace,1,"Entering NodeController::blockNodesForRun");
    
    boost::mutex::scoped_lock lck(m_nodeVectorMutex);
    for(int i = 0; i < hostnames.size() ; i++)
    {
        //Check if node exists 
        list<TestNode>::iterator iter;
        bool found = false;
        for(iter = m_nodeVector.begin() ; iter != m_nodeVector.end() ;iter++)
        {
            if(iter->getHostName() == hostnames[i])
            {
                if(iter->getNodeStatus() != eFree || pingNode(*iter) != TAF_SUCCESS)
                {
                    
                    trace(serverTrace,1," NodeController::blockNodesForRun returning false");
                    return false;
                }
                else 
                {
                    found = true;
                }

    
            }
        }
        if(found == false)
        {
            trace(serverTrace,1," NodeController::blockNodesForRun Match not found");
            return false;
        }
    }
    for(int i = 0; i < hostnames.size() ; i++)
    {
        list<TestNode>::iterator iter;

        for(iter = m_nodeVector.begin() ; iter != m_nodeVector.end() ;iter++)
        {
            if(iter->getHostName() == hostnames[i])
            {
                trace(serverTrace,1," NodeController::blockNodesForRun markins status as busy");
                iter->setNodeStatus(eBusy);
                break;
            }
            
        }
    }
    trace(serverTrace,1,"Entering NodeController::blockNodesForRun returning true");
    return true;
}   
/** \brief marks the nodes as free */
void 
NodeController::unblockNodes(vector<string> hostnames) 
{
    trace(serverTrace,1,"Entering NodeController::unblockNodes");

    boost::mutex::scoped_lock lck(m_nodeVectorMutex);

    for(int i = 0; i < hostnames.size() ; i++)
    {
        list<TestNode>::iterator iter;

        for(iter = m_nodeVector.begin() ; iter != m_nodeVector.end() ;iter++)
        {
            if(iter->getHostName() == hostnames[i])
            {
                iter->setNodeStatus(eFree);
                break;
            }
        }
    }
    trace(serverTrace,1,"Exiting NodeController::unblockNodes");
}

}; // End of namespace
