/*
 *  ExecutionNodeRun.h
 *  TestAutomationFramework
 *
 *  Created by Anil Kumar on 4/24/10.
 *  Copyright (C) 2010 McAfee Inc. All rights reserved. 
 *
 */

#include <ExecutionSequence.h>

namespace TestAutomationFramework 
{
	
/** \brief Each object of this class represents an test execution run for each node. */
class ExecutionNodeRun
{
public:
	/** \brief Constructor to create ExecutionNodeRun object.
	 */
	ExecutionNodeRun(const string& hostName, ExecutionSequence* execSequence, const string& m_buildDmgPath, const string& m_svnCheckoutPath, const int runId);
	
	/** \brief Empty destructor.
	 */
	virtual ~ExecutionNodeRun();
	
	/** \brief Method to get the test sequence containing the results of testcases.
	 */
	ExecutionSequence* getResultTestSequence() const
	{
		return m_execSequence;
	}
	
	/** \brief Method to execute input test sequence.
	 */
	void executeTestSequence();

private:
	/** \brief Making default constructor private.
	 */
	ExecutionNodeRun();
	
	/** \brief Making assignment operator private.
	 */
	ExecutionNodeRun& operator=(const ExecutionNodeRun&);
	
	/** \brief Making copy constructor private. 
	 */
	ExecutionNodeRun(const ExecutionNodeRun& rhs);
	
	/** \brief Method to setup the environment before execution of input test 
	 sequence.
	 */
	bool setupTestSequence();
	
	/** \brief Method to cleanup the environment after execution of input test
	 sequence.
	 */
	void cleanupTestSequence() const;
	
	/** \brief Method to execute a test plan which is part of input test sequence.
	 */
	void executeTestPlan(const TestPlan* planObj) const;
	
	/** \brief Method to cleanup a test plan which is part of input test sequence.
	 Postprocessing functionality like copying the logs to the server, removing the
	 logs in the client node will be performed.
	 */
	void cleanupTestPlan(const TestPlan* planObj) const;

	/** \brief Method to execute a test case which is part of test plan.
	 */
	void executeTestcase(Testcase* tcObj) const;
	
	/** \brief Method to copy all the folders required for test plan sequence 
	 execution.
	 */
	bool copyPlanSetup() const;
	
	/** \brief host name. */
	string m_hostName;
	
	/** \brief temporary directory created in host to execute testcases. */
	string m_hostTestDir;
	
	/** \brief build dmg path for installation in client location. */
	string m_buildDmgPath;
	
	/** \brief svn checkout path in server location. */
	string m_svnCheckoutPath;
	
	/** \brief execution sequence to be processed. */
	ExecutionSequence* m_execSequence;
	
	/** \brief run Id of the test run that triggered this. */
	int m_runId;
};

}; // end of namespace