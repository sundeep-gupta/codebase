#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16422
# TestcaseDescription: "Verify adding a rule for PowerPC PEF application" 

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
        logging.info("TestcaseID : 16422")
        logging.info("Description : Verify adding a rule for PowerPC PEF application")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        self.cfmBinaryPath=os.path.dirname(os.path.abspath(sys.argv[0])) \
                           + "/data/SampleCocoaCarbonApps/Goliath 1.0.1-PEFexecutable"
        
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0: 
            return _retval
        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        # Part of cleanUp    
        CommonAppProFns.resetAppProtToDefaults()

        #Rule to allow execution
        self.rule = {
            'AppPath' : self.cfmBinaryPath,
            'ExecAllowed' : '1',
            'Enabled' : '1',
            'NwAction' : '1'
            }
        return 0
        
    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Addition of the rule must fail here  
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS:
            logging.debug("Addition of rule failed %s", self.rule)
            return 0
        else:
            logging.error("Addition of rule succeded")
            return 1

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # Since addition of rule has failed getAppProtRules() method will be empty  
        self.rule = CommonAppProFns.getAppProtRules()
        if self.rule != []:
            logging.debug("Rules are present")
            return 1
        logging.debug("getAppProtRules returned empty")    
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy all the logs
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        
        # Part of our clean up
        CommonAppProFns.resetAppProtToDefaults()

        # Clean them.
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
