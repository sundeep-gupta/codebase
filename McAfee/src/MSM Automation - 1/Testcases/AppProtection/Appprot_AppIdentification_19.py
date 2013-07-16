#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16382
# TestcaseDescription:  Verify if a blacklisted application launches another application, which is whitelisted, the child application launches fine.

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
        logging.info("TestcaseID : ID16382")
        logging.info("Description : Verify if a blacklisted application launches another application, which is whitelisted, the child application launches fine.")

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
        logging.info("Executing testcase %s" % testcaseName)
        # Adding Child application to whitelisting.
        _exclusionList = [self._childApp]
        _excluRetVal = CommonAppProFns.setAppProExclusions(_exclusionList)

        if _excluRetVal == False:
            logging.error("Failed to add child app to whitelisting.")
            return 1

        logging.info("Child Application added to whitelist successfully.")
        # Adding Parent and Child applications to blacklisting.
        _rule1 = dict()
        _rule1["AppPath"] = self._parentApp;
        _rule1["ExecAllowed"] = '0'
        _rule1["Enabled"] = '1'
        _rule1["NwAction"] = '1'

        _retVal = CommonAppProFns.addAppProtRule(_rule1)        

        if _retVal != CommonAppProFns.SUCCESS:
            logging.error("Parent application blacklisting failed.")
            return 1

        logging.info("Parent application blacklisted successfully.")
      
        # Launching Child Application.
        _retVal = subprocess.call(["/bin/sh", "-c", self._childApp])
        
        if _retVal != 0:
            logging.error("Child Application launch failed.")
            return 1      
        
        return _retVal

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        if commonFns.searchProductLog("Denied " +
                                      self._childApp +
                                      " from executing because  of profile rule match with " + self._childApp) == True:
            logging.error("Child application launch denied.")
            return 1
        else:
            return 0

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
