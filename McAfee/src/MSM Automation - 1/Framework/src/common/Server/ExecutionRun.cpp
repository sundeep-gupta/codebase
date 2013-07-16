/************************************************************************
 * ExecutionRun.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/
#include <ExecutionRun.h>
#include <ExecutionSequence.h>
#include <boost/bind.hpp>
#include <ExecutionEngine.h>
#include "SVNInterface.h"

#include <ExecutionNodeRun.h>

#include "trace.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables();

namespace TestAutomationFramework 
{
	
ExecutionRun::ExecutionRun(ExecutionEngine * pEngine):
	m_runStatus(STARTING),
	m_pEngine(pEngine),
	m_parentThread(NULL)
{
	m_execSequenceMap.clear();
	m_threadMap.clear();
}

ExecutionRun::ExecutionRun():
	m_runStatus(STARTING),
	m_pEngine(NULL),
	m_parentThread(NULL)
{
	m_execSequenceMap.clear();
	m_threadMap.clear();
}     

ExecutionRun::~ExecutionRun()
{
}

/** \brief Initialize execution of test run by performing the processing in another thread without blocking the
 main thread.  The idea is to create a thread which will then create one child thread per host.
 Each child thread will actually run all the testcases in the corresponding host.  The parent thread
 will wait until all the processing on child threads are done.
 */
void ExecutionRun::startTestRun()
{
	trace(serverTrace,1,"ExecutionRun:startTestRun Entering Enginepointer=%p runptr=%p",m_pEngine,this);
	
	/** Create a thread which will do the processing.  Main thread will not be blocked for this. */
    pthread_create(&m_parentThread, NULL,  TestAutomationFramework::ExecutionRun::executionThreadEntry, this);
	trace(serverTrace,1,"ExecutionRun:startTestRun Exiting");
}


