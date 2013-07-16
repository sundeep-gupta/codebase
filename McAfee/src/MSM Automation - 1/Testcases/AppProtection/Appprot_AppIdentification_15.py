#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16378
# TestcaseDescription: Verify if a whitelisted application launches another application, which is blacklisted, the child ap.

import sys
import logging

# Add common folder into the sys path for module importing
sys.path.append("../Common")
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
    _apttDir = os.getcwd() + "/data/aptt"
    def __init__(self):
        logging.info("TestcaseID : ID16378")
        logging.info("Description : Verify if a whitelisted application launches another application, which is blacklisted, the child ap.")

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
        return 0

    def execute(self):
        # Adding parent application to whitelist.
        _exclusionList = [self._parentApp]
        _excluRetVal = CommonAppProFns.setAppProExclusions(_exclusionList)

        if _excluRetVal == False:
            logging.error("Addition Parent application to whitelisting failed.")
            return 1

        logging.info("Added Parent application to whitelisting successfully.")
        # Blacklisting the child application.
        _rule2 = dict()
        _rule2["AppPath"] = self._childApp;
        _rule2["ExecAllowed"] = '0'
        _rule2["Enabled"] = '1'
        _rule2["NwAction"] = '1'

        _retVal = CommonAppProFns.addAppProtRule(_rule2)

        if _retVal != CommonAppProFns.SUCCESS:
            logging.error("Adding Child application to whitelisting failed.")
            return 1

        logging.info("Added Child application to blacklist.")
        
        # Launching parent application.        
        _lParentCmd = self._parentApp + " " + self._childApp
        _retVal = subprocess.call(["/bin/sh", "-c", _lParentCmd])      
        
        if _retVal != 0:
            logging.error("Parent application launch failed.")
            return 1      
        
        return _retVal

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        if commonFns.searchProductLog("Denied " +
                                      self._childApp +
                                      " from executing because  of profile rule match with " + self._childApp) == True:
            logging.info("Expected error message found in the logs")
            return 0
        else:
            logging.error("Expected error message not found in the logs.")
            return 1

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        CommonAppProFns.resetAppProtToDefaults()
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
