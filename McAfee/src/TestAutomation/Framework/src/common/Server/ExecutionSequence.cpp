/************************************************************************
 * ExecutionSequence.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/

#include "ExecutionSequence.h"
#include <sys/stat.h>
#include "trace.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables();

#define DUMMY_PLAN_NAME "__TEMP_PLAN__"

namespace TestAutomationFramework
{
	
ExecutionSequence::ExecutionSequence(const string& svnCheckoutPath, const vector<string> &testNames):
	m_svnCheckoutPath(svnCheckoutPath), 
	m_inputTestNames(testNames)
{
	trace(serverTrace,1,"ExecutionSequence::ExecutionSequence - Invoked");
	m_testPlans.clear();
	m_testCases.clear();
	m_testPlanObjects.clear();
	
	struct stat fileStat = {};
	 
	 /** Check for existence of checkout entry. */
	if(stat(m_svnCheckoutPath.c_str(), &fileStat) == 0)
	{
		/** Check if this is directory. */
		if(S_IFDIR & fileStat.st_mode)
		{}
		else
			/** Not directory, so return. */
			return;
	}
	else
		/** No entry exists, so return. */
		return;
			
	/** Get the Testcase finder object given svn checkout path. */
	TestcaseFinderObj *finderObj = TestcaseFinder::getTestcaseFinderObject(m_svnCheckoutPath);
	trace(serverTrace,1,"ExecutionEngine::ExecutionSequence: SvnCheckoutPath - %s",m_svnCheckoutPath.c_str());
	if(!finderObj)
		return;
	
	/** Using finder object, identify which input test names are testplans and which are testcases. */
	populatePlansAndTestcases(finderObj);
	
	/** Return if no testplans and no testcases. */
	if(!m_testPlans.size() && !m_testCases.size())
		return;
	
	/** Create testPlan objects for each testPlan to be processed.  The test
	 sequence for the testPlan will be generated as part of object creation. */
	trace(serverTrace,1,"ExecutionEngine::ExecutionSequence: TestPlans size - %d",m_testPlans.size());
	if(m_testPlans.size())
	{
		for(int i=0; i<m_testPlans.size(); i++)
		{
			TestPlan *planObj = new TestPlan(m_svnCheckoutPath, m_testPlans[i]);
			
			if(planObj)
				m_testPlanObjects.push_back(planObj);
		}
	}

	/** Create dummy test plan consisting of the testcases. */
	/*
	trace(serverTrace,1,"ExecutionEngine::ExecutionSequence: Testcase size - %d",m_testCases.size());
	if(m_testCases.size())
	{
		TestPlan *planObj = new TestPlan(m_svnCheckoutPath, m_testCases, DUMMY_PLAN_NAME);
		
		if(planObj)
			m_testPlanObjects.push_back(planObj);
	}
	*/
	
	/** Commenting above code and for now, adding below code to print trace message for any inputted testcases
	 and also clearing the testcases so that harnessServer will process only the testplans
	 */
	if(m_testCases.size())
	{
		trace(serverTrace,1,"ExecutionEngine::ExecutionSequence - %d Testcases inputted not supported", m_testCases.size());
		trace(serverTrace,1,"Below are the inputted testcases execution not supported:");
		for(int i=0; i<m_testCases.size(); i++)
			trace(serverTrace,1,"\t%s", m_testCases[i].c_str());
		
		m_testCases.clear();
	}
	
	/** Release the testcase finder object. */
	TestcaseFinder::releaseTestcaseFinderObject(m_svnCheckoutPath);
}

ExecutionSequence::ExecutionSequence(const ExecutionSequence& rhs):
	m_svnCheckoutPath(rhs.m_svnCheckoutPath),
	m_inputTestNames(rhs.m_inputTestNames),
	m_testPlans(rhs.m_testPlans),
	m_testCases(rhs.m_testCases)
{
	trace(serverTrace,1,"ExecutionSequence::ExecutionSequence - Invoked");
	m_testPlanObjects.clear();
	
	for(int i=0; i<rhs.m_testPlanObjects.size(); i++)
	{
		TestPlan *srcPlanObj = rhs.m_testPlanObjects[i];
		if(!srcPlanObj)
			continue;
		
		TestPlan *planObj = new TestPlan(*srcPlanObj);
		
		if(planObj)
			m_testPlanObjects.push_back(planObj);
	}
}

ExecutionSequence::~ExecutionSequence() 
{
	for(int i=0; i<m_testPlanObjects.size(); i++)
	{
		if(m_testPlanObjects[i])
			delete m_testPlanObjects[i];
	}
	m_testPlanObjects.clear();
}


void ExecutionSequence::populatePlansAndTestcases(TestcaseFinderObj* finderObj)
{
	trace(serverTrace,1,"ExecutionSequence::populatePlansAndTestcases - Invoked");
	for(int i=0; i<m_inputTestNames.size(); i++)
	{
		/** Construct XML path. */
		string testName = m_inputTestNames[i] + XML_EXT;
		
		string fullPath;
		
		/** If test xml path exists in Testcases folder, then it is testcase.
		 Add it to the testcases vector. */
		if(finderObj->getFullPath(testName, TESTCASE, fullPath))
		{
		    trace(serverTrace,1,"ExecutionSequence::populatePlansAndTestcases-testcaseName:- %s",m_inputTestNames[i].c_str());
			m_testCases.push_back(m_inputTestNames[i]);
		}
		else
		/** If test xml path exists in Testplans folder, then it is testplan.
		 Add it to the testplans vector. */
		if(finderObj->getFullPath(testName, TESTPLAN, fullPath))
		{
			 trace(serverTrace,1,"ExecutionSequence::populatePlansAndTestcases-testcaseName:- %s",m_inputTestNames[i].c_str());
			m_testPlans.push_back(m_inputTestNames[i]);
		}
	}
}

}; // End of namespace
