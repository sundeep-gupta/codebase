/************************************************************************
* SMTPReportManager.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/

#include "SMTPReportManager.h"
#include <TestNode.h>
#include <ServerController.h>
#include "trace.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables();

namespace TestAutomationFramework
{

// Constructors/Destructors
//  
SMTPReportManager::~SMTPReportManager ( ) { }

//  
// Methods
//  

void SMTPReportManager::generateTestRunReport ()
{
	trace(serverTrace, 1, "Entering in SMTPReportManager::generateTestRunReport");
	createResultSummary();
	createSubjectAndMessage();
}

/** \brief This function these two functions:
 1.  It creates 'subject' part of the mail.
 2.  It creates 'Message' part of the mail.
 */
	
void SMTPReportManager::createSubjectAndMessage()
{
	trace(serverTrace, 1, "Entering in SMTPReportManager::createSubjectAndMessage");
	char buildNum[PATH_MAX];
	
	snprintf(buildNum, sizeof(buildNum), "%d", getBuildNumber());
	string builStr(buildNum);
	
	m_Subject = "Automation Test Results For Build Number: " + builStr;
	
	vector<string> hostNames = this->getHostnames();
	vector<string>::iterator hostItr = hostNames.begin();
	
	for (; hostItr != hostNames.end(); ++hostItr) {
		ResultSummary resultSummary = getResultSummary(*hostItr);
		
		char passCount[PATH_MAX];
		char failCount[PATH_MAX];
		char blockedCount[PATH_MAX];
		char notRunCount[PATH_MAX];
		
		snprintf(passCount, sizeof(passCount), "%d", resultSummary.getPassCount());
		snprintf(failCount, sizeof(failCount), "%d", resultSummary.getFailCount());
		snprintf(blockedCount, sizeof(blockedCount), "%d", resultSummary.getBlockedCount());
		snprintf(notRunCount, sizeof(notRunCount), "%d", resultSummary.getNotRunCount());
		string passCountStr(passCount);
		string failCountStr(failCount);
		string blockedCountStr(blockedCount);
		string notRunCountStr(notRunCount);
		TestNode testNode = (ServerController::getInstance())->getNodeFromHostName(*hostItr);
		
		if (testNode.getHostName() == *hostItr) {
			m_Message += "\n\n Results for host : "  +  *hostItr + " (PlatForm: " + testNode.getOsName() + " )"
			+ "\n\t Tests Passed :\t" + passCountStr
			+ "\n\t Tests Failed :\t" + failCountStr
			+ "\n\t Tests Not run :\t"	+ notRunCountStr;
		}
		else {
			trace(serverTrace, 1, "reportTestRunResult: hostName not found while creating message");
		}
	}
	m_Message += "\n\n For Detailed results find the log file attached.";
}

/** \brief This function call the STAF API to send mail to the intended recipients
 ** using the generated 'subject', 'message' and 'attachment'.
 */	
void SMTPReportManager::reportTestRunResult()
{
	vector<string> emailIds = getEmailIds();
	string logFileName = getLogFileName();
	
	if (STAFInterface::getInstance()->sendMail(emailIds, m_Message, m_Subject, logFileName)) {
		trace(serverTrace, 1, "SMTPReportManager::reportTestRunResult emails successfully sent to the recipients");
	}
	else {
		trace(serverTrace, 1, "SMTPReportManager::reportTestRunResult failed to send emails to recipients");
	}
}
	
 


}; // End of namespace
