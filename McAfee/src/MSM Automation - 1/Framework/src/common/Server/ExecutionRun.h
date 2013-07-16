/************************************************************************
 * ExecutionRun.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/

#ifndef EXECUTION_RUN_H
#define EXECUTION_RUN_H

#include <TestExecutionRequest.h>
#include <ExecutionSequence.h>
#include <map>

#include <boost/thread.hpp>

using namespace std;

namespace TestAutomationFramework 
{
//forward declaration
class ExecutionEngine;

/** \brief Each object of this class represents an test execution run */

class ExecutionRun
{
public:
	/** \brief Constructor to create ExecutionRun object
	 */
	explicit ExecutionRun(ExecutionEngine * pEngine);
	
	/** \brief Empty constructor
	 */
	ExecutionRun();
	
	/** \brief Empty destructor
	 */
	~ExecutionRun();
	
    /** \brief Initialize execution of test run by performing the processing in another thread without blocking the
    main thread.  The idea is to create a thread which will then create one child thread per host.
    Each child thread will actually run all the testcases in the corresponding host.  The parent thread
    will wait until all the processing on child threads are done.
    */
	void startTestRun();
	
	/** \brief Method to stop test run
	 */
	void stopTestRun();
	
	/** \brief Method to set test request
	 */
	void setTestRequest(TestExecutionRequest &tereq)
	{
		m_request = tereq;
	}
	
	/** \brief Method to get test request
	 */
	TestExecutionRequest& getTestRequest()
	{
		return m_request;
	}
	
	/** \brief Method to get execution result sequence map.
	 Provides execution result sequence for each host name
	 */
	map<string, ExecutionSequence*>& getExecutionSequenceMap()
	{
		return m_execSequenceMap;
	}
	
	/** \brief Method to set Run ID.
	 */
	void setRunId(int id)
	{
		m_runId = id;
	}
	
	/** \brief Method to get Run ID.
	 */
	int getRunId() const
	{
		return m_runId;
	}
	
	/** \brief Method to set SVN checkout path
	 */
	void setSvnCheckOutPath(const string &svnCheckoutpath)
	{
		m_svnCheckOutPath = svnCheckoutpath;
	}
	
	/** \brief Method to get SVN checkout path
	 */
	string getSvnCheckOutPath() const
	{
		return m_svnCheckOutPath;
	}
	
	/** \brief Method to get Run status
	 */
	TEST_RUN_STATUS getRunStatus() const
	{
		return m_runStatus;
	}
	
	/** \brief Equal operator overloading
	 */
	bool operator==(ExecutionRun run)
	{
		return (run.getRunId() == getRunId());
	}
	
private:
	
	/** \brief Making assignment operator private
	 */
	ExecutionRun& operator=(const ExecutionRun&);
	
	/** \brief Making copy constructor private
	 */
	ExecutionRun(const ExecutionRun& rhs);
	
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
 	static void *executionThreadEntry(void *p);
	
	/** \brief Execute test sequence for given test node
	 */
    static void * executeNodeTestSequence(void * arg);
	
	/** \brief Map container with host name and its corresponding execution sequence. */
	map<string, ExecutionSequence*> m_execSequenceMap;
	
	/** \brief the status of this run */
	TEST_RUN_STATUS m_runStatus;
	
	/** \brief The request which triggered this run */
	TestExecutionRequest m_request;
	
	/** \brief Unique id which differentiates this run.*/
	int m_runId;
	
	/** \brief Svn checkout path for this execution run. */
	string m_svnCheckOutPath; 
	
	/** \brief thread identifier for this run. */
    pthread_t m_parentThread;
	
	/** \brief Map container with host name and its processing thread. */
	map<string, pthread_t> m_threadMap;
	
	/** \brief Reference to our execution engine. */
	ExecutionEngine *m_pEngine;
	
	/** \brief Reference to input test sequence. */
	ExecutionSequence *m_testSequence;
    
    /** \brief struct to pass the data to our node sequene handler threads.
     */
     struct threadData
     {
        ExecutionRun * pSelf;
        string          hostname;
     };
};
	
};


#endif
