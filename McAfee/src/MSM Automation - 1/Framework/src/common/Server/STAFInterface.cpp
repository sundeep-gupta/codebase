/************************************************************************
 * STAFInterface.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/


#include "STAFInterface.h"
#include <fstream>
#include "trace.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables();
#define TRUST_SERVICE "TRUST"
#define PING_SERVICE "PING"
#define PROCESS_SERVICE "PROCESS"
#define MAIL_SERVICE "EMAIL"
#define FILE_SYSTEM_SERVICE "FS"
#define LOCAL_MACHINE "LOCAL"

namespace TestAutomationFramework
{
	
STAFInterface *STAFInterface::m_instancePtr = NULL;
boost::mutex STAFInterface::m_instanceMutex;	

STAFInterface *STAFInterface::getInstance()
{
	if(m_instancePtr == NULL)
	{
		boost::mutex::scoped_lock lck(m_instanceMutex);
		if (m_instancePtr == NULL)
			m_instancePtr = new STAFInterface();
	}
	return m_instancePtr;
}

void STAFInterface::releaseInstance()
{
	boost::mutex::scoped_lock lock(m_instanceMutex);
	
	if(m_instancePtr)
		delete m_instancePtr;
	m_instancePtr = NULL;
}

STAFInterface::STAFInterface()
{
    trace(serverTrace,1, "STAFInterface::STAFInterface"); 
	connectToSTAF();
}

STAFInterface::~STAFInterface()
{
}

void STAFInterface::connectToSTAF() 
{
    trace(serverTrace,5,"STAFInterface::connectToSTAF - Connecting to and using UTF8 ");
    const STAFString str("harnessServer");
    m_lastRetCode = STAFHandle::create(str, m_stafHandlePtr);
    trace(serverTrace,5,"STAFInterface::connectToSTAF - Connecting to %s %d",str.buffer(),m_lastRetCode);

}

bool STAFInterface::removeDirectory(const string &hostName, const string &destDirPath) 
{
	if(!m_stafHandlePtr)
    {
        trace(serverTrace,1,"STAFInterface::removeDirectoryInTestNode - Invalid STAF handle - returning false");
		return false;
	}
	STAFString destDir(destDirPath.c_str());
	
	STAFString machine(hostName.c_str());
	STAFString service(FILE_SYSTEM_SERVICE);
	/** Request for delete directory with relevant options */
	STAFString request = "DELETE ENTRY " + STAFHandle::wrapData(destDir) + " RECURSE CONFIRM IGNOREERRORS";
	
	STAFResultPtr resultPtr = m_stafHandlePtr->submit(machine, service, request);
	
	if (resultPtr->rc != kSTAFOk)
    {
        if(resultPtr->rc == kSTAFHandleDoesNotExist)
        {
            connectToSTAF();
        }
        trace(serverTrace,1, "STAFInterface::removeDirectoryInTestNode rc=%d and result = %s", resultPtr->rc, resultPtr->result.buffer());
        return false;
    }
    trace(serverTrace,1, "STAFInterface::removeDirectoryInTestNode  Exiting");
	return true;	
}
	
STAFResultPtr STAFInterface::provideExecutePermission(const STAFString &machine, const STAFString &dirFileName) const
{
	if(m_stafHandlePtr)
	{	
		STAFString chmodCommand = STAFString("chmod -R +x ") + dirFileName;
	
		STAFString service = PROCESS_SERVICE;
		/** Request for execute permission shell command. */
		STAFString request = "START SHELL COMMAND " + STAFHandle::wrapData(chmodCommand) + " RETURNSTDOUT STDERRTOSTDOUT WAIT";
	    trace(serverTrace,1, "STAFInterface::provideExecutePermission  Exiting successfully");
		return m_stafHandlePtr->submit(machine, service, request);
	}
    else 
    {
        trace(serverTrace,1, "STAFInterface::provideExecutePermission  Exiting with failure");
        return STAFResultPtr();
    }

    
}
	
