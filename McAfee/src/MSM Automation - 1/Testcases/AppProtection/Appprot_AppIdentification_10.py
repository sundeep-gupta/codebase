#!/usr/bin/python

# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16373
# TestcaseDescription: Testcase to check the launch of multiple applications 

import sys
import logging
import subprocess
import os.path
# Add common folder into the sys path for module importing
sys.path.append("../Common")

# Import CommonTest module into current namespace
from CommonTest import *
import commonFns
import CommonAppProFns
# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 16373")
        logging.info("Description : Testcase to check the launch of multiple applications ")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the base initialization
        _retval = BaseTest.init(self)
        if _retval != 0:
            return 1
        self.app_path = ['/Applications/Calculator.app',os.path.dirname(\
                os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"]
               
        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        CommonAppProFns.resetAppProtToDefaults()
        self.process=['Calculator','Dictionary']
        if CommonAppProFns.setAppProExclusions(self.app_path) != True:
            logging.error("Failed to add Exclusions")
            return 1

        if CommonAppProFns.allowAppleSignedBinaries(False)!=True:
            return 1
        return 0

    def execute(self):
        """Executes the test and returns 0 for pass and 1 for fail"""
        logging.info("Executing testcase %s" % testcaseName)
        if CommonAppProFns.setUnknownAppAction(2)!=True:
            logging.error("Failed to setUnknownAppAction")
            return 1

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        try :
            _retval=subprocess.call(["open", "/Applications/Calculator.app"], stdout=subprocess.PIPE)
            if _retval == 0:
                return 0
            else:
                return 1
        except :
            logging.error("Failed to launch of calculator application")
            return 1
        try :
            _retval=subprocess.call(["open", "/Applications/Dictionary.app"], stdout=subprocess.PIPE)
            if _retval != 0:
                return 0
            else:
                return 1
        except :
            logging.error("Failed to launch of Dictonary application")
            return 0
        logging.info("Verifying testcase %s" % testcaseName)
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        logging.debug("Copying logs")
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        CommonAppProFns.resetAppProtToDefaults()
        if CommonAppProFns.setUnknownAppAction(1)!=True:
            logging.error("Failed to setUnknownAppAction")
            return 1

        CommonAppProFns.allowAppleSignedBinaries(True)
        logging.debug("Cleaning the logs")
        commonFns.cleanLogs()
        for key in self.process:
            if commonFns.isProcessRunning(key) == True:
                try :
                    logging.debug("%s already running. Killing it" % key)
                    subprocess.call(["killall", "-SIGTERM", key], stdout=subprocess.PIPE)
                except :
                    logging.error("Failed to kill existing %s instance" % key)
                    return 1


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
	testObj.execute()

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
