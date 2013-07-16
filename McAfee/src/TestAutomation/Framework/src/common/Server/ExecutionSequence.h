/************************************************************************
 * ExecutionSequence.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/


#ifndef EXECUTIONSEQUENCE_H
#define EXECUTIONSEQUENCE_H

#include <string>
#include <vector>
#include <TestPlan.h>
#include <TestcaseFinder.h>

using namespace std;

namespace TestAutomationFramework
{

/** This class provides the test sequence for entire test run.
 */
class ExecutionSequence
{
public:
	
	/** \brief Constructor to create ExecutionSequence object.
	 */
	ExecutionSequence(const string& svnCheckoutPath, const vector<string> &testNames);
	
	/** \brief Copy constructor.
	 */
	ExecutionSequence(const ExecutionSequence& rhs);
	
	/** \brief Empty destructor.
	 */
	virtual ~ExecutionSequence();
	
	/** \brief Method to get all testPlan objects.
	 */
	vector<TestPlan* > getTestPlanObjects() const
	{	return m_testPlanObjects;	};
	
	
private:
	
	/** \brief Making empty constructor private.
	 */
	ExecutionSequence();
	
	/** \brief Making assignment operator private.
	 */
	ExecutionSequence& operator=(const ExecutionSequence&);
	
	/** \brief Method to group the given input test names into testplans and testcases.
	 */
	void populatePlansAndTestcases(TestcaseFinderObj* finderObj);
	
	/** \brief SVN checkout full path. */
	string m_svnCheckoutPath;
	
	/** \brief vector of input test names. */
	vector<string> m_inputTestNames;
	
	/** \brief vector of test plans to be processed. */
	vector<string> m_testPlans;
	
	/** \brief vector of test cases to be processed. */
	vector<string> m_testCases;
	
	/** \brief vector of test plan objects for this test run. */
	vector<TestPlan* > m_testPlanObjects;
};

}; // End of namespace

#endif // EXECUTIONSEQUENCE_H
