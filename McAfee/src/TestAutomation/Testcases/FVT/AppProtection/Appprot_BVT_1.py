#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 18042
# TestcaseDescription:  This TC is to check for default App Protection settings

import sys
import logging
import os

# Add common folder into the sys path for module importing
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")

import commonFns
import CommonAppProFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 18042")
        logging.info("Description : This TC is to check for default App Protection settings")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        # Step 0 : Install APTT
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Installation of AppPro Test Tool failed.")
            return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        #Step 0 : Get unknown app action
        unknownAppAction=CommonAppProFns.getUnknownAppAction()
        if unknownAppAction != "1":
            logging.error("Unknown App action is not allow %s"% unknownAppAction)
            return 1
        # Step 1 : Get Apple Signed binaries
        if CommonAppProFns.isAppleSignedBinariesAllowed() != True:
            logging.error("Apple signed binaries are not set to allow")
            return 1
        # Step 2 : Check that there are no exclusions
        if len(CommonAppProFns.getAppProExclusions()) != 0:
            logging.error("Exclusion list is not empty")
            return 1
        # Step 3 : Check that there are no rules
        if len(CommonAppProFns.getAppProtRules()) != 0:
            logging.error("AppProt rules list is not empty")
            return 1
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
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
