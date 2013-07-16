/************************************************************************
* LogReportManager.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/

#include "LogReportManager.h"
#include "trace.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables();

namespace TestAutomationFramework
{
// Constructors/Destructors
//  

LogReportManager::LogReportManager ( ) {
}

LogReportManager::~LogReportManager ( ) { }

//  
// Methods
//  

void LogReportManager::generateTestRunReport ( )
{
	trace(serverTrace, 1, "Entering in LogReportManager::generateTestRunReport");
	createLogReport();
}

void LogReportManager::reportTestRunResult ( )
{
	
}

// Other methods
//  


}; // End of namespace
