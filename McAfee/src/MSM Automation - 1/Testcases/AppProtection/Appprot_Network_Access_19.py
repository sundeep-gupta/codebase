#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16541
# TestcaseDescription: Testcase to check the action taken upon time out

import sys
import logging
import time
import subprocess
# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
import CommonAppProFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    _application = os.getcwd() + "/data/SampleApplications/ChildApp"
    _apttApp = os.getcwd() + "/data/aptt/appProtTestTool"   
    _apttDir = os.getcwd() + "/data/aptt"

    def __init__(self):
        logging.info("TestcaseID : 16541")
        logging.info("Testcase to check the action taken upon time out")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Install the test tool
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
        _retVal = CommonAppProFns.setAppProExclusions([self._apttApp])
        if _retVal != 0:
            logging.error("Unable to whitelist appProtTestTool.")

        CommonAppProFns.setUnknownAppAction(3)
        CommonAppProFns.setAppProtTimeout(5)

        _retVal = subprocess.call(['/bin/sh', '-c', self._application])        

        return 0

    def verify(self):
        _regex = "Denied " + self._application + " from executing because  unknown applications are blocked" 
        
        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
            logging.info("Application after 'prompt' for certain 'time out' is denied.")
        else:
            logging.error("Expected log not found for 'time out'.")
            return 1

        return 0
        

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.disableApproTrace("reportMgrFlow")
        CommonAppProFns.resetAppProtToDefaults()
        # Clean the logs
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
