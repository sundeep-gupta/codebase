#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: lsh-1882
# TestcaseDescription: Testcase to verify the installed version of VirusScan Enterprise for Linux

import sys
import logging
import re
# Add common folder into the sys path for module importing
sys.path.append("./Common")
sys.path.append("..")
#import commonFns
#import commonOASFns
#import commonAntiMalwareFns
import subprocess
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("Testcase ID : LSH-1882")
        logging.info("Description : Testcase to verify the installed version of VirusScan Enterprise for Linux")
        self.expected = '1.7.0'
    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        try :
            _info = commonAntiMalwareFns.getProductInfo()
            if not _info :
                logging.error("Failed to retrieve product info")
                return 1
            self._actual = _info['version']
        except :
            logging.error("Exception occured while running the task")
            return 1
        return 0
    def verify(self):
       
        if self.expected == self._actual :
            logging.info("The installed product version matched with the exisiting version")
            return 0
        else :
            logging.error("The installed build version(%s) does not match with the available built version(%s)" %(self.line, self.productVersion))
            return 1
        return 0
    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
       
        # Copy logs and clean them.
        commonFns.cleanLogs()
        return 0

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
    retVal = retVal + testObj.cleanup()

    if(retVal == 0):
        resultString = "PASS"
    else:
        resultString = "FAIL"
        
    logging.info("Result of testcase %s: %s" % (testcaseName, resultString) )
    sys.exit(retVal)
