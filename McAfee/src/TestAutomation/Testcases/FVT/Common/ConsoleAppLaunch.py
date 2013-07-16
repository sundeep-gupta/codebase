#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID32456 
# TestcaseDescription: Check for Console McAfee Security is running 

import sys
import logging
import subprocess
import time

# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : ID32456")
        logging.info("Description : Check for Console McAfee Security is running") 

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        Cmd = "open " + "/Applications/\"McAfee Security.app\""
        try:
            retval = subprocess.call(Cmd, shell=True)
            if retval == 0:
                logging.debug("Console launched")
                return 0
            else:
                logging.error("Unable to launch Console")
                return 1
        except:
            logging.error("Exception occured while launching console")
            return 1

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        logging.debug("Check if McAfee Security process is running")
        time.sleep(5)
        retval = commonFns.isProcessRunning("McAfee Security")
        if retval == True:
            logging.debug("process McAfee Security is running")
            return 0
        else:
            logging.debug("process McAfee Security is not running")
            return 1

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        Cmd2 = "osascript -e 'tell application \"McAfee Security\" to quit'"
        try:
            retval = subprocess.call(Cmd2, shell=True)
            if retval == 0:
                logging.debug("McAfee Security console is closed")
        except:
            logging.error("Exception occured")
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
