/************************************************************************
 * Testcase.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/


#ifndef TESTCASE_H
#define TESTCASE_H

#include <iostream>
#include <vector>
using namespace std;

namespace TestAutomationFramework
{

/** \brief enum for testcase results
 */
enum testResult
{
	NOT_RUN,
	BLOCKED,
	FAILED,
	PASSED
};


/** Interface for TestCase.  As per TestLink, TestCase is basic entity
 and will be part of Testplan(s).  The testcases data will be stored in
 TestAutomation/Testcases folder.
 */
class Testcase
{
public:
	
	/** \brief Constructor to create Testcase object.
	 */
	Testcase(const string &svnCheckoutPath, const string &testcaseName);
	
	/** \brief Empty Destructor.
	 */
	virtual ~Testcase() {};
	
	/** \brief Method to get testcase name.
	 */
	string getTestcaseName() const
	{
		return m_testcaseName;
	}
	
	/** \brief Method to get testcase ID used in TestLink.
	 */
	string getTestcaseID() const
	{
		return m_testcaseID;
	}
	
	/** \brief Method to get launch program.
	 */
	string getLaunchProgram() const
	{
		return m_launchProgram;
	}
	
	/** \brief Method to get dependent testcase name.
	 Return true if dependency exists, otherwise return false.
	 */
	bool getDepends(string &depends) const
	{
		depends = m_depends;
		return (m_depends.size() != 0);
	}
	
	/** \brief Method to set the testcase result.
	 */
	void setTestResult(testResult resVal)
	{
		m_result = resVal;
	}
	
	/** \brief Method to get the testcase result.
	 */
	testResult getTestResult() const
	{
		return m_result;
	}
	
	/** \brief Method to get testcase full pathname.
	 */
	string getTestcasePathName() const
	{
		return m_testcasePathName;
	}
	
	/** \brief Method to mark whether sub-sequence for the testcase got generated
	 as part of testplan sequence generation.
	 */
	void setDepCheckComplete(bool checkComplete)
	{
		m_depCheckComplete = checkComplete;
	}
	
	/** \brief Method to get sub-sequence generation flag.
	 */
	bool getDepCheckComplete() const
	{
		return m_depCheckComplete;
	}
	
	void setCycleExists(bool cycleExists)
	{
		m_cycleExists = cycleExists;
	}
	
	bool getCycleExists()
	{
		return m_cycleExists;
	}
	
private:
	/** \brief Making empty constructor private.
	 */
	Testcase();
	
	/** \brief Making assignment operator private.
	 */
	Testcase& operator=(const Testcase&);
	
	/** \brief Testcase Name. */
	string m_testcaseName;
	
	/** \brief Testcase ID. */
	string m_testcaseID;
	
	/** \brief Testcase launch program. */
	string m_launchProgram;
	
	/** \brief Testcase dependent information. */
	string m_depends;
	
	/** \brief Testcase full path name. */
	string m_testcasePathName;
	
	/** \brief Testcase result. */
	testResult m_result;
	
	/** \brief Testcase sub-sequence generation flag. */
	bool m_depCheckComplete;
	
	bool m_cycleExists;
	
};
}; // End of namespace

#endif // TESTCASE_H
