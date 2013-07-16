/************************************************************************
 * ExecutionEngine.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/
#include "ServerController.h"
#include "ExecutionEngine.h"
#include "SMTPReportManager.h"
#include "LogReportManager.h"
#include "TestlinkReportManager.h"
#include "trace.h"
#include <fstream>
#include <sys/stat.h>
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables();

namespace TestAutomationFramework
{
// Constructors/Destructors
//  

ExecutionEngine::ExecutionEngine ( )
:m_runIdIndex(1)
{
    std::ifstream ifs(RUN_ID_FILE);
    trace(serverTrace,1,"ExecutionEngine::ExecutionEngine()");
    if(ifs.is_open()== true)
    {
        ifs >> m_runIdIndex;
        // We always store the last run id. So increment it to get a new number.
        m_runIdIndex++;
    }
    else 
    {
        m_runIdIndex = 1;
    }
    trace(serverTrace,1,"ExecutionEngine::ExecutionEngine() Starting with run id = %d",m_runIdIndex);
}

/** \brief Destructor - We stop all the runs which we have and then exit. 
 */
ExecutionEngine::~ExecutionEngine ( ) 
{
	list<ExecutionRun *>::iterator iter;
    boost::mutex::scoped_lock  lck(m_currentRunListMutex);
	for (iter = m_currentRuns.begin() ; iter != m_currentRuns.end() ; iter++)
	{
		(*iter)->stopTestRun();
	}
}

/** \brief StartNewTestRun - This operation creates an ExecutionRun object, assigns a runID to it
 *  and starts the run on a new thread. The details of the current run are stored  in a list 
 */

ExecutionRun *
ExecutionEngine::startNewTestRun(TestExecutionRequest & tereq)
{
	trace(serverTrace,1,"ExecutionEngine::startNewTestRun - entered engine=%p",this);
	
	ExecutionRun * newRun = new ExecutionRun(this);
	newRun->setTestRequest(tereq);
	newRun->setRunId(generateRunId());
	trace(serverTrace,1,"ExecutionEngine::startNewTestRun - RunId for this run = %d",newRun->getRunId());
    
    provisionNewRun(tereq,newRun->getRunId());
    boost::mutex::scoped_lock  lck(m_currentRunListMutex);
	newRun->startTestRun();
	
	m_currentRuns.push_back(newRun);
	trace(serverTrace,1,"ExecutionEngine::startNewTestRun -returning %p",newRun);	
	return newRun;
}

/** \brief For a given run id, this method will stop run and return true.
 * If the given run id is not found in the list or can not be stopped, then false is returned.
 */
bool 
ExecutionEngine::stopTestRun(int runId)
{
    trace(serverTrace,1,"ExecutionEngine::stopTestRun - invoked for runId = %d", runId);
	list<ExecutionRun *>::iterator iter;
	ExecutionRun *runToBeDeleted=NULL;

	for (iter = m_currentRuns.begin() ; iter != m_currentRuns.end() ; iter++)
	{
		if((*iter)->getRunId() == runId)
		{
            trace(serverTrace,1,"ExecutionEngine::stopTestRun - found a match for runId = %d", runId);

			(*iter)->stopTestRun();
			return true;
		}
	}

    return false;
    trace(serverTrace,1,"ExecutionEngine::stopTestRun - returning for runId = %d", runId);

}

/** \brief Once a test run is completed ( or stopped) this method is invoked. It takes care of reporting the \
 * results all the report managers, unblocks all the nodes which were used in the test and cleans up the 
 * resources used by the run.
 */
void 
ExecutionEngine::processCompletedRun(ExecutionRun &completedRun)
{
	trace(serverTrace,1,"ExecutionEngine::processCompletedRun for %d",completedRun.getRunId());
	ExecutionRun *runToBeDeleted=NULL;
	list<ExecutionRun *>::iterator iter;
    boost::mutex::scoped_lock  lck(m_currentRunListMutex);

	for (iter = m_currentRuns.begin() ; iter != m_currentRuns.end() ; iter++)
	{
		if((*iter)->getRunId() == completedRun.getRunId())
		{
            trace(serverTrace,1,"ExecutionEngine::processCompletedRun found a match in the current runsfor %d",completedRun.getRunId());
			runToBeDeleted=*iter;
			m_currentRuns.erase(iter);
			break;
		}
	}

	// Now process the completedRun and send results to logReportManager,SMTPReportManager and TestLinkReportManager
	// Mark the nodes as free
	LogReportManager logMgr(completedRun.getExecutionSequenceMap(), completedRun.getTestRequest(),
							completedRun.getRunId());
	logMgr.generateTestRunReport();
		
	SMTPReportManager smtpMgr(completedRun.getExecutionSequenceMap(), completedRun.getTestRequest(),
			completedRun.getRunId());
	smtpMgr.generateTestRunReport();
	smtpMgr.reportTestRunResult();
	
	
	TestlinkReportManager tlRMngr(completedRun.getExecutionSequenceMap(), completedRun.getTestRequest(),
								  completedRun.getRunId());
	tlRMngr.generateTestRunReport();
	tlRMngr.reportTestRunResult();
	ServerController::getInstance()->unblockNodes(completedRun.getTestRequest().getHostNames());
	
	if(runToBeDeleted != NULL)
	{
		delete runToBeDeleted;
	}
	
	
}
/** \brief This method will create the directory structure needed for storing the results of each run. It will also store the 
 * details about the run in text file for future reference. */
void 
ExecutionEngine::provisionNewRun(TestExecutionRequest & tereq, int runId)
{
    trace(serverTrace,1,"ExecutionEngine::provisionNewRun Entered for run id %d",runId);
    // We need a buffer to hold our run id. Lets take a buffer of 100 This will last us till runID crossess 100 digits.
    
    char runIdStr[100];
    snprintf(runIdStr,100,"%d",runId);
    string reportDir = "/usr/local/TAF/var/Run_" + string(runIdStr);
    mkdir(reportDir.c_str(),S_IRWXU);
    string runDetailsFile = reportDir + "/RequestSummary.txt";
    ofstream ofs(runDetailsFile.c_str());
    if(ofs.is_open() == true)
    {
        ofs << "Test Request Details" << endl;
        ofs << tereq << endl;

        for(vector<string>::iterator iter = tereq.getHostNames().begin(); iter != tereq.getHostNames().end() ; iter++)
        {
            string hostdir = reportDir + "/" + (*iter);
            mkdir(hostdir.c_str(),S_IRWXU);
        }
    }
    trace(serverTrace,1,"ExecutionEngine::provisionNewRun Exiting for run id %d",runId);
}
	
}; // End of namespace
