#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16365
# TestcaseDescription: Verify that exclusions uses application name and path only.

import sys
import logging
import shutil

# Add common folder into the sys path for module importing
sys.path.append("../Common")
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
    _apttApp = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"
    _apttDir = os.getcwd() + "/data/aptt"

    def __init__(self):
        logging.info("TestcaseID : ID16365")
        logging.info("Description : Verify that exclusions uses application name and path only.")

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

        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Adding application to exclusion list.
        _exclusionList = [self._application1, self._apttApp]
        _excluRetVal = CommonAppProFns.setAppProExclusions(_exclusionList)

        if _excluRetVal == False:
            logging.error("addition of application to exclusion list failed.")
            return 1

        logging.info("application added to exclusion list successfully.")        

        # Setting unknown/modified application to deny.
        CommonAppProFns.setUnknownAppAction(2)

        # Launching Application1 (Before moving to different folder.).
        _retVal = subprocess.call(["/bin/sh", "-c", self._application1])

        if _retVal != 0:
            logging.error("Application1 launch failed.")
            return 1

        # Moving application to a different folder.
        try:
            shutil.move(self._application1, self._application2)
        except:
            logging.error("Failed to move application to a different folder.")

        _retVal = subprocess.call(["/bin/sh", "-c", self._application2])

        if _retVal != 0:
            logging.info("Application launch failed or waiting for user input (as expected).")
        else:
            logging.error("Application1 launch succeeded (Not Expected).")
            return 1

        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)

        _regex = "Denied " + self._application2 + " from executing because  unknown applications are blocked as per the settings"

        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
            logging.info("Expected error message found in the logs")
            return 0
        else:
            logging.info("Expected error message not found in logs")
            return 1

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        shutil.move(self._application2, self._application1)
        CommonAppProFns.resetAppProtToDefaults()
        CommonAppProFns.disableApproTrace("reportMgrFlow")
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