/** \brief The test run will be executed as follows:
 1.  Perform svn checkout of the testcase repository into a temporary server location.
 2.  Get an input execution sequence for processing by all hosts.
 3.  Create one thread per host and perform processing on the input execution sequence.
 4.  Block the current thread until all the host threads have performed their processing.
 5.  Remove the svn checkout directory
 6.  Inform the engine about completion of the run so that cleanup will be done.
 
 We are trying to do all common operations like SVN checkout, getting input execution sequence in this
 thread to avoid duplicate processing.  Wherever the host specific processing is involved, it will
 be done in the host thread.
 */
 void * ExecutionRun::executionThreadEntry(void * arg)
{
	trace(serverTrace,1,"ExecutionRun:executionthreadEntry Entering ");
	
    ExecutionRun *pSelf=static_cast<ExecutionRun *> (arg);
	/** Mark the test run status as RUNNING. */
	pSelf->m_runStatus = RUNNING;

	/** Perform SVN checkout in the server location. */
	SVNInterface svnObj(pSelf->m_request.getSvnPath());
	if(!svnObj.performSvnCheckout(pSelf->getRunId()))
	{
		pSelf->m_runStatus = COMPLETED;
		pSelf->m_pEngine->processCompletedRun(*pSelf);		
		return NULL;
	}

	pSelf->m_svnCheckOutPath = svnObj.getSvnCheckoutPath();
	pSelf->m_execSequenceMap.clear();
	
	vector<string> testNames = pSelf->m_request.getTestNames();
	
	/** Since the input execution sequence is same for all hosts for the same test run, we will 
	 just get the execution sequence once and copy the same for execution by each host.  We can try to
	 do the same in each host thread, but we are doing this way to avoid the processing involved
	 in getting the sequence.
	 Each host will operate on the copy of the sequence and update their results.  The results will
	 be stored in m_execSequenceMap to be used by the caller.
	 */
	pSelf->m_testSequence = new ExecutionSequence(pSelf->m_svnCheckOutPath, testNames);
	
	vector<string> hostNames = pSelf->m_request.getHostNames();
	
	/** Iterate thru host names and create thread for each host. Each thread will execute the input
	 sequence for the corresponding host.
	 */
	threadData tdata[hostNames.size()];
	trace(serverTrace,1,"ExecutionRun:executionthreadEntry: size of hosnames: %d",hostNames.size());
	for(int i=0; i<hostNames.size(); i++)
	{
		pthread_t threadId;
        
        tdata[i].pSelf=pSelf;
        tdata[i].hostname=hostNames[i];
		trace(serverTrace,1,"ExecutionRun:executionthreadEntry: hostnames: %s",hostNames[i].c_str());
        pthread_create(&threadId,NULL, ExecutionRun::executeNodeTestSequence, &tdata[i]);
		/** Store the thread ids for later use. */
        pSelf->m_threadMap.insert(make_pair(hostNames[i], threadId));
	}
	
	/** Block current thread until all the host threads processing is done. */
	for(int i=0; i<hostNames.size(); i++)
	{
		map<string, pthread_t>::iterator iter = (pSelf->m_threadMap).find(hostNames[i]);
		
		if(iter != pSelf->m_threadMap.end())
		{
            pthread_t threadId = iter->second;
            pthread_join(threadId,NULL);
        }
	}
	
	/** Delete the input execution sequence. */
	if(pSelf->m_testSequence)
	{	
		delete pSelf->m_testSequence;
		pSelf->m_testSequence = NULL;
	}
	pSelf->m_threadMap.clear();
	/** Delete the SVN checkout in the server location. */
	svnObj.removeSvnCheckout();
	
	/** Mark the test run status as completed. */
	pSelf->m_runStatus = COMPLETED;
	
	/** at the end, after completion, call the processCompleted Run method of ExecutionEngine */
	pSelf->m_pEngine->processCompletedRun(*pSelf);
	trace(serverTrace,1,"ExecutionRun:executionthreadEntry Exiting");
}

	
/** \brief Execute test sequence for given test node
*/
void * ExecutionRun::executeNodeTestSequence(void * arg)
{
    trace(serverTrace,1,"ExecutionRun:executeNodeTestSequence-Invoked");
	struct threadData *tData =  static_cast<struct threadData *>(arg);
    ExecutionRun  * pSelf = tData->pSelf;
    string hostName = tData->hostname;
	
	 trace(serverTrace,1,"ExecutionRun:executeNodeTestSequence-hostname:%s",hostName.c_str());
	/** Get a copy of input execution sequence for processing. */
	ExecutionSequence *nodeTestSequence = new ExecutionSequence(*(pSelf->m_testSequence));
	if(!nodeTestSequence)
		return NULL;
	
	/** Create object which will actually do the host related execution. */
	ExecutionNodeRun *nodeRun = new ExecutionNodeRun(hostName, nodeTestSequence, pSelf->getTestRequest().getBuildDmgPath(), pSelf->getSvnCheckOutPath(), pSelf->getRunId());
	if(!nodeRun)
		return NULL;
	
	/** Perform execution of test sequence in the host. */
	nodeRun->executeTestSequence();
	
	/** Get the result of the sequence. */
	ExecutionSequence *resTestSequence = new ExecutionSequence(*nodeRun->getResultTestSequence());
	if(!resTestSequence)
		return NULL;
	 
	/** Store the result in a container for use by caller. */
	pSelf->m_execSequenceMap.insert(make_pair(hostName, resTestSequence));
	
	delete nodeTestSequence;
	nodeTestSequence = NULL;
	
	delete nodeRun;
	nodeRun = NULL;
}

void ExecutionRun::stopTestRun()
{
	 trace(serverTrace,1,"ExecutionRun:stopTestRun-Invoked");
	/** Delete all the host threads and the parent thread to stop processing. */
	map<string, pthread_t>::iterator b = m_threadMap.begin();
	
	for(; b!=m_threadMap.end(); b++)
	{
		pthread_t pThread = b->second;
        pthread_cancel(pThread);
	}
	m_threadMap.clear();
    pthread_cancel(m_parentThread);

	
	/** Mark the test run status as stopped. */
	m_runStatus = STOPPED;
    
    m_pEngine->processCompletedRun(*this);
}

};


