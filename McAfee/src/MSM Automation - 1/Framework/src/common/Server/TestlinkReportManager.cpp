/************************************************************************
* TestlinkReportManager.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/

#include "TestlinkReportManager.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables();

#define LOCAL_MACHINE	"LOCAL"
#define PATH_TO_TOOL	"/usr/local/TAF/bin/testLinkUpdater.py"	

namespace TestAutomationFramework
{

// Constructors/Destructors
//  


TestlinkReportManager::~TestlinkReportManager ( )
{
}

//  
// Methods
//  

void TestlinkReportManager::getAllTestLinkProjects()
{
	FILE *fp = NULL;
	fp = popen(PATH_TO_TOOL " --getProjects","r" );
	if (fp == NULL)
	{
		//cout << "Unable to get all Test link projects"<<endl;
		trace(serverTrace,1,"TestlinkReportManager::getAllTestLinkProjects Unable to get projects");
	}
	else
	{
		trace(serverTrace,1,"TestlinkReportManager::getAllTestLinkProjects Success !!");
		if (pclose(fp) == -1 )
		{
			/* Error reported by pclose() */
			trace(serverTrace,1,"TestlinkReportManager::getAllTestLinkProjects error while getting projects");
		}		
	}
}
	
int TestlinkReportManager::createBuild (int testPlanId, string &buildName)	
{	
	trace(serverTrace, 1, "Entering in TestlinkReportManager::createBuild");
	char cmd[MAXPATHLEN] = {0};
	snprintf(cmd, sizeof(cmd), PATH_TO_TOOL " --createBuild %d %s", testPlanId, buildName.c_str());
	trace(serverTrace, 1, "Entering in TestlinkReportManager::createBuild Cmd is %s", cmd);
	FILE *fp = NULL;
	fp = popen(cmd, "r+");
	int bnum=-1;

	if (fp == NULL)
	{
		trace(serverTrace,1,"TestlinkReportManager::createBuild Unable to get Test cases");
	}
	else
	{
		trace(serverTrace,1,"TestlinkReportManager::createBuild Created new build successfully");
		char idchar[10];
		fgets(idchar,10,fp);
		int pid = strtol(idchar,NULL,10);
		bnum = pid;
		
		if (pclose(fp) == -1 )
		{
			/* Error reported by pclose() */
			trace(serverTrace,1,"TestlinkReportManager::createBuild error while getting Test cases for Test Plan");
		}		
	}
	return bnum;		
}
	
bool TestlinkReportManager::getTestCasesForTestPlan(int testPlanId, int buildId)
{	
	bool bRetValue = true;
	char cmd[MAXPATHLEN] = {0};
	snprintf(cmd, sizeof(cmd), PATH_TO_TOOL " --getTestCasesForTestPlan %d %d", testPlanId, buildId);
	FILE *fp = NULL;
	fp = popen(cmd, "r+");
	if (fp == NULL)
	{
		trace(serverTrace,1,"TestlinkReportManager::getTestCasesForTestPlan Unable to get Test cases for test plans");
		bRetValue = false;
	}
	else
	{
		trace(serverTrace,1,"TestlinkReportManager::getTestCasesForTestPlan Success");
		if (pclose(fp) == -1 )
		{
			/* Error reported by pclose() */
			trace(serverTrace,1,"TestlinkReportManager::getTestCasesForTestPlan error");
			bRetValue = false;
		}		
	}
	return bRetValue;		
}

bool TestlinkReportManager::reportTCResult(int testCaseId, int testPlanId, string &status, int buildId)	
{
	trace(serverTrace, 1, "Entering in TestlinkReportManager::reportTCResult");
	bool bRetValue = true;
	char cmd[MAXPATHLEN] = {0};
	snprintf(cmd, sizeof(cmd), PATH_TO_TOOL " --updateResult %d %d %s %d", testCaseId, testPlanId, status.c_str(), buildId);
	
	FILE *fp = NULL;
	fp = popen(cmd, "r");
	if (fp == NULL)
	{
		trace(serverTrace,1,"TestlinkReportManager::reportTCResult Unable to update Test cases results");
		bRetValue = false;
	}
	else
	{
		trace(serverTrace,1,"TestlinkReportManager::reportTCResult Updated test case result successfully");
		if (pclose(fp) == -1 )
		{
			/* Error reported by pclose() */
			trace(serverTrace,1,"TestlinkReportManager::reportTCResult error while updatng Test case results");
			bRetValue = false;
		}		
	}
	return bRetValue;			
}
	
