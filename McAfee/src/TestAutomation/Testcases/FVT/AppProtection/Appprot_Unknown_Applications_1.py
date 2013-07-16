#!/usr/bin/python

# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16565
# TestcaseDescription: Testcase to check the action taken upon time out

import sys
import logging
import time
import subprocess
import os.path


# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")

# Import CommonTest module into current namespace
from CommonTest import *
import commonFns
import CommonAppProFns
# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 16565")
        logging.info("Description : Testcase to check the action taken upon time out ")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the base initialization
        _retval = BaseTest.init(self)
        if _retval != 0:
            return 1
        self.app_paths = "/Applications/Chess.app"
        self.process="Chess"
        self.sleep_time=12
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1

        CommonAppProFns.resetAppProtToDefaults()
        # Exclude APTT
        logging.debug("Exclude APTT")
        CommonAppProFns.setAppProExclusions([os.path.dirname(\
                os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"])
        return 0

    def execute(self):
        """Executes the test and returns 0 for pass and 1 for fail"""
        logging.info("Executing testcase %s" % testcaseName)

        logging.debug("unchecking allow applesigned binaries")
        if CommonAppProFns.allowAppleSignedBinaries(False) == False :
            logging.error("Failed to uncheck allow applesigned binaries")
            return 1

        logging.debug("Setting unknown app action to 'prompt'")
        if CommonAppProFns.setUnknownAppAction(3) == False :
            logging.error("Failed to set unknown app action to 'Prompt'")
            return 1
        if CommonAppProFns.setAppProtTimeout(10)==False :
            logging.error("Failed to setAppProtTimeout'Prompt'")
            return 1

        logging.info("Executing is done")

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        time.sleep(self.sleep_time)
        try :
            _retval=subprocess.call(["open", self.app_paths], stdout=subprocess.PIPE)
            if _retval != 0:
                logging.info("Failed to Launch Application as expected")
                return 0
            else:
                if commonFns.isProcessRunning(self.process) == True :
                    return 1
        except :
            logging.error("Failed to launch of application")
            return 1        # Check the McAfeeSecurity Log for Deny Message.
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        logging.debug("Copying logs")
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        CommonAppProFns.resetAppProtToDefaults()
        logging.debug("Cleaning the logs")
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
