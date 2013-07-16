#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16475
# TestcaseDescription:  Testcase to verify the shutting down of appProtd

import sys
import logging
import subprocess
import time

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
        logging.info("TestcaseID : 16475")
        logging.info("Description : Testcase to verify the shutting down of appProtd")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Stop FMP
        if subprocess.call( ["/usr/local/McAfee/fmp/bin/fmp", "stop" ] ) == 0:
            logging.debug("Stopped FMP")
            return 0
        logging.error("Could not stop FMP")
        return 1

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        if commonFns.isProcessRunning("appProtd") == True:
            logging.error("AppProtd is still running")
            return 1
        logging.debug("AppProtd is not running. Success")
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        #start FMP
        subprocess.call(["/usr/local/McAfee/fmp/bin/fmp", "start" ])
        # Adding sleep to allow processes to come up...
        time.sleep(60)

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