bool STAFInterface::createDirectory(const string &hostName, const string &destDirPath) 
{
    trace(serverTrace,1,"STAFInterface:createDirectoryInTestNode entered for %s",hostName.c_str());
	if(!m_stafHandlePtr)
    {
        trace(serverTrace,1,"STAFInterface:createDirectoryInTestNode  - No valid staf handle");
		return false;
	}
	
	STAFString destDir(destDirPath.c_str());
	
	STAFString machine(hostName.c_str());
	STAFString service(FILE_SYSTEM_SERVICE);
	/** Request for create directory with relevant options. */
	STAFString request = "CREATE DIRECTORY " + STAFHandle::wrapData(destDir) + " FAILIFEXISTS";
	
	STAFResultPtr resultPtr = m_stafHandlePtr->submit(machine, service, request);
	
	if (resultPtr->rc != kSTAFOk)
		return false;
	
	/** Provide execute permission for the directory created. */
	resultPtr = provideExecutePermission(machine, destDir);
	
	if(resultPtr && resultPtr->rc != kSTAFOk)
    {
        trace(serverTrace,1,"STAFInterface:createDirectoryInTestNode  -Error with code %d ",resultPtr->rc);
        if(resultPtr->rc == kSTAFHandleDoesNotExist)
        {
            connectToSTAF();
        }
        
        trace(serverTrace,1, "STAFInterface::createDirectoryInTestNode rc=%d and result = %s", resultPtr->rc, resultPtr->result.buffer());

		return false;
    }	
    trace(serverTrace,1, "STAFInterface::createDirectoryInTestNode  Exiting");

	return true;	
}	
	
bool STAFInterface::copyFile(const string& srcHostName, const string& destHostName, const string &srcFilePath, const string &destDirPath) 
{
	if(!m_stafHandlePtr)
		return false;
	
	STAFString srcFileName(srcFilePath.c_str());
	STAFString destDirName(destDirPath.c_str());
	
	STAFString testHostName(destHostName.c_str());
	
	STAFString machine(srcHostName.c_str());
	STAFString service(FILE_SYSTEM_SERVICE);
	/** Request for copy file with relevant options. */
	STAFString request = "COPY FILE " + STAFHandle::wrapData(srcFileName) + " TODIRECTORY " + STAFHandle::wrapData(destDirName) 
	+ " TOMACHINE " + testHostName;
	
	STAFResultPtr resultPtr = m_stafHandlePtr->submit(machine, service, request);
	
	if (resultPtr->rc != kSTAFOk)
		return false;

	unsigned int pos = srcFilePath.find_last_of("/");
	
	string srcLeafName("");
	if(pos < (srcFilePath.size()-1))
		srcLeafName = srcFilePath.substr(pos+1);
	
	string destFilePath = destDirPath + "/" + srcLeafName;
	STAFString destFileName(destFilePath.c_str());
	
	/** Provide execute permission for the copied file. */
	resultPtr = provideExecutePermission(testHostName, destFileName);
	
	if(resultPtr && resultPtr->rc != kSTAFOk)
    {
        if(resultPtr->rc == kSTAFHandleDoesNotExist)
        {
            connectToSTAF();
        }
        trace(serverTrace,1, "STAFInterface::copyFileToTestNode rc=%d and result = %s", resultPtr->rc, resultPtr->result.buffer());
		return false;
	}
    trace(serverTrace,1, "STAFInterface::copyFileToTestNode  Exiting");

	return true;
}

bool STAFInterface::copyDirectory(const string& srcHostName, const string& destHostName, const string &srcDirPath, const string &destDirPath) 
{
	if(!m_stafHandlePtr)
		return false;
	
	STAFString srcDirName(srcDirPath.c_str());
	STAFString destDirName(destDirPath.c_str());
	
	STAFString testHostName(destHostName.c_str());
	
	STAFString machine(srcHostName.c_str());
	STAFString service(FILE_SYSTEM_SERVICE);
	/** Request for copy directory with relevant options. */
	STAFString request = "COPY DIRECTORY " + STAFHandle::wrapData(srcDirName) + " TODIRECTORY " + STAFHandle::wrapData(destDirName) 
	+ " TOMACHINE " + testHostName + " RECURSE KEEPEMPTYDIRECTORIES IGNOREERRORS";
	
	STAFResultPtr resultPtr = m_stafHandlePtr->submit(machine, service, request);
	
	if (resultPtr->rc != kSTAFOk)
		return false;
	
	/** Provide execute permission for the copied directory. */
	resultPtr = provideExecutePermission(testHostName, destDirName);
	
	if(resultPtr && resultPtr->rc != kSTAFOk)
	{
		if(resultPtr->rc == kSTAFHandleDoesNotExist)
		{
			connectToSTAF();
		}
        trace(serverTrace,1, "STAFInterface::copyDirectoryToTestNode rc=%d and result = %s", resultPtr->rc, resultPtr->result.buffer());
		return false;
	}
    trace(serverTrace,1, "STAFInterface::copyDirectoryToTestNode  Exiting");

	return true;
}
	
