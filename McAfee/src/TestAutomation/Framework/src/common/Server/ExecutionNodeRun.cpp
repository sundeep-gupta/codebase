/*
 *  ExecutionNodeRun.cpp
 *  TestAutomationFramework
 *
 *  Created by Anil Kumar on 4/24/10.
 *  Copyright (C) 2010 McAfee Inc. All rights reserved. 
 *
 */

#include <ExecutionNodeRun.h>
#include <STAFInterface.h>
#include <sys/stat.h>
#include "trace.h"
#include <ServerController.h>
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables();

#define CLIENT_TMP_DIR "/private/tmp"
#define CLIENT_TMP_DIR_PREFIX "tmp_staf_"
#define LOCAL_MACHINE "LOCAL"

#define TEST_CASES_DIR "Testcases"
#define SERVER_LOG_PATH "/usr/local/TAF/var"
#define HOST_LOG_DIR "Logs"

#define SYSTEM_LOG_FILE "/var/log/system.log"
#define INSTALL_LOG_FILE "/var/log/install.log"
#define KERNEL_LOG_FILE "/var/log/kernel.log"
#define MSM_LOG_FILE "/var/log/McAfeeSecurity.log"
#define MSM_DEBUG_LOG_FILE "/var/log/McAfeeSecurityDebug.log"

