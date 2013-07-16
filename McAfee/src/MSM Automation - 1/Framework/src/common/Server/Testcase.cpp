/************************************************************************
 * Testcase.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/

#include "Testcase.h"
#include "TestcaseFinder.h"
#include "LibXmlWrapper.h"

#define TC_FILE_NAME "/Testcase/FileName"
#define TC_ID "/Testcase/TestcaseID"
#define TC_LAUNCH_PROGRAM "/Testcase/LaunchProgram"
#define TC_DEPENDS "/Testcase/Depends"
#define TC_REQUIRED_FILES "/Testcase/RequiredFiles/File"
#include "trace.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables()
namespace TestAutomationFramework
{
	
Testcase::Testcase(const string &svnCheckoutPath, const string &testcaseName):
	m_result(NOT_RUN), 
	m_depCheckComplete(false),
	m_cycleExists(false)
{
	trace(serverTrace,1,"Testcase::Testcase - Invoked");
	/** Construct XML path. */
	string testName = testcaseName + XML_EXT;
	
	/** Get full testcase XML path by quering the TestcaseFinder object given the SVN path.  
	 The testcase XML file contains all testcase related information.
	 */
	string testcaseXmlPath;
	if(!TestcaseFinder::getTestcaseFinderObject(svnCheckoutPath)->getFullPath(testName, TESTCASE, testcaseXmlPath))
		return;
	
	try
	{
		/** Get testcase related information. */
		LibXmlWrapper xmlObj(testcaseXmlPath);
		
		string testFileName = xmlObj.getXPathStringValue(TC_FILE_NAME);		
		if(!TestcaseFinder::getTestcaseFinderObject(svnCheckoutPath)->getFullPath(testFileName, TESTCASE, m_testcasePathName))
			return;
		
		m_testcaseName = testcaseName;		
		m_testcaseID = xmlObj.getXPathStringValue(TC_ID);
		m_launchProgram = xmlObj.getXPathStringValue(TC_LAUNCH_PROGRAM);
		
		m_depends = xmlObj.getXPathStringValue(TC_DEPENDS);
		
		/** If no dependency, set flag to indicate that no sub-sequence processing required
		 as part of testPlan sequence generation. */
		if(!m_depends.size())
			m_depCheckComplete = true;

		m_requiredFiles = xmlObj.getXPathAllElement(TC_REQUIRED_FILES);
	}
	catch(...)
	{
		trace(serverTrace,1,"Testcase::Testcase Loading testcase file failed");
	}
};
	
	
}; // End of namespace