void TestlinkReportManager::getProjectTestPlans (int testProjectId)
	{
		char cmd[MAXPATHLEN] = {0};
		snprintf(cmd, sizeof(cmd), PATH_TO_TOOL "--getProjectTestPlans %d", testProjectId);
		FILE *fp = NULL;
		fp = popen(cmd, "r");
		if (fp == NULL)
		{
			trace(serverTrace,1,"TestlinkReportManager::getTestCasesForTestPlan unable to get project test plans");
		}
		else
		{
			trace(serverTrace,1,"TestlinkReportManager::getTestCasesForTestPlan Success !!");
			if (pclose(fp) == -1 )
			{
				/* Error reported by pclose() */
				trace(serverTrace,1,"TestlinkReportManager::getTestCasesForTestPlan error");
			}		
		}
	}
		
void TestlinkReportManager::generateTestRunReport()
	{
		trace(serverTrace, 1, "TestlinkReportManager::generateTestRunReport BEGIN");
		if (getTestType() != ePublicTest)
		{
			trace(serverTrace, 1, "Entering in TestlinkReportManager:: generateTestRunReport Not updating Testlink");
			return;
		}
		vector<string>hostNames = ReportManager::getHostnames();
		vector<string>::iterator seqItr;
		
		for (seqItr = hostNames.begin(); seqItr!=hostNames.end(); ++seqItr)
		{
			const ExecutionSequence *execSeqPtr = this->getExecSequence(*seqItr);
			if (!execSeqPtr)
			{
				trace(serverTrace, 1, "Entering in TestlinkReportManager:: generateTestRunReport Couldnot get Exec Sequence");
				return;
			}
			vector<TestPlan*> testPlans = execSeqPtr->getTestPlanObjects();
			
			int buildNum = ReportManager::getBuildNumber(); // Get BuildNumber
			trace(serverTrace,1,"TestlinkReportManager::generateTestRunReport - Build Num# = %d", buildNum);
			TestNode testNode = (ServerController::getInstance())->getNodeFromHostName(*seqItr);
			
			if (testNode.getHostName() != *seqItr)
			{
				trace(serverTrace,1,"TestlinkReportManager::generateTestRunReport Hostname not found");
				return;
			}
			string OSName = testNode.getOsName(); // Get the OS Name
			
			std::stringstream osstream;
			osstream<< "-";
			osstream << buildNum;
			osstream<< "-";
			osstream << getRunID();
			string aBuildName = OSName.append(osstream.str());

			trace(serverTrace,1,"TestlinkReportManager::generateTestRunReport - OS Name# = %s", aBuildName.c_str());
			
			if(testPlans.size() <= 0)
			{
				trace(serverTrace,1,"TestlinkReportManager::generateTestRunReport - Test plan Vector Size = %d", testPlans.size());
				return;
			}
			
			vector<buildAndPlanId>m_bpid;
			for (int testPlanIdx = 0; testPlanIdx < testPlans.size(); ++testPlanIdx)
			{
				string tpid = testPlans[testPlanIdx]->getPlanID(); //Get testPLan Id 
				int testplanId = atoi(tpid.c_str());
				trace(serverTrace,1,"TestlinkReportManager::generateTestRunReport - Test plan id = %d", testplanId);
	
				int buildId = createBuild(testplanId, aBuildName); // After creation of builds get the Build IDs
				trace(serverTrace,1,"TestlinkReportManager::generateTestRunReport - Test build id = %d", buildId);
				
				buildAndPlanId bpId;
				bpId.buildId= buildId;
				bpId.planId = testplanId;
				m_bpid.push_back(bpId);
			}
			// For a hostname there will be a vector of build and Plan Id's
			m_HostBuildAndPlanIdmap.insert( pair< string, vector<buildAndPlanId> >(*seqItr,m_bpid));
		}
		trace(serverTrace,1,"TestlinkReportManager::generateTestRunReport End"); 
	}
	
