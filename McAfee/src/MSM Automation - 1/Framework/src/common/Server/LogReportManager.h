/************************************************************************
* LogReportManager.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/


#ifndef LOGREPORTMANAGER_H
#define LOGREPORTMANAGER_H
#include "ReportManager.h"

#include <string>
namespace TestAutomationFramework
{
class LogReportManager : public ReportManager
{
public:

    // Constructors/Destructors
    //  
	LogReportManager::LogReportManager (const map<string, ExecutionSequence* > &executionSeqMap, TestExecutionRequest &request, int runID) 
			:ReportManager(executionSeqMap, request, runID)
	{
			//
	}

    /**
     * Empty Constructor
     */
    LogReportManager ( );

	virtual void generateTestRunReport ( );
	virtual void reportTestRunResult ( );
	
    /**
     * Empty Destructor
     */
    virtual ~LogReportManager ( );

};
}; // End of namespace

#endif // LOGREPORTMANAGER_H
