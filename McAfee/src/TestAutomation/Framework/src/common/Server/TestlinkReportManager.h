/************************************************************************
* TestlinkReportManager.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/


#ifndef TESTLINKREPORTMANAGER_H
#define TESTLINKREPORTMANAGER_H
#include "ReportManager.h"
#include "TestNode.h"
#include "ServerController.h"
#include "trace.h"
#include <stdio.h>
#include <iostream>
#include <sys/types.h>
#include <sys/param.h>
#include <map>
using namespace std;
namespace TestAutomationFramework
{
class TestlinkReportManager : public ReportManager
{
public:

    /**
     * Empty Constructor
     */
	TestlinkReportManager() {}
	
    TestlinkReportManager (const map<string, ExecutionSequence* > executionSeqMap,
						   TestExecutionRequest request, int runID) :ReportManager(executionSeqMap, request, runID )
	{
	}
	
    /**
     * Empty Destructor
     */
    virtual ~TestlinkReportManager ( );

   	/*   */
	virtual void generateTestRunReport ( );
	
	/*   */
	virtual void reportTestRunResult ( );
	
		
private:
	/* */
    void updateTestlinkServerSettings ( );
    
	/* */
    void getAllTestLinkProjects ( );
	
    /* */
    void getProjectTestPlans (int testProjectId);
	
	/* */
	int createBuild(int testPlanId, string &buildName);
    
    /* */
    bool getTestCasesForTestPlan(int testPlanId, int buildId);
	
	/*   */
    bool reportTCResult(int testCaseId, int testPlanId, string &status, int buildId);
	
	
	typedef struct 
	{
		int buildId;
		int planId;
	}buildAndPlanId;
	map<string, vector<buildAndPlanId> > m_HostBuildAndPlanIdmap;
	
	
	
};
}; // End of namespace

#endif // TESTLINKREPORTMANAGER_H
