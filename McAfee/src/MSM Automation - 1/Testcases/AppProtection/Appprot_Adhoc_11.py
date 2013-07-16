#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 17434
# TestcaseDescription: Deleting a user on the system when AppPro is running with default settings 

import sys
import logging
import subprocess
# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    _username="aabbcc"
    _password="ABC123"
    def __init__(self):
        logging.info("TestcaseID : 17434")
        logging.info("Description : Deleting a user on the system when AppPro is running with default settings")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        _retval = BaseTest.init(self)
        if _retval != 0:
            return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        commonFns.createUser(self._username,self._password)
        _retval = subprocess.call( [ "/usr/bin/id",self._username ])
        if _retval == 1:
            logging.error("Creation of user failed. Hence can not test user deletion")
            return 1
        commonFns.deleteUser(self._username)
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        _retval = subprocess.call( [ "/usr/bin/id",self._username ])
        if _retval == 0:
            logging.error("Id still exists. User deletion failed")
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
