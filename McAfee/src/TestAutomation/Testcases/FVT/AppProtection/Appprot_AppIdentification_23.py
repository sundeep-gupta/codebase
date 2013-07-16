#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16389
# TestcaseDescription:  Verify that after renaming an appln the corresponding application rule added with original appln nam.

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
    _application = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/TwoSharedLibs"
    _renameApp = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/NewTwoSharedLibs"
    _apttDir = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt"
    def __init__(self):
        logging.info("TestcaseID : ID16389")
        logging.info("Description : Verify that after renaming an appln the corresponding application rule added with original appln nam.")

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
        CommonAppProFns.resetAppProtToDefaults()
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        # Adding application to blacklisting.
        _rule = dict()
        _rule["AppPath"] = self._application;
        _rule["ExecAllowed"] = '0'
        _rule["Enabled"] = '1'
        _rule["NwAction"] = '1'

        _retVal = CommonAppProFns.addAppProtRule(_rule)        

        if _retVal != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule for application failed.")
            return 1

        logging.info("Addition of rule for application succeded")
        # Re-naming the application.
        logging.info("Renaming the application")
        try:
            shutil.move(self._application, self._renameApp)
        except:
            logging.error("Renaming of application failed")
            return 1            

        # Deleting the rule added for application.    
        _retVal = CommonAppProFns.deleteAppProtRule(_rule)
        if _retVal != CommonAppProFns.SUCCESS:
            logging.error("Deletion of application rule failed.")
            return 1

        logging.info("Deletion of application rule succeeded.")
        
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)

        rules = CommonAppProFns.getAppProtRules()
        numOfRules = len(rules)

        if numOfRules != 0:
            logging.error("Number of rules are still more than than '0'")
            return 1

        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        shutil.move(self._renameApp, self._application)
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