namespace TestAutomationFramework
{
	
ExecutionNodeRun::ExecutionNodeRun(const string& hostName, ExecutionSequence* execSequence, const string& testURLPath, const string& svnCheckoutPath, const int runId):
	m_hostName(hostName),
	m_execSequence(execSequence),
	m_testURLPath(testURLPath),
	m_svnCheckoutPath(svnCheckoutPath),
	m_runId(runId)
{
}

ExecutionNodeRun::~ExecutionNodeRun()
{}

/** Copy all the directories required for proper execution of all test cases part of a plan on the host machine.
 */
bool ExecutionNodeRun::copyPlanSetup() const
{
	trace(serverTrace,1,"ExecutionNodeRun::copyPlanSetup-Invoked");
	
	/** Copying the Testcases directory from the server to host machine is ok since we will checkout only 
	 the required sub-folders within the Testcases directory when we create checkout in the server. For more
	 information, refer to performSvnCheckout calls in the code. **/
	string planReqDir = TEST_CASES_DIR;
	trace(serverTrace,1,"ExecutionNodeRun::Plan required Directory:%s",planReqDir.c_str());

	/** Get the directory name to be copied. */
	string srcDirName = m_svnCheckoutPath + "/" + planReqDir;
	string destDirName = m_hostTestDir + "/" + planReqDir;
	
	/** Using STAFInterface, copy the directory to the host. */
	if(!STAFInterface::getInstance()->copyDirectory(ServerController::getInstance()->getServerIP(), m_hostName, srcDirName, destDirName))
		return false;

	return true;
}	

/** Setup the environment before actual execution of test sequence.
 1.  Create the host temporary directory where testcases execution will be performed.
 2.  Copy the directories required for each test plan execution.
 */
bool ExecutionNodeRun::setupTestSequence()
{
	trace(serverTrace,1,"ExecutionNodeRun::setupTestSequence-Invoked");
	/** Construct the host temp directory. */
	char strNum[PATH_MAX];
	snprintf(strNum, sizeof(strNum), "%d", m_runId);
	string randStr(strNum);
	m_hostTestDir = string(CLIENT_TMP_DIR) + "/" + string(CLIENT_TMP_DIR_PREFIX) + randStr;
	
	/** Remove the host directory if already exists. */
	STAFInterface::getInstance()->removeDirectory(m_hostName, m_hostTestDir);
	
	/** Create the host directory. */
	if(!STAFInterface::getInstance()->createDirectory(m_hostName, m_hostTestDir))
		return false;
	
	/** Copy all the directories required for proper execution of test plans */
	if(!copyPlanSetup())
		return false;
	
	return true;
}

/** Cleanup the environment after completion of test sequence execution.
 1.  Remove the host directory.
 */
void ExecutionNodeRun::cleanupTestSequence() const
{
	STAFInterface::getInstance()->removeDirectory(m_hostName, m_hostTestDir);
}

/** Execute the test sequence by performing following steps:
 1.  Setup the environment
 2.  Execute the testcases part of the sequence
 3.  Cleanup the environment
 */
void ExecutionNodeRun::executeTestSequence()
{
	/** Setup the environment. */
	if(!setupTestSequence())
		return;
	
	vector<TestPlan*> planObjs = m_execSequence->getTestPlanObjects();
	
	/** Iterate thru all plan objects and execute each plan sequence. */
	for(int i=0; i<planObjs.size(); i++)
	{
		executeTestPlan(planObjs[i]);
		cleanupTestPlan(planObjs[i]);
	}
		
	/** Cleanup the environment. */
	cleanupTestSequence();
}
	
	
void ExecutionNodeRun::executeTestPlan(const TestPlan* planObj) const
{
	map<string, testResult> planResVec;
	planResVec.clear();
	
	/** Get plan sequence for the given plan object and iterate thru the testcases. */
	vector< vector<Testcase*> > seqVec = planObj->getPlanSequence();
	for(int i=0; i<seqVec.size(); i++)
	{
		/** For each row, the testcases should be run in reverse order to satisfy
		 the dependencies.
		 */
		for(int j=seqVec[i].size()-1; j>=0; j--)
		{
			/** Testcase object. */
			Testcase *tcObj = seqVec[i][j];
			
			if(!tcObj)
				continue;
			
			/** Check whether the testcase is already executed or not. */
			map<string, testResult>::iterator iter = planResVec.find(tcObj->getTestcaseName());
			
			/** Testcase not yet executed.  Now, execute it. */
			if(iter == planResVec.end())
			{
				executeTestcase(tcObj);
				
				/** Store the testcase result for later use. */
				planResVec.insert(make_pair(tcObj->getTestcaseName(), tcObj->getTestResult()));
				
				/** If testcase is not passed, abort row processing to satisfy dependencies. */
				if(tcObj->getTestResult() != PASSED)
					break;
			}
			else
			/** Testcase already executed. */
			{
				testResult resVal = iter->second;
				
				/** If testcase is not passed, abort row processing to satisfy dependencies. */
				if(resVal != PASSED)
					break;
			}
		}
	}
	
	/** Now, update the testcase results in the execution sequence.  Updation of first element 
	 of each row is sufficient.
	 */
	for(int i=0; i<seqVec.size(); i++)
	{
		/** Get the first element of each row. */
		Testcase* tcObj = seqVec[i][0];
		
		if(!tcObj)
			continue;
		
		map<string, testResult>::iterator iter = planResVec.find(tcObj->getTestcaseName());
		
		/** Get the result for the testcase and update the testcase object. */
		if(iter != planResVec.end())
		{
			testResult resVal = iter->second;
			tcObj->setTestResult(resVal);
		}
	}	
}
	
void ExecutionNodeRun::cleanupTestPlan(const TestPlan* planObj) const
{
	/** Directory in the host machine where log files for the testcases will be available. **/
	string srcDirPath = m_hostTestDir + "/" + TEST_CASES_DIR + "/" + string(HOST_LOG_DIR);
	/** Server directory in which log files to be copied from host machine to server. **/
	string destDirPath = string(SERVER_LOG_PATH);

	char runIdStr[100];
	snprintf(runIdStr, 100, "%d", m_runId);
	destDirPath += "/Run_" + string(runIdStr);
	destDirPath += "/" + m_hostName + "/" + planObj->getPlanName();
	
	/** Create the log folder in the server. */
	mkdir(destDirPath.c_str(), S_IRWXU);

	/** Copy the plan logs from host test node to server. */
	if(STAFInterface::getInstance()->copyDirectory(m_hostName, ServerController::getInstance()->getServerIP(), srcDirPath, destDirPath))
	{
		/** Copy the system logs from host test node to server. */
		STAFInterface::getInstance()->copyFile(m_hostName, ServerController::getInstance()->getServerIP(), SYSTEM_LOG_FILE, destDirPath);
		STAFInterface::getInstance()->copyFile(m_hostName, ServerController::getInstance()->getServerIP(), INSTALL_LOG_FILE, destDirPath);
		STAFInterface::getInstance()->copyFile(m_hostName, ServerController::getInstance()->getServerIP(), KERNEL_LOG_FILE, destDirPath);
		STAFInterface::getInstance()->copyFile(m_hostName, ServerController::getInstance()->getServerIP(), MSM_LOG_FILE, destDirPath);
		STAFInterface::getInstance()->copyFile(m_hostName, ServerController::getInstance()->getServerIP(), MSM_DEBUG_LOG_FILE, destDirPath);

		/** Now, cleanup the plan logs folder by emptying it. */
		if(STAFInterface::getInstance()->removeDirectory(m_hostName, srcDirPath))
			return;
	}
	
	trace(serverTrace, 1, "ExecutionNodeRun::cleanupTestPlan not successful");
}

void ExecutionNodeRun::executeTestcase(Testcase* tcObj) const
{
	/** Get the testcase path. */
	string srcTestcasePath = tcObj->getTestcasePathName();
	trace(serverTrace, 1, "ExecutionNodeRun::executeTestcase srcTestcasePath is %s", srcTestcasePath.c_str());

	/** Assumption is that all testcases(test scripts) will be in Testcases directory */
	string planReqDir(TEST_CASES_DIR);
	size_t pos = srcTestcasePath.find(planReqDir);
	if(pos == string::npos)
	{
		trace(serverTrace, 1, "ExecutionNodeRun::executeTestcase required directory is not valid");
		return;
	}
	
	/** Form a valid path to the script by replacing dir name
	 with appropriate script name on the client node */
	string srcLeafName = srcTestcasePath.substr(pos);
	string destFilePath = m_hostTestDir + "/" + srcLeafName;		
	
	/** Provide test URL path as parameter to the testcase.  Eventually one testcase will pick it. */
	string shellCmd = tcObj->getLaunchProgram() + " " + destFilePath + " \"" + m_testURLPath + "\" 2>&1";
	trace(serverTrace, 1, "ExecutionNodeRun::executeTestcase shellCmd is %s", shellCmd.c_str());
	
	int retVal = -1;
	
	/** Now execute the testcase at the host using STAF. */
	if(STAFInterface::getInstance()->executeCommand(m_hostName, shellCmd, retVal))
	{
		trace(serverTrace, 1, "ExecutionNodeRun::executeTestcase retVal from executeCommand is : %d", retVal);
		/** Set the testcase result. */
		if(!retVal)
		{
			trace(serverTrace, 1, "ExecutionNodeRun::executeTestcase testcase %s PASSED on host name %s", destFilePath.c_str(), m_hostName.c_str());
			tcObj->setTestResult(PASSED);
		}
		else
		{
			trace(serverTrace, 1, "ExecutionNodeRun::executeTestcase testcase %s FAILED on host name %s", destFilePath.c_str(), m_hostName.c_str());
			tcObj->setTestResult(FAILED);
		}
	}
}
} // namespace
	
