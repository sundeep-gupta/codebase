#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16512
# TestcaseDescription:  Verify application doesn't crash or does not become unresponsive after adding/deleting more that 25 exclusions

import sys
import logging
import os
import re

# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
import CommonAppProFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 16512")
        logging.info("Description : Verify application doesn't crash or does not become unresponsive after adding/deleting more that 25 exclusions")

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
        
        # Step 1 : reset apppro
        CommonAppProFns.resetAppProtToDefaults()
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        
        # Step 0 : Get directory listing of files in /Applications
        files = os.listdir("/Applications")

        # Step 1 : For each of the files, create a rule list.
        _excludedFiles = []
        for file in files:
            if re.search(".app", file) != None:
                _excludedFiles.append(file)
                

        # Step 2 : Add the exclusions
        if CommonAppProFns.setAppProExclusions(_excludedFiles) != True:
            logging.error("Unable to add exclusions")
            return 1

        # Step 3 : Delete the exclusions
        _emptyList = []
        if CommonAppProFns.setAppProExclusions(_emptyList) != True:
            logging.error("Unable to delete exclusions")
            return 1

        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)

        # Step 0: Verify that appProtd is running
        if commonFns.isProcessRunning("appProtd") != True:
            logging.error("appProtd is dead")
            return 1
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        
        # Step 0 : Reset App Pro
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
   