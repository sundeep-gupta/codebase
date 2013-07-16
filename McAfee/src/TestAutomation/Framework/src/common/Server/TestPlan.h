/************************************************************************
 * TestPlan.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/


#ifndef TESTPLAN_H
#define TESTPLAN_H

#include <iostream>
#include <vector>
#include <map>

#include <Testcase.h>
using namespace std;

namespace TestAutomationFramework
{

/** Interface for TestPlan.  As per TestLink, TestPlan is just a group
 of TestCases and there won't be any sub-testPlans.  The testplans data
 will be stored in TestAutomation/Testplans folder.
 */
class TestPlan
{
public:
	/** \brief Constructor to create object for testplans to be tested.
	*/ 
	TestPlan(const string& svnCheckoutPath, const string& testPlanName);
	
	/** \brief Constructor to create dummy object for testcases to be tested.
	*/
	TestPlan(const string& svnCheckoutPath, const vector<string>& testCaseNames, const string& testPlanName);
	
	/** \brief Copy constructor */
	TestPlan(const TestPlan& rhs);
	
	/** \brief Empty Destructor */
	virtual ~TestPlan();
	
	/** \brief Method to get plan name.
	*/ 
	string getPlanName() const
	{
		return m_testPlanName;
	};
	
	/** \brief Method to get planID for the given plan object. 
	*/
	string getPlanID() const
	{
		return m_testPlanID;
	}
	
	/** \brief Method to get testcase sequence.  This will basically provide what sequence
	 the testcases should be run.
	*/
	vector< vector<Testcase* > > getPlanSequence() const
	{
		return m_planSequence;
	};
	
	/** \brief Method to get full pathname for the given plan object.
	*/
	string getPlanFullPath() const
	{
		return m_planFullPath;
	}
	
private:
	/** \brief Making empty constructor private.
	*/
	TestPlan();
	
	/** \brief Making assignment operator private.
	*/
	TestPlan& operator=(const TestPlan&);
	
	/** \brief Method to generate test sequence.
	 */
	void generatePlanSequence();
	
	/** \brief Method internally used for test sequence generation.  It will process the
	 dependencies and provide the sub-sequence.
	 Return true if sub-sequence processing is successful, otherwise return false.
	 */
	bool populateDepVec(const string& depTestName, vector<Testcase *>& testVec);
	
	/** \brief TestPlan name. */ 
	string m_testPlanName;
	
	/** \brief TestPlan ID. */
	string m_testPlanID;
	
	/** \brief Test sequence for the given plan. */
	vector< vector<Testcase* > > m_planSequence;
	
	/** \brief Map containing Testcase name and its object for all testcases in the testPlan. */
	map<string, Testcase*> m_testcaseObjMap;
	
	/** \brief Array of testcase objects. */
	vector<Testcase*> m_testcaseObjs;
	
	/** \brief SVN checkout path which contains the testPlan XML file. */
	string m_svnCheckoutPath;
	
	/** \brief TestPlan full Path. */
	string m_planFullPath;
};

}; // End of namespace

#endif // TESTPLAN_H
