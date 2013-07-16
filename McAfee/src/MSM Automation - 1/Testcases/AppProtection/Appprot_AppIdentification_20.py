#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16383
# TestcaseDescription: Verify if a blacklisted application launches another application, which is blacklisted, the child app.

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
        logging.info("TestcaseID : ID16383")
        logging.info("Description : Verify if a blacklisted application launches another application, which is blacklisted, the child app.")

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

        _rule2 = dict()
        _rule2["AppPath"] = self._childApp;
        _rule2["ExecAllowed"] = '0'
        _rule2["Enabled"] = '1'
        _rule2["NwAction"] = '1'

        _retVal = CommonAppProFns.addAppProtRule(_rule2)

        if _retVal != CommonAppProFns.SUCCESS: 
            logging.error("Child application blacklisting failed.")
            return 1

        logging.info("Child application blacklisted successfully.")
       
        _lParentCmd = self._parentApp + " " + self._childApp      
 
        # Launching Parent Application, which further launch child App.
        _result = subprocess.call(["/bin/sh", "-c", _lParentCmd])
        
        if _result != 0:
            logging.info("Parent Application failed to launch (expected).")
            return 0      
        
        return 1

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        _regex = "Denied " + self._parentApp + " from executing because  of profile rule match with " + self._parentApp

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
