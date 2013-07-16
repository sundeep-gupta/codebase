#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 1908
# TestcaseDescription: Uninstallation of VSEL 

import sys
import logging
import time
import subprocess
# Add common folder into the sys path for module importing
#sys.path.append("../../Common")
import commonFns
sys.path.append("../Antimalware/")
import commonAntiMalwareFns
import commonOASFns

# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name

testcaseName = sys.argv[0][:-3]
class TestCase(BaseTest):

    def __init__(self):
        logging.info("TestcaseID : 1908")
        logging.info(" Uninstallation of VSEL")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        
        return 0
    
    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
    
        if  commonAntiMalwareFns.UnInstallPackage() != True :
            logging.error("Uninstallation failed")
            return 1
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        if commonAntiMalwareFns.isProductInstalled() == True:
            logging.error("isProductInstalled Failed")
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

        return 0


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
    retVal = retVal = testObj.cleanup()

    if(retVal == 0):
        resultString = "PASS"
    else:
        resultString = "FAIL"

    logging.info("Result of testcase %s: %s" % (testcaseName, resultString) )
    sys.exit(retVal)