bool STAFInterface::executeCommand(const string &hostName, const string &shellCommand, int &cmdRetVal) 
{
	if(!m_stafHandlePtr)
		return false;
	
	cmdRetVal = -1;
	
	STAFString shellCmd(shellCommand.c_str());
	
	STAFString machine(hostName.c_str());
	STAFString service(PROCESS_SERVICE);
	/** Request to start shell command and wait for the result. */
	STAFString request = "START SHELL COMMAND " + STAFHandle::wrapData(shellCmd) + " RETURNSTDOUT STDERRTOSTDOUT WAIT";
	
	STAFResultPtr resultPtr = m_stafHandlePtr->submit(machine, service, request);
	
	if(resultPtr->rc != kSTAFOk)
    {
        if(resultPtr->rc == kSTAFHandleDoesNotExist)
        {
            connectToSTAF();
        }
        trace(serverTrace,1, "STAFInterface::executeCommand rc=%d and result = %s", resultPtr->rc, resultPtr->result.buffer());
		return false;
	}

	resultPtr->resultContext = STAFObject::unmarshall(resultPtr->result);
	resultPtr->resultObj = resultPtr->resultContext->getRootObject();
	
	/** Now, get the command result and store it in parameter. */
	STAFString retVal = resultPtr->resultObj->get("rc")->asString();
	string retValStr = retVal.buffer();
	
	long lRetVal = strtol(retValStr.c_str(), (char **) NULL, 10);
	cmdRetVal = (int) lRetVal;
    trace(serverTrace,1, "STAFInterface::executeCommand  Exiting");

	return true;
}

bool STAFInterface::sendMail(const vector<string> &emailIDs, const string &message, const string &subject, const string &attachedFilePath)
{
	if(!m_stafHandlePtr)
		return false;
		
	STAFString s_Message(message.c_str());
	STAFString s_Subject(subject.c_str());
	STAFString filePath(attachedFilePath.c_str());
	STAFString service(MAIL_SERVICE);
	vector<string>::const_iterator mailItr = emailIDs.begin();
	
	// Sending email (using STAF eamil service) to the mentioned recipients one by one.
	for (; mailItr != emailIDs.end(); ++mailItr) {
		STAFString s_EmailID((*mailItr).c_str());
		STAFString request = "SEND TO " + STAFHandle::wrapData(s_EmailID) + " MESSAGE " + STAFHandle::wrapData(s_Message) + " SUBJECT "
				+ STAFHandle::wrapData(s_Subject) + " TEXTATTACHMENT " + STAFHandle::wrapData(filePath);
			
		// trace(serverTrace,1, "STAFInterface::sentMail STAF command for sending mail is: %s", request.buffer()); 
		STAFResultPtr resultPtr = m_stafHandlePtr->submit(LOCAL_MACHINE, service, request);
		
		trace(serverTrace,1, "\nSTAFInterface::sentMail rc=%d and result = %s", resultPtr->rc, resultPtr->result.buffer());	  
		if(resultPtr->rc != kSTAFOk)
		{
			if(resultPtr->rc == kSTAFHandleDoesNotExist)
			{
				connectToSTAF();
			}
			return false;
            trace(serverTrace,1, "STAFInterface::sendMail rc=%d and result = %s", resultPtr->rc, resultPtr->result.buffer());

		}
	}
    trace(serverTrace,1, "STAFInterface::sendMail  Exiting");
	return true;
}	
	
bool STAFInterface::pingTestNode(const string& hostName) 
{
    trace(serverTrace,1, "STAFInterface::pingTestNode  Entered");
	if(!m_stafHandlePtr)
    {
        trace(serverTrace,1,"STAFInterface:pingTestNode  - No valid staf handle");
		return false;
    }
	//trace(serverTrace,1, "returning true \n");
    //return true;
	STAFString machine = hostName.c_str();
	STAFString service(PING_SERVICE);
	/** Request for ping. */
	STAFString request("PING");
	
	STAFResultPtr resultPtr = m_stafHandlePtr->submit(machine, service, request);
	
	/** If ping is successful, STAF returns "PONG". */
	if (resultPtr->rc != kSTAFOk || resultPtr->result != "PONG")
    {
        trace(serverTrace,1, "STAFInterface::pingTestNode rc=%d and result = %s", resultPtr->rc, resultPtr->result.buffer());
        if(resultPtr->rc == kSTAFHandleDoesNotExist)
        {
            connectToSTAF();
        }
		return false;
	}
    trace(serverTrace,1, "STAFInterface::pingTestNode  Exiting");

	return true;
}

}; // End of namespace
