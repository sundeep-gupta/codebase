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

#define SERVER_LOG_PATH "/usr/local/TAF/var"
#define HOST_LOG_DIR "logs"

#define SYSTEM_LOG_FILE "/var/log/system.log"
#define INSTALL_LOG_FILE "/var/log/install.log"
#define KERNEL_LOG_FILE "/var/log/kernel.log"
#define MSM_LOG_FILE "/var/log/McAfeeSecurity.log"
#define MSM_DEBUG_LOG_FILE "/var/log/McAfeeSecurityDebug.log"

namespace TestAutomationFramework
{
	
ExecutionNodeRun::ExecutionNodeRun(const string& hostName, ExecutionSequence* execSequence, const string& buildDmgPath, const string& svnCheckoutPath, const int runId):
	m_hostName(hostName),
	m_execSequence(execSequence),
	m_buildDmgPath(buildDmgPath),
	m_svnCheckoutPath(svnCheckoutPath),
	m_runId(runId)
{
}

ExecutionNodeRun::~ExecutionNodeRun()
{}

/** Copy all the directories required for proper execution of all test cases part of a plan.
 */
bool ExecutionNodeRun::copyPlanSetup() const
{
	trace(serverTrace,1,"ExecutionNodeRun::copyPlanSetup-Invoked");
	vector<TestPlan*> planObjs = m_execSequence->getTestPlanObjects();
	
	for(int i=0; i<planObjs.size(); i++)
	{
		string planReqDir = planObjs[i]->getPlanRequiredDir();
		trace(serverTrace,1,"ExecutionNodeRun::Plan required Directory:%s",planReqDir.c_str());
		if(!planReqDir.size())
			continue;
		
		/** Get the directory name to be copied. */
		string dirName = m_svnCheckoutPath + "/" + planReqDir;
		
		/** Using STAFInterface, copy the directory to the host. */
		if(!STAFInterface::getInstance()->copyDirectory(ServerController::getInstance()->getServerIP(), m_hostName, dirName, m_hostTestDir))
			return false;
	}

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
	string srcDirPath = m_hostTestDir + "/" + string(HOST_LOG_DIR);
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
		{
			if(STAFInterface::getInstance()->createDirectory(m_hostName, srcDirPath))
			{
				return;
			}
		}
	}
	
	trace(serverTrace, 1, "ExecutionNodeRun::cleanupTestPlan not successful");
}

void ExecutionNodeRun::executeTestcase(Testcase* tcObj) const
{
	/** Get the testcase path. */
	string srcTestcasePath = tcObj->getTestcasePathName();
	
	/** Copy the testcase to the host directory. */
	if(STAFInterface::getInstance()->copyFile(LOCAL_MACHINE, m_hostName, srcTestcasePath, m_hostTestDir))
	{
		unsigned int pos = srcTestcasePath.find_last_of("/");
        
		string srcLeafName("");
		if(pos < (srcTestcasePath.size()-1))
			srcLeafName = srcTestcasePath.substr(pos+1);

		string destFilePath = m_hostTestDir + "/" + srcLeafName;
		
		/** Provide build DMG path as parameter to the testcase.  Eventually one testcase will pick it. */
		string shellCmd = tcObj->getLaunchProgram() + " " + destFilePath + " \"" + m_buildDmgPath + "\" 2>&1";
		
		int retVal = -1;
		
		/** Now execute the testcase at the host using STAF. */
		if(STAFInterface::getInstance()->executeCommand(m_hostName, shellCmd, retVal))
		{
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
}
	
}
	
	
