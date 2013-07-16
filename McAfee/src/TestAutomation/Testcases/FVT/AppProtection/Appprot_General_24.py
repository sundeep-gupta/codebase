#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16496
# TestcaseDescription:  Verify that application protecton kext is loaded when application protection daemon is started

import sys
import re
import logging
import time
import subprocess
import os

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
        logging.info("TestcaseID : 16496")
        logging.info("Description :Verify that application protecton kext is loaded when application protection daemon is started")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # Lets verify that process is running
        if commonFns.isProcessRunning('appProtd') == False:
            logging.error("App Protection daemon is not running")
            return 1
        logging.info("appProtd is running")
        # Lets verify that kext is loaded
        _process = subprocess.Popen( [ "kextstat", 
                                     "-b", 
                                     "com.McAfee.kext.AppProtection" ] ,
                                     stdout=subprocess.PIPE,
                                     stderr=subprocess.PIPE) 
        _result = _process.communicate()
        _retval= re.search("com.McAfee.kext.AppProtection",_result[0])
        if _retval == None:
            logging.error("App Protection kext is not loaded ")
            return 1
        logging.info("App Protection kext is loaded")
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
