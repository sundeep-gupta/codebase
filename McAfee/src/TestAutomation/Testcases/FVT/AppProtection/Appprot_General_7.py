#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16479
# TestcaseDescription:  Testcase to verify loading of preference information from plist file

import sys
import logging
import time
import subprocess
import os

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
        logging.info("TestcaseID : 16479")
        logging.info("Description : Testcase to verify loading of preference information from plist file")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Installation of AppPro Test Tool failed.")
            return 1
        
        CommonAppProFns.resetAppProtToDefaults()
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Disable App pro
        if CommonAppProFns.disableAppProt() != True:
            logging.error("Unable to disable app protection")
            return 1
        logging.debug("Disabled app Protection")

        # Add a rule - Lets Add a rule for UDPClient binary
        self._rule = dict()
        self._rule["AppPath"]= os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/UDPServer"
        self._rule["ExecAllowed"]="1"
        self._rule["Enabled"]="1"
        self._rule["NwAction"]="1"
        _retval = CommonAppProFns.addAppProtRule(self._rule)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule failed with code %d" % _retval)
            return 1
        #enable App Protection
        if CommonAppProFns.enableAppProt() != True:
            logging.error("Unable to enable app protection")
            return 1
        logging.debug("Enabled app Protection")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        _rules = dict()
        _rules = CommonAppProFns.getAppProtRules()
        if _rules == None:
            logging.error("Rulesset by us are lost")
            return 1
        # Since we added only one rule, we expect only one rule to be returned
        for _rule in _rules:
            if ( (_rule["AppPath"] == self._rule["AppPath"] )and
                 (_rule["ExecAllowed"] == self._rule["ExecAllowed"] )and
                 (_rule["Enabled"] == self._rule["Enabled"] )and
                 (_rule["NwAction"] == self._rule["NwAction"] ) ):
                logging.info("Rules  matched.")
                return 0
        logging.error("Rules did not match")
        return 1

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
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
