/************************************************************************
 * STAFInterface.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/


#ifndef STAFINTERFACE_H
#define STAFINTERFACE_H

#include <iostream>
#include <vector>
#include <STAF.h>
#include <boost/thread/mutex.hpp>

using namespace std;

namespace TestAutomationFramework
{

/** Interface for using STAF commands.
 */

class STAFInterface
{
	
public:

    /** \brief Static method to access the methods of this class
     * Returns a pointer to the object of STAFInterface class
     */
	static STAFInterface *getInstance();
	
    /** \brief Static method to release any memory held by the STAFInterface class.
	 */
	static void releaseInstance();
	
	/** \brief Method to remove directory in host node.
	 Return true if successful, otherwise return false.
	 */
	bool removeDirectory(const string &hostName, const string &destDirPath);
	
	/** \brief Method to create directory in host node.
	 Return true if successful, otherwise return false.
	 */
	bool createDirectory(const string &hostName, const string &destDirPath);
	
	/** \brief Method to copy file to given host node.
	 Return true if successful, otherwise return false.
	 */
	bool copyFile(const string &srcHostName, const string &destHostName, const string &srcFilePath, const string &destDirPath);
	
	/** \brief Method to copy directory (including sub-directories) to given host node.
	 Return true if successful, otherwise return false.
	 */
	bool copyDirectory(const string &srcHostName, const string &destHostName, const string &srcDirPath, const string &destDirPath);

	/** \brief Method to send email (using STAF eamil service) to the mentioned recipients.
	 Return true if mail is successfully sent otherwise false.
	 */	
	bool sendMail(const vector<string> &emailIDs, const string &message, const string &subject,
			const string &attachedFilePath);
	
	/** \brief Method to execute shell command in the given host node.
	 The testcase return value will be provided in cmdRetVal parameter.
	 Return true if execution of command is successful otherwise false.
	 */
	bool executeCommand(const string &hostName, const string &shellCommand, int &cmdRetVal);
	
	/** \brief Method to ping given test node.  This is useful to check
	 whether host node exists in STAF environment.
	 Return true if ping is successful otherwise false.
	 */
	bool pingTestNode(const string &hostName);
	
	
private:
	/** \brief Making empty constructor private.
	 */
	STAFInterface();
	
	/** \brief Making assignment operator private.
	 */
	STAFInterface& operator=(const STAFInterface&);
	
	/** \brief Making copy constructor private.
	 */
	STAFInterface(const STAFInterface& rhs);
	
	/** \brief Making empty destructor private.
	 */
	virtual ~STAFInterface();

	/** \brief Method to create STAF handle.
	 */
	void connectToSTAF();
	
	/** \brief Method to provide execute permission for the given dirFileName.
	 Return result of STAF command.
	 */
	STAFResultPtr provideExecutePermission(const STAFString &machine, const STAFString &dirFileName) const;

	/** \brief mutex to guard  our singleton instance */
	static boost::mutex m_instanceMutex;	
	
	/** \brief pointer to self */
	static STAFInterface *m_instancePtr;
	
	/** \brief STAF function return code */
	STAFRC_t m_lastRetCode;
	
	/** \brief STAF Handle ptr */
	STAFHandlePtr m_stafHandlePtr;
    
	/** \brief flag for staf reconnection */
    bool m_stafReconnectNeeded;
	
};
}; // End of namespace

#endif // STAFINTERFACE_H
