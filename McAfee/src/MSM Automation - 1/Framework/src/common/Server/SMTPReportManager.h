/************************************************************************
* SMTPReportManager.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/


#ifndef SMTPREPORTMANAGER_H
#define SMTPREPORTMANAGER_H
#include "ReportManager.h"

#include <string>
namespace TestAutomationFramework
{
class SMTPReportManager : public ReportManager
{
public:

    // Constructors/Destructors
    //  
	SMTPReportManager(const map<string, ExecutionSequence* > executionSeqMap,
                      TestExecutionRequest request, 
                      int runID)
                      :ReportManager(executionSeqMap, request, runID)
	{
		
	}

    /**
     * Empty Constructor
     */
    SMTPReportManager ( );

    /**
     * Empty Destructor
     */
    virtual ~SMTPReportManager ( );

	virtual void generateTestRunReport ( );
	virtual void reportTestRunResult ( );
    /**
     */
    void updateSMTPServerSettings ( ) {  }
private:
	void createSubjectAndMessage();
	string m_Subject;
	string m_Message;
};
}; // End of namespace

#endif // SMTPREPORTMANAGER_H
