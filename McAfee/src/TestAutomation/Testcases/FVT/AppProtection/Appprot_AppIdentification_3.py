#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16366
# TestcaseDescription: Multiple paths for the same application shall be supported.

import sys
import logging
import shutil
import os

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")


import commonFns
# Import CommonTest module into current namespace
from CommonTest import *
# Import common functions for Application Protection.
import CommonAppProFns
# Get testcase name
testcaseName = sys.argv[0][:-3]
# Import SubProcess module to run processes from command line.
import subprocess

class TestCase(BaseTest):
    _application1 = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/ChildApp" 
    _application2 = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt/ChildApp"
    _apttDir = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt"
    def __init__(self):
        logging.info("TestcaseID : ID16366")
        logging.info("Description : Multiple paths for the same application shall be supported.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
                return _retval
        # Install AppProt test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1

        # Creating backup copy of the application1, which needs to be modified for the test.
        CommonAppProFns.resetAppProtToDefaults()

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Adding rule for application to deny its execution.
        _rule1 = dict()
        _rule1["AppPath"] = self._application1;
        _rule1["ExecAllowed"] = '0'
        _rule1["Enabled"] = '1'
        _rule1["NwAction"] = '1'

        _retVal = CommonAppProFns.addAppProtRule(_rule1)

        if _retVal != CommonAppProFns.SUCCESS:
            logging.error("Adding rule for application failed.")
            return 1

        logging.info("Rule added successfully for application.")

        # Launching Application1 (Before moving to different folder.).
        _retVal = subprocess.call(["/bin/sh", "-c", self._application1])

        if _retVal == 0:
            logging.error("Application launched (Unexpected behavior.")
            return 1
        else:
            logging.info("Application fails to launch (as expected).")

        # Copying application to a different folder.
        try:
            shutil.copy(self._application1, self._application2)
        except:
            logging.error("Failed to copy application to a different folder.")

        logging.info("Launching application from different location.")
        _retVal = subprocess.call(["/bin/sh", "-c", self._application2])

        if _retVal != 0:
            logging.info("Application launch failed(as expected).")
        else:
            logging.error("Application launch succeeded (UnExpected).")
            return 1

        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)

        if commonFns.searchProductLog("Denied " +
                                      self._application2 +
                                      " from executing because  unknown applications are blocked as per the settings") == True:
            logging.error("UnExpected error message found in the logs")
            return 1
        else:
            logging.info("No error message found in logs (as expected)")
            return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        os.remove(self._application2)
        CommonAppProFns.resetAppProtToDefaults()
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
