/************************************************************************
 * ExecutionEngine.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/


#ifndef EXECUTIONENGINE_H
#define EXECUTIONENGINE_H
#include <fstream>
#include <ExecutionRun.h>
#include <boost/thread/mutex.hpp> 
namespace TestAutomationFramework
{

#define RUN_ID_FILE "/usr/local/TAF/var/runId"

class ExecutionEngine
{
public:

	/**
	 * Empty Constructor
	 */
	ExecutionEngine();
	
    /** \brief Destructor - We stop all the runs which we have and then exit. 
    */
	virtual ~ExecutionEngine();
	
    /** \brief StartNewTestRun - This operation creates an ExecutionRun object, assigns a runID to it
     *  and starts the run on a new thread. The details of the current run are stored  in a list 
     */
	ExecutionRun* startNewTestRun(TestExecutionRequest & tereq);

    /** \brief For a given run id, this method will stop run and return true.
    * If the given run id is not found in the list or can not be stopped, then false is returned.
    */
	bool stopTestRun(int runId);
	
	
	/**
	 */
	list<ExecutionRun *> ListAllTestRuns() const
	{
		return m_currentRuns;
	}
	
    /** \brief Once a test run is completed ( or stopped) this method is invoked. It takes care of reporting the \
     * results all the report managers, unblocks all the nodes which were used in the test and cleans up the 
     * resources used by the run.
     */
	void processCompletedRun(ExecutionRun &completedRun);
	
    /** \brief This method will create the directory structure needed for storing the results of each run. It will also store the 
    * details about the run in text file for future reference. */   
    void provisionNewRun(TestExecutionRequest & tereq, int runId);
private:
    /**  \brief Generates a unique run id. It starts at 1 at each server restart.
	 */
	int generateRunId()
	{
        ofstream ofs(RUN_ID_FILE);
        ofs << m_runIdIndex;
		return m_runIdIndex++;
	}
    
    /** \brief Private assignment operator to avoid assignment */
    ExecutionEngine& operator=(const ExecutionEngine&);

    /** \brief Private copy constructor to avoid assignment */
    ExecutionEngine(const ExecutionEngine& rhs);
	
    /** \brief mutex to gaurd our current run list */
    boost::mutex m_currentRunListMutex;
    
    /** \brief List of our current runs */
    list<ExecutionRun *> m_currentRuns;
	
    /** \brief run id index */
    int m_runIdIndex;
};
	
}; // End of namespace

#endif // EXECUTIONENGINE_H