void TestlinkReportManager::reportTestRunResult()
	{
		if (getTestType() != ePublicTest)
		{
			trace(serverTrace, 1, "Entering in TestlinkReportManager:: reportTestRunResult Not updating Testlink");
			return;
		}
		
		string aStatus;
		int aTestCaseId, aBuildId;
		vector<buildAndPlanId>bpId;
		vector<string>hostNames;
		
		trace(serverTrace,1,"TestlinkReportManager::reportTestRunResult BEGIN");
		hostNames = ReportManager::getHostnames();
		vector<string>::iterator seqItr;
		
		if (hostNames.size() < 0)
		{
			trace(serverTrace,1,"TestlinkReportManager::reportTestRunResult hostnames not found");
			return;
		}
		// iterate to get the hostnames first
		for (seqItr = hostNames.begin(); seqItr!=hostNames.end(); ++seqItr)
		{
			if (m_HostBuildAndPlanIdmap.size() < 0)
			{
				trace(serverTrace,1,"TestlinkReportManager::reportTestRunResult m_HostBuildAndPlanIdmap is empty");
				return ;
			}
			map< string, vector <buildAndPlanId> >:: iterator itr=m_HostBuildAndPlanIdmap.find(*seqItr);
			if(itr==m_HostBuildAndPlanIdmap.end())
				continue;
			
			if((*itr).first==(*seqItr)) // Check the Hostname first
			{
				bpId=(*itr).second;		// get the vector of <buildId PlanId>
			}	
			const ExecutionSequence *execSeqPtr = this->getExecSequence(*seqItr);
			if (!execSeqPtr)
			{
				return ;
			}
			vector<TestPlan*> testPlans = execSeqPtr->getTestPlanObjects(); // Get Test plan Objects
			
			// for-loop to get PlanId from TestPlan Objects
			for (int testPlanIdx = 0; testPlanIdx < testPlans.size(); ++testPlanIdx)
			{
				string tpid = testPlans[testPlanIdx]->getPlanID();
				int aTestplanId = atoi(tpid.c_str());						// Get testPlanID
				for (int Idx = 0; Idx < bpId.size(); ++Idx)			// Iterate thru the Vector and get Build id for corresponding planId
				{
					if (aTestplanId == bpId[Idx].planId) 
					{
						aBuildId = bpId[Idx].buildId;
						trace(serverTrace,1,"TestlinkReportManager::reportTestRunResult - test Build ID %d",aBuildId);
					}
					else
					{
						continue;
					}

					vector< vector<Testcase *> > seqVec;
					seqVec.clear();
					seqVec = testPlans[testPlanIdx]->getPlanSequence();
					
					//Iterate to get the TestCase ID's Plan Sequence
					for(int testCaseIdx = 0; testCaseIdx < seqVec.size(); ++testCaseIdx)
					{					
						Testcase* testCasesP = seqVec[testCaseIdx][0];
						string testCaseId = testCasesP->getTestcaseID();	// Get testCase Id's
						trace(serverTrace,1,"TestlinkReportManager::reportTestRunResult - test case ID %s",testCaseId.c_str());
						
						aTestCaseId = atoi(testCaseId.c_str());
						//cout << "Test case ID's : type:int"<<aTestCaseId;
						trace(serverTrace,1,"TestlinkReportManager::reportTestRunResult - test case ID %d",aTestCaseId);
						
						if ((testCasesP->getTestResult()) == BLOCKED)		// Get results for Testcase ID
						{														
							aStatus = "b";	
						}
						else if((testCasesP->getTestResult()) == FAILED)
						{
							aStatus = "f";							
						}
						else if((testCasesP->getTestResult()) == PASSED)
						{							
							aStatus = "p";							
						}
						else
						{							
							aStatus = "n"; 							
						}
						trace(serverTrace,1,"TestlinkReportManager::reportTestRunResult - testCase ID:%d testPlan ID:%d Status:%s Build ID:%d", aTestCaseId, aTestplanId, aStatus.c_str(),aBuildId);
						
						bool rprtResult = reportTCResult(aTestCaseId, aTestplanId, aStatus, aBuildId);
						if (rprtResult == true)
						{
							trace(serverTrace,1,"TestlinkReportManager::reportTestRunResult TestCase Id : %d successfully",aTestCaseId);
						}
					}// end of test case ID
				} // end of test build ID
			} // end of test plan ID
		} // end of host-names 
		
		trace(serverTrace,1,"TestlinkReportManager::reportTestRunResult END");
		return ;
	}
}; // End of namespace
