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
	
SVNInterface::SVNInterface(const string &httpUrl):
	m_svnHttpUrl(httpUrl)
{
}

SVNInterface::~SVNInterface() 
{
}

bool SVNInterface::performSvnCheckout(int runId)
{
    trace(serverTrace,4,"SVNInterface::performSvnCheckout Entered for run id = %d",runId);
	string destCheckoutPath = SVN_REPO_DIR;
	
	char strNum[PATH_MAX];
	snprintf(strNum, sizeof(strNum), "%d", runId);
	
	/** Construct path where SVN repository need to be checked-out using Run ID.
	 For every test run, there will be seperate checked out path. */
	string randStr(strNum);
	destCheckoutPath += "/" + string(SERVER_TMP_DIR_PREFIX) + randStr + "/";
	
	/** Create the path for check-out with 777 permission */
	int res = mkdir(destCheckoutPath.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);
	if(res)
    {
        trace(serverTrace,4,"SVNInterface::performSvnCheckout Creation of %s failed. Returning false",destCheckoutPath.c_str());
		return false;
	}
	/** Change permission to 777 in case the above command fails to change permission. */
	chmod(destCheckoutPath.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);
	
	m_svnCheckoutPath = destCheckoutPath;
	
	/** Construct SVN checkout command. */
    
    string svncommandForTrace = "svn co --username=" + ServerController::getInstance()->getSVNUsername() + " --password=********" + " ";
    svncommandForTrace += m_svnHttpUrl;
	svncommandForTrace += " " + destCheckoutPath;
	svncommandForTrace += " 2>&1";
	
    string svnCommand = "svn co --username=" + ServerController::getInstance()->getSVNUsername() + " --password=" + ServerController::getInstance()->getSVNPassword() + " ";
	svnCommand += m_svnHttpUrl;
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
