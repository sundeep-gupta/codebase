/************************************************************************
 * SVNInterface.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/


#ifndef SVNINTERFACE_H
#define SVNINTERFACE_H

#include <iostream>
using namespace std;

namespace TestAutomationFramework
{
/** Interface for using SVN commands.
 */
class SVNInterface
{
public:
	
	/** \brief Constructor to create object.
	 */
	SVNInterface(const string &httpUrl, const int runId);
	
	/** \brief Empty Destructor.
	 */
	virtual ~SVNInterface();
	
	/** \brief Method to get checked out directory path.
	 */
	string getSvnCheckoutPath() const
	{
		return m_svnCheckoutPath;
	}
	
	/** \brief Method to perform SVN checkout.
	 Enter dirName value for any sub-directory checkouts inside TestAutomation folder.
	 Return true if successful, otherwise return false.
	 */
	bool performSvnCheckout(string dirName);
	
	/** \brief Method to remove checked out directory.
	 Return true if successful, otherwise return false.
	 */
	bool removeSvnCheckout();
	
private:
	/** \brief Making empty constructor private.
	 */
	SVNInterface();
	
	/** \brief Making assignment operator private.
	 */
	SVNInterface& operator=(const SVNInterface&);
	
	/** \brief Making copy constructor private.
	 */
	SVNInterface(const SVNInterface& rhs);
	
	/** \brief SVN repository Http URL. */
	string m_svnHttpUrl;
	
	/** \brief Run ID of the request for use during checkout. */
	int m_runId;
	
	/** \brief SVN checked-out path. */
	string m_svnCheckoutPath;
};
}; // End of namespace

#endif // SVNINTERFACE_H
