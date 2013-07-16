#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16514
# TestcaseDescription:  Verify application doesn't crash/does not become unresponsive after settng unknown/modified applicat

import sys
import logging
import os
import subprocess
import time
import re

# Import CommonTest module into current namespace
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
        logging.info("TestcaseID : 16514")
        logging.info("Description : Verify application doesn't crash/does not become unresponsive after settng unknown/modified applicat")

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
        
        # Step 1 : Reset App Pro
        CommonAppProFns.resetAppProtToDefaults()
        
        return 0


    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        
        # Step 0 : Exclude aptt
        if CommonAppProFns.setAppProExclusions( [ os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt" ]) != True:
            logging.error("Unable to add aptt exclusion")
            return 1
        logging.debug("Added exclusion for aptt")

        # Step 1 : Set unknown apps to prompt
        if CommonAppProFns.setUnknownAppAction(3) != True:
            logging.error("Unable to set unknown apps to prompt. Can't proceed")
            return 1
        logging.debug("set unknown app action to prompt")
        if CommonAppProFns.setAppProtTimeout(5) != True:
            logging.error("Unable to set app pro timeout")
            return 1
        logging.debug("set the app protection timeout to 5")
        # Step 2 : Disable apple signed binaries
        if CommonAppProFns.allowAppleSignedBinaries(False) != True:
            logging.error("Unable to set apple signed binaries to false")
            return 1 
                
        # Step 3 : Launch apps.
        files = os.listdir("/Applications")
        i = 0
        for file in files:
            if re.search(".app", file) != None and re.search("McAfee",file) == None and i < 5 :
                try:
                   i = i + 1
                   logging.info("Launching %s %d"% (file,i))
                   subprocess.call(["open","/Applications/"+file],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
                except:
                    pass
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
    sys.exit(retVal)
