#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16380
# TestcaseDescription: Verify if a whitelisted application launches another appliication,which is a unkown app, the child a.

import sys
import logging
import os

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")

import commonFns
# Import CommonTest module into current namespace
from CommonTest import *
# Import common functions for Application Protection.
import CommonAppProFns
# Get testcase name
testcaseName = sys.argv[0][:-3]
# Import SubProcess module to run processes from command line.
import subprocess

class TestCase(BaseTest):
    _parentApp = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/ParentApp"
    _childApp = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/ChildApp"
    _apttApp = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"
    _apttDir = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt"
    def __init__(self):
        logging.info("TestcaseID : ID16380")
        logging.info("Description : Verify if a whitelisted application launches another appliication,which is a unkown app, the child a")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Install AppProt test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1

        CommonAppProFns.resetAppProtToDefaults()

        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Adding Parent application and 'aptt' to whitelisting.
        _exclusionList = [self._parentApp, self._apttApp]
        _retVal = CommonAppProFns.setAppProExclusions(_exclusionList)

        if _retVal == False:
            logging.error("Adding of Parent Application to whitelist failed.")
            return 1

        logging.info("Parent Application added to whitelist successfully.")
       
        # Setting Unknown/Modified Applications to 'Deny'.        
        _retVal = CommonAppProFns.setUnknownAppAction(2) 

        # Launching Parent Application.
        _lParentCmd = self._parentApp+ " " + self._childApp
        _retVal = subprocess.call(["/bin/sh", "-c", _lParentCmd])      
        
        if _retVal != 0:
            logging.error("Parent Application launch failed.")
            return 1      
        
        return _retVal

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)

        _regex = "Denied " + self._childApp + " from executing because  unknown applications are blocked as per the settings"

        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
            logging.info("Expected error message found in the logs")
            return 0
        else:
            logging.error("Expected error message not found in logs")
            return 1

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        CommonAppProFns.resetAppProtToDefaults()
        CommonAppProFns.disableApproTrace("reportMgrFlow")
        commonFns.cleanLogs()

        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")

        return foundCrash

    def __del__(self):
        pass

if __name__ == "__main__":
    # Setup testcase
    setupTestcase(sys.argv)

    testObj = TestCase()

    # Perform testcase operations
    retVal = testObj.init()

    # Perform execute once initialization succeeds...    
    if(retVal == 0):
        retVal = testObj.execute()

    # Once execution succeeds, perform verification...
    if(retVal == 0):
        retVal = testObj.verify()

    # Perform testcase cleanup
    retVal += testObj.cleanup()

    if(retVal == 0):
        resultString = "PASS"
    else:
        resultString = "FAIL"
        
    logging.info("Result of testcase %s: %s" % (testcaseName, resultString) )
    sys.exit(retVal)
