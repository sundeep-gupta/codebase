/************************************************************************
 * SVNInterface.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/

#include "SVNInterface.h"
#include <ServerController.h>
#include <sys/stat.h>
#include <sys/param.h>
#define SVN_REPO_DIR "/private/tmp"
#define SERVER_TMP_DIR_PREFIX "tmp_automation_"

#include "trace.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables();

namespace TestAutomationFramework
{
	
SVNInterface::SVNInterface(const string &httpUrl, const int runId):
m_svnHttpUrl(httpUrl),
m_runId(runId)
{
	char strNum[PATH_MAX];
	snprintf(strNum, sizeof(strNum), "%d", m_runId);
	
	/** Construct path where SVN repository need to be checked-out using Run ID.
	 For every test run, there will be seperate checked out path. */
	string randStr(strNum);
	m_svnCheckoutPath = string(SVN_REPO_DIR) + "/" + string(SERVER_TMP_DIR_PREFIX) + randStr;
}

SVNInterface::~SVNInterface() 
{
}

bool SVNInterface::performSvnCheckout(string dirName)
{
	trace(serverTrace,4,"SVNInterface::performSvnCheckout Entered for dirName = %s", dirName.c_str());

	/** Check whether the directory already exists.  The directory might have already been created because of previous calls. **/
	struct stat fileStat = {};
	if(stat(m_svnCheckoutPath.c_str(), &fileStat) != 0)
	{
		/** Create the path for check-out with 777 permission */
		int res = mkdir(m_svnCheckoutPath.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);
		if(res)
		{
			trace(serverTrace,4,"SVNInterface::performSvnCheckout Creation of %s failed. Returning false",m_svnCheckoutPath.c_str());
			return false;
		}
		
		/** Change permission to 777 in case the above command fails to change permission. */
		chmod(m_svnCheckoutPath.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);		
	}
	
	/** Assumption is that all testcases(test scripts) will be in Testcases directory **/
	/** Check whether the checkout request is for Testcases sub-folder. **/
	size_t pos = dirName.find(TEST_CASES_DIR);
	if(pos != string::npos)
	{
		/** Request is for checkout of specific Testcases sub-folder/folder.  So, first make sure that
		 Testcases folder is created before attempting to create sub-folder. **/
		string testcasesDir = m_svnCheckoutPath + "/" + TEST_CASES_DIR;
		
		/** Check whether the Testcases directory already exists.  The directory might have already been created because of previous calls. **/
		struct stat fileStat = {};
		if(stat(testcasesDir.c_str(), &fileStat) != 0)
		{
			/** Create the path for testcases dir with 777 permission */
			int res = mkdir(testcasesDir.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);
			if(res)
			{
				trace(serverTrace,4,"SVNInterface::performSvnCheckout Creation of %s failed. Returning false",testcasesDir.c_str());
				return false;
			}
			
			/** Change permission to 777 in case the above command fails to change permission. */
			chmod(testcasesDir.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);	
		}
	}
	
	string destCheckoutPath = m_svnCheckoutPath + "/" + dirName;
	
	/** Now create the required folder for check-out. **/
	/** Create the path for check-out with 777 permission */
	int res = mkdir(destCheckoutPath.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);
	if(res)
	{
		trace(serverTrace,4,"SVNInterface::performSvnCheckout Creation of %s failed. Returning false",destCheckoutPath.c_str());
		return false;
	}
	/** Change permission to 777 in case the above command fails to change permission. */
	chmod(destCheckoutPath.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);

	/** Construct SVN checkout command. */
	
	string svncommandForTrace = "svn co --username=" + ServerController::getInstance()->getSVNUsername() + " --password=********" + " ";
	svncommandForTrace += m_svnHttpUrl;
	svncommandForTrace += "/" + dirName + "/";
	svncommandForTrace += " " + destCheckoutPath;
	svncommandForTrace += " 2>&1";
	
	string svnCommand = "svn co --username=" + ServerController::getInstance()->getSVNUsername() + " --password=" + ServerController::getInstance()->getSVNPassword() + " ";
	svnCommand += m_svnHttpUrl;
	svnCommand += "/" + dirName + "/";
	svnCommand += " " + destCheckoutPath;
	svnCommand += " 2>&1";
	trace(serverTrace,4,"SVNInterface::performSvnCheckout  - Using SVN command \"%s\" ",svncommandForTrace.c_str());
	FILE *fp = popen(svnCommand.c_str(), "w");
	int status = -1;
	
	if(fp == NULL)
	{
		trace(serverTrace,4,"SVNInterface::performSvnCheckout  popen failed ");
		return false;
	}
	else
	{
		status = pclose(fp);
		
		// Command successful so return true. /
		if(status != -1)
		{
			trace(serverTrace,4,"SVNInterface::performSvnCheckout Successfully returning");
			return true;
		}
		else
		{
			trace(serverTrace,4,"SVNInterface::performSvnCheckout  pclose failed ");
			return false;
		}
	}
}

bool SVNInterface::removeSvnCheckout()
{
	struct stat fileStat = {};
	trace(serverTrace,4,"SVNInterface::removeSvnCheckout Entering");
	/** Check for existence of checkout entry. */
	if(stat(m_svnCheckoutPath.c_str(), &fileStat) == 0)
	{
		/** Check if this is directory. */
		if(S_IFDIR & fileStat.st_mode)
		{
			/** Construct remove directory command. */
			char bufferCmd[MAXPATHLEN * 4] = {0};
			snprintf(bufferCmd, MAXPATHLEN * 4, "rm -rf \"%s\"", m_svnCheckoutPath.c_str());
			
			/** Execute the remove directory command. */
			FILE *fp = popen(bufferCmd,"r+");
			
			if(fp == NULL)
			{
				trace(serverTrace,4,"SVNInterface::removeSvnCheckout - returning false as popen ");
				return false;
			}
			int retVal = pclose(fp);
			
			/** Return true for command successful execution. */
			if(retVal != -1)
			{
				trace(serverTrace,4,"SVNInterface::removeSvnCheckout - Return true");
				return true;
			}
			else
			{
				trace(serverTrace,4,"SVNInterface::removeSvnCheckout - returning false as pclose ");
				return false;
			}
		}
	}
	trace(serverTrace,4,"SVNInterface::removeSvnCheckout - Checkout path does not exist or is not a directory. Just return true");
	return true;
}
	
}; // End of namespace
