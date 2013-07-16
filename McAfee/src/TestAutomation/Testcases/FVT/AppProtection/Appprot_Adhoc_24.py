#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 17447
# TestcaseDescription:  Test App Pro Network blocking behaviour when Unknown application is set to prompt for 10 sec

import sys
import logging
import os
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
        logging.info("TestcaseID : 17447")
        logging.info("Description : Test App Pro Network blocking behaviour when Unknown application is set to prompt for 10 sec")
        self._binaryPath=os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/TCPUDPClient"
        self._rule = dict()
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
        CommonAppProFns.resetAppProtToDefaults()
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        
        # Set exclusion for aptt
        if CommonAppProFns.setAppProExclusions( [ os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt" ]) != True:
            logging.error("Unable to add aptt exclusion")
            return 1
        logging.debug("Added exclusion for aptt")
       
        # Set unknown app action to prompt
        if CommonAppProFns.setUnknownAppAction(3) != True:
            logging.error("Unable to set unknown apps to prompt. Can't proceed")
            return 1
        logging.debug("set unknown app action to prompt")
        
        # Lets Add a rule for UDPClient binary
        self._rule["AppPath"]= self._binaryPath
        self._rule["ExecAllowed"]="0"
        self._rule["Enabled"]="0"
        self._rule["NwAction"]="1"
        if CommonAppProFns.addAppProtRule(self._rule) != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule failed")
            return 1
        logging.debug("Added rule for UDPClient")
        
        _cmd =  self._binaryPath + " UDP 172.16.193.1 500 Message"
        process=subprocess.Popen(_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        # Lets click on allow with n/w always
        CommonAppProFns.alertAllowWithNetworkAlways("taf","test")
        
        _retval=process.communicate()
        if process.returncode != 0:
            logging.error("The process did not execute properly return ")
            return 1
        logging.info("Everything went as per plan")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # lets retrieve the rule and check if things are as we expect them.
        _updated_rule = CommonAppProFns.getAppProtRules()
        # Since we added only one rule we expect only one rule back

        if _updated_rule[0]["AppPath"] != self._binaryPath or \
           _updated_rule[0]["ExecAllowed"] != "1" or \
           _updated_rule[0]["Enabled"] != "1" or \
           _updated_rule[0]["NwAction"] != "1":
            logging.error("Rule set in  backed seems to be different.")
            return 1

        logging.info("Rule from backed meets expectations")
        return 0

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
