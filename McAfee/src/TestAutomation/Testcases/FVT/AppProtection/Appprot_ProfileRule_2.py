#!/usr/bin/python

# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16564
# TestcaseDescription: Testcase to modify already created profile rule

import sys
import logging
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
        logging.info("TestcaseID : 16564")
        logging.info("Description : Testcase to modify already created profile rule ")

    def init(self):
	logging.info("Initializing testcase %s" % testcaseName)
        # Call the base initialization
        _retval = BaseTest.init(self)
        if _retval != 0:
            return 1
	self.app_paths = "/Applications/Chess.app"
        self.rule = {"AppPath" : self.app_paths,
                     "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"1"}
        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1

        CommonAppProFns.resetAppProtToDefaults()
        return 0

    def execute(self):
        """Executes the test and returns 0 for pass and 1 for fail"""
	logging.info("Executing testcase %s" % testcaseName)
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule")
            return 1
        self.rule["NwAction"] ="2"
        self.rule["Enabled"] ="0"
        if CommonAppProFns.modifyAppProtRule(self.rule)!=CommonAppProFns.SUCCESS:
            logging.error("Failed to Modify Rule")
            return 1
        logging.info("Executing is done")

    def verify(self):
	logging.info("Verifying testcase %s" % testcaseName)
        self.rule2=CommonAppProFns.getAppProtRules()
        self.rule["NwAction"] ="2"
        self.rule["Enabled"] ="0"
        self.rule2=CommonAppProFns.getAppProtRules()
        for key in self.rule:
            if self.rule[key]!=self.rule2[0][key]:
                logging.error(" Rules are not equal")
                return 1;
        if commonFns.isProcessRunning("appProtd")!=True:
            logging.error(" AppPro Process is not running")
            return 1
        # Check the McAfeeSecurity Log for Deny Message.
        logging.info("Rules are modified")
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
