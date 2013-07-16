/************************************************************************
* ReportManager.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/

#include "ReportManager.h"
#include <TestNode.h>
#include <ServerController.h>
#include <fstream>
#include "trace.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables();
namespace TestAutomationFramework
{

// Constructors/Destructors
//  

ReportManager::~ReportManager ( ) { }

//  
// Methods
//  
	
/** \brief This Accessor function returns the 'result summary' of the test node.
 */
const ResultSummary ReportManager::getResultSummary(const string hostName) const
{
	map<string, ResultSummary>::const_iterator resultItr = m_ResultSummaryMap.begin();
	ResultSummary resultSummary;
		
	for (; resultItr != m_ResultSummaryMap.end(); ++resultItr) {
		if (hostName == resultItr->first) {
			resultSummary = resultItr->second;
			break;
		}
	}
	
	return resultSummary;
}	

/** \brief This Mutator function is used to set the 'result summary' of test cases with the host.
 */			
void ReportManager::setResultSummary(string hostName, const ResultSummary resultSummary)
{
	map<string, ResultSummary>::const_iterator findItr = m_ResultSummaryMap.find(hostName);
		
	if (findItr == m_ResultSummaryMap.end()) {
		m_ResultSummaryMap.insert(make_pair(hostName, resultSummary));
	}
}	
	
/** \brief This accessor function is used to get the 'execution sequence' which stores the result of the
 ** test cases run on different test nodes.
 */		
const ExecutionSequence* ReportManager::getExecSequence(string hostName) const
{
	//		map<string, ExecutionSequence*>::const_iterator seqItr = m_ExecSequenceMap.find(hostName);
	map<string, ExecutionSequence*>::const_iterator seqItr = m_ExecSequenceMap.begin();
		
	for (; seqItr != m_ExecSequenceMap.end(); ++seqItr) {
		if (seqItr->first == hostName) {
			trace(serverTrace, 3, "ReportManager::getExecSequence: found and returning");
			return seqItr->second;
		}
	}
	trace(serverTrace, 1, "hostName not found in m_ExecSequenceMap");

	return NULL;
}

/** \brief This method creates the log report which contains the result of every test
 **  case for every test node.
 */		
void ReportManager::createLogReport () 
{
	trace(serverTrace, 1, "Entering ReportManager::createLogReport");
	const vector<string> hostNames = this->getHostnames();
	vector<string>::const_iterator hostItr = hostNames.begin();
	ofstream logFileP(m_LogFilePath.c_str(), ios::out);
		
	if (logFileP.is_open()) {
		logFileP<<"\n\t\t\t::::::::::::::::::::Test Results:::::::::::::::::::::\n";
			
		for (; hostItr != hostNames.end(); ++hostItr) {
			TestNode testNode = (ServerController::getInstance())->getNodeFromHostName(*hostItr);
				
			if (testNode.getHostName() != *hostItr) {
				trace(serverTrace, 1, "updateTestResult: hostName not found");
			}
				
			logFileP <<"\n\t\t:::::::::::::::::::: Test Results For Host : "<< *hostItr <<" :::::::::::::::::::::";
	
			const ExecutionSequence *execSeqPtr = this->getExecSequence(*hostItr);
					
			if (!execSeqPtr) {
				trace(serverTrace, 1, "execSeqPtr is NULL and we are returning.");
				logFileP.close();
				return;
			}
			
			vector<TestPlan*> testPlans = execSeqPtr->getTestPlanObjects();
						
			for (int testPlanIdx = 0; testPlanIdx < testPlans.size(); ++testPlanIdx)
			{
				vector< vector<Testcase *> > seqVec;
				seqVec.clear();
				
				seqVec = testPlans[testPlanIdx]->getPlanSequence();
					
				logFileP << "\n\n\t\t\tTest Plan Name is\t:\t" << testPlans[testPlanIdx]->getPlanName() << endl;
				logFileP << "\t\t\tBuild Number is  \t:\t" << getBuildNumber() << endl;
				logFileP <<"\t\t\tPlatform is \t:\t" << testNode.getOsName() << endl;
					
				for(int testCaseIdx = 0; testCaseIdx < seqVec.size(); ++testCaseIdx)
				{					
					Testcase* testCasesP = seqVec[testCaseIdx][0];
						
					if(!testCasesP) {
						continue;
					}
					logFileP << "\n\t\tTestcase Name\t\t:\t " << testCasesP->getTestcaseName();
					switch(testCasesP->getTestResult()) 
					{
						case NOT_RUN:
							logFileP << "\t\tResult\t\t:\t NOT RUN"<< endl;
							break;
						case BLOCKED:
							logFileP << "\t\tResult\t\t:\t BLOCKED"<< endl;
							break;
						case PASSED:
							logFileP << "\t\tResult\t\t:\t PASSED"<< endl;
							break;
						case FAILED:
							logFileP << "\t\tResult\t\t:\t FAILED"<< endl;
							break;
						default:
							trace(serverTrace, 1, "Test case result is undetermined");
					}					
				}
			}
		}
	}
	else {
		trace(serverTrace, 1, "Unable to create Report-Log file");
		logFileP.close();
		return;
	}
	
	logFileP.close();
}

/** \brief This method creates the summary which contains the count of 'pass', fail,
 **  'not run' and 'blocked' test cases with the hosts where the test cases were run.
 */	
void ReportManager::createResultSummary () 
{
	trace(serverTrace, 1, "Entering ReportManager::createResultSummary");
	const vector<string> hostNames = this->getHostnames();
	vector<string>::const_iterator hostItr = hostNames.begin();
	m_ResultSummaryMap.clear();

	for (; hostItr != hostNames.end(); ++hostItr) {
		TestNode testNode = (ServerController::getInstance())->getNodeFromHostName(*hostItr);
				
		if (testNode.getHostName() != *hostItr) {
			trace(serverTrace, 1, "updateTestResult: hostName not found");
		}
				
		const ExecutionSequence *execSeqPtr = this->getExecSequence(*hostItr);
		ResultSummary resultSummary;
			
		if (!execSeqPtr) {
			trace(serverTrace, 1, "execSeqPtr is NULL and we are returning.");
			return;
		}
		vector<TestPlan*> testPlans = execSeqPtr->getTestPlanObjects();
			
		for (int testPlanIdx = 0; testPlanIdx < testPlans.size(); ++testPlanIdx)
		{
			vector< vector<Testcase *> > seqVec;
			seqVec.clear();
					
			seqVec = testPlans[testPlanIdx]->getPlanSequence();
					
			for(int testCaseIdx = 0; testCaseIdx < seqVec.size(); ++testCaseIdx)
			{					
				Testcase* testCasesP = seqVec[testCaseIdx][0];
				
				if(!testCasesP) {
					continue;
				}
				switch(testCasesP->getTestResult()) 
				{
					case NOT_RUN:
						resultSummary.incrementNotRunCount();
						break;
					case BLOCKED:
						resultSummary.incrementBlockCount();
						break;
					case PASSED:
						resultSummary.incrementPassCount();
						break;
					case FAILED:
						resultSummary.incrementFailCount();
						break;
					default:
						trace(serverTrace, 1, "Test case result is undetermined");
				}					
			}
		}
		setResultSummary(*hostItr, resultSummary);
	}
}

void ReportManager::generateTestRunReport() {
	trace(serverTrace, 1, "Entering ReportManager::generateTestRunReport");
}

// Accessor methods
//  


// Other methods
//  

}; // End of namespace
