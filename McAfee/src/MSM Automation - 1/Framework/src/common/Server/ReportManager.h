/************************************************************************
* ReportManager.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/


#ifndef REPORTMANAGER_H
#define REPORTMANAGER_H

#include "TestExecutionRequest.h"
#include "ExecutionSequence.h"

using namespace std;

namespace TestAutomationFramework
{
/**\brief Class stores the result summary for each test node.
 *
 */
class ResultSummary {
public:
	ResultSummary() {
		m_BlockedCount = 0;
		m_NotRunCount = 0;
		m_PassCount = 0;
		m_FailCount = 0;
	}
	
	~ResultSummary() {}
	
	ResultSummary& operator=(const ResultSummary& rhs)
	{
		m_BlockedCount = rhs.m_BlockedCount;
		m_PassCount = rhs.m_PassCount;
		m_FailCount = rhs.m_FailCount;
		m_NotRunCount = rhs.m_NotRunCount;
	}
	
	ResultSummary(const ResultSummary& rhs) 
	{
		m_BlockedCount = rhs.m_BlockedCount;
		m_PassCount = rhs.m_PassCount;
		m_FailCount = rhs.m_FailCount;
		m_NotRunCount = rhs.m_NotRunCount;
	}
	
	void incrementBlockCount()	{ m_BlockedCount++;}
	void incrementPassCount()	{ m_PassCount++;}
	void incrementFailCount()	{ m_FailCount++;}
	void incrementNotRunCount()	{ m_NotRunCount++;}
	
	unsigned int getBlockedCount()	{ return m_BlockedCount; } 
	unsigned int getPassCount()	{ return m_PassCount; }
	unsigned int getFailCount() { return m_FailCount; }
	unsigned int getNotRunCount() {return m_NotRunCount; }
private:
	unsigned int m_BlockedCount;
	unsigned int m_NotRunCount;
	unsigned int m_PassCount;
	unsigned int m_FailCount;		
};
	
	
class ReportManager
{
public:
	// Constructors/Destructors
    //  
    /**
     * Empty Constructor
     */
    ReportManager ( ) {	}
	
    /**
     * Empty Destructor
     */
    virtual ~ReportManager ( );
	
	ReportManager(const map<string, ExecutionSequence* > executionSeqMap,
			TestExecutionRequest request, int runID): m_ExecSequenceMap(executionSeqMap)
	{
		m_Request = request;
		m_RunID = runID;
		m_ResultSummaryMap.clear();
		
		char locRunID[PATH_MAX];
		snprintf(locRunID, sizeof(locRunID), "%d", m_RunID);
		string runIDStr(locRunID);
		
		m_LogFilePath = "/usr/local/TAF/var/Run_" + runIDStr  + "/ResultSummary.log";
	}
	
	/** \brief Method to create create 'log' file.
     */
	void createLogReport();
	/** \brief Method to create create result summary.
     */
	void createResultSummary();

	/**\brief Method to generate the required repord data e.g. 'log' file,
	 ** result summary, subject, message.
     */
    virtual void generateTestRunReport ( );
	
    /** \brief Method to send report to the relevent server (SMTP, TestLink).
     */
    virtual void reportTestRunResult ( ) { }
	
	/** \brief Method to collect the test run result.
     */
	const ExecutionSequence* getExecSequence(string hostName) const;
	
	const vector<string> getHostnames() const
	{
		return m_Request.getHostNames();
	}
	
	int getBuildNumber() const 
	{
		return m_Request.getBuildNo();
	}
	
	const eTestType getTestType() const
	{
		return m_Request.getTestType();
	}
	
	const vector<string> getEmailIds() const
	{
		return m_Request.getEmailId();
	}
		
	const string getBranchName() const
	{
		// TODO: extract branch name from the 'svn path'.
	}
	const ResultSummary getResultSummary(const string hostName) const;
	
	const string getLogFileName()
	{
		return m_LogFilePath;
	}
	
	const int getRunID() const	{
		return m_RunID;
	}
	
private:
	ReportManager& operator=(const ReportManager&);
	ReportManager(const ReportManager& rhs);
	void setResultSummary(string hostName, const ResultSummary resultSummary);	

	map<string, ExecutionSequence*> m_ExecSequenceMap;
	TestExecutionRequest m_Request;
	int m_RunID;
	map<string, ResultSummary> m_ResultSummaryMap;
	string m_LogFilePath;
};
}; // End of namespace

#endif // REPORTMANAGER_H
