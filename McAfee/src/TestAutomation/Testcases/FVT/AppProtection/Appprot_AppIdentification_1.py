#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16364
# TestcaseDescription: Check whether separate rule to be created if application properties are changed after adding a rule.

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
    _application1Backup = _application1 + "Backup"
    _application2 = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/ParentApp"
    _apttApp = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"
    _apttDir = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt"

    def __init__(self):
        logging.info("TestcaseID : ID16364")
        logging.info("Description : Check whether separate rule to be created if application properties are changed after adding a rule.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
                return _retval
        # Creating backup copy of the application1, which needs to be modified for the test.
        shutil.copy(self._application1, self._application1Backup)

        # Install AppProt test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1

        CommonAppProFns.resetAppProtToDefaults()
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Adding aptt to exclusion list.
        _exclusionList = [self._apttApp]
        _excluRetVal = CommonAppProFns.setAppProExclusions(_exclusionList)

        if _excluRetVal == False:
            logging.error("addition of 'aptt' to exclusion list failed.")
            return 1
        logging.info("Added 'aptt' to exclusion list successfully.")

        # Adding denied rule application.
        _rule1 = dict()
        _rule1["AppPath"] = self._application1;
        _rule1["ExecAllowed"] = '0'
        _rule1["Enabled"] = '1'
        _rule1["NwAction"] = '1'

        _retVal = CommonAppProFns.addAppProtRule(_rule1)

        if _retVal != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule for application (before modification) failed.")
            return 1
        logging.info("Addition of rule for application (before modification) succeeded.")

        # Launching Application1 (before modification).
        _retVal = subprocess.call(["/bin/sh", "-c", self._application1])

        if _retVal != 0:
            logging.info("Application1 launch failed (as expected).")
        else:
            logging.error("Application1 launch succeeded (Not Expected).")
            return 1

        logging.info("Modifying application.")
        try:
            shutil.copy(self._application2, self._application1)    
        except:
            logging.error("Modification of application1 failed.")
            return 1        

        # Launching Application1 (after modification).
        _retVal = subprocess.call(["/bin/sh", "-c", self._application1])

        if _retVal != 0:
            logging.info("Application launch failed as expected.")
        else:
            logging.error("Application launch unexpectedly succeeded.")
            return 1

        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)

        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        shutil.copy(self._application1Backup, self._application1)
        os.remove(self._application1Backup)
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
