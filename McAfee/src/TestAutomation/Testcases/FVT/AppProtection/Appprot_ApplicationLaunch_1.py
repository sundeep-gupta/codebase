#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16397
# TestcaseDescription: Testcase to verify the multi-path support for applications

import sys
import logging
import os
import shutil
import subprocess

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
        logging.info("TestcaseID : 16397")
        logging.info("Description : Testcase to verify the multi-path support for applications")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1


        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()

        # Set exclusion for appProtTestTool
        logging.debug("Exclude APTT ")
        CommonAppProFns.setAppProExclusions([os.path.dirname(
                os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"])


        # Additional init code will go here !
        self.app_actual = os.path.dirname(os.path.abspath(sys.argv[0]))\
                + "/data/SampleApplications/UDPClient"
        self.app_new = self.app_actual + "_new"
        self.rule1 = {"AppPath" : self.app_actual, "Enabled" : "1",
                     "ExecAllowed":"0",
                     "NwAction":"1"}
        if os.path.exists(self.app_new) :
            try :
                logging.debug("Already app exist removing it.")
                os.remove(self.app_new)
            except :
                logging.error("Failed to remove pre-existing app ")
                return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Add rule to deny application execution
        logging.debug("Add rule to deny application execution")
        if CommonAppProFns.addAppProtRule(self.rule1) != CommonAppProFns.SUCCESS :
            logging.error("Failed to set deny rule for %s" % self.rule1["AppPath"])
            return 1

        # Copy the application to another location.
        try :
            logging.debug("Copying %s to %s" % (self.app_actual, self.app_new))
            shutil.copy(self.app_actual, self.app_new)
        except :
            logging.error("Failed to copy!")
            return 1

        # Now launch app_new
        try :
            logging.debug("Launching %s" % self.app_new)
            subprocess.Popen([self.app_new, "127.0.0.1", "1000", "Test"],\
                    stdout=subprocess.PIPE)
            # We expect an exception, thus coming here fails the testcase
            logging.error("Application got launced.")
            return 1
        except:
            logging.debug("Failed to launch application as expected")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # Check the McAfeeSecurity Log for Deny Message.
        if commonFns.searchProductLog(CommonAppProFns.REGEX_DENIED_RULE) != True :
            logging.error("Application is not blocked by AppProt")
            return 1


        # Additional verify code will go here !

        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        commonFns.cleanLogs()
        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()


        # Additional clean code will go here !
        # Remove the copied application
        try :
            os.remove(self.app_new)
        except :
            logging.error("Failed to remove %s" % self.app_new)

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
