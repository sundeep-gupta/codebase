#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16369
# TestcaseDescription: Testcase to check the Application store lookup for Unknown / Modified Whitelist application.

import sys
import logging
import time
import shutil
import os
import xml.dom.minidom
from xml.dom.minidom import parse


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
    _application = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/ChildApp" 
    _applicationBackup = _application + "Copy"
    _application2 = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/ParentApp"
    _apttDir = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt"    
    def __init__(self):
        logging.info("TestcaseID : ID16369")
        logging.info("Description : Testcase to check the Application store lookup for Unknown / Modified Whitelist application.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
                return _retval
        # Removing 'traceLog'.
        shutil.copy(self._application, self._applicationBackup)
        # Install AppProt test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        # Creating backup copy of the application, which needs to be modified for the test.
        CommonAppProFns.resetAppProtToDefaults()
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        # Adding rule for application.
        _rule = dict()
        _rule["AppPath"] = self._application;
        _rule["ExecAllowed"] = '1'
        _rule["Enabled"] = '1'
        _rule["NwAction"] = '1'

        _retVal = CommonAppProFns.addAppProtRule(_rule)

        if _retVal != CommonAppProFns.SUCCESS:
            logging.error("rule not get added for application.")
            return 1

        logging.info("rule successfully added for application.")

        logging.info("Getting modification status of application")
        _rules = CommonAppProFns.getAppProtRules()
        _isAppModified = int(_rules[0]["AppModified"])

        if _isAppModified != 0 :
            logging.error("Application is already modified.")
            return 1      

        logging.info("Modifying application")        
        shutil.copy(self._application2, self._application)

        logging.info("Getting modification status of modified application")
        _rules2 = CommonAppProFns.getAppProtRules()
        _isAppModified = int(_rules2[0]["AppModified"])

        if _isAppModified == 0 :
            logging.error("Application is not modified.")
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
        CommonAppProFns.resetAppProtToDefaults()
        shutil.copy(self._applicationBackup, self._application)
        os.remove(self._applicationBackup)
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
