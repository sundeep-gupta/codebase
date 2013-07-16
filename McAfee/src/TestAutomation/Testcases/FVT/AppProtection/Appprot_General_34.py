#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16507
# TestcaseDescription:  Verify compatibility with Mac FW settings with AppProtection settings for applications

import sys
import logging
import os
import re
import subprocess

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")
sys.path.append(common_path + "/Firewall")

import commonFns
import CommonAppProFns
import CommonFWFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    _client = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/TCPUDPClient"
    _tcpServer = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/TCPServer"
    _process= "TCPServer"
    _apttDir = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt"
    _fwttDir = os.path.dirname(os.path.abspath(sys.argv[0])) + "/../Firewall/data/fwtt"

    def __init__(self):
        logging.info("TestcaseID : 16507")
        logging.info("Description : Verify compatibility with Mac FW settings with AppProtection settings for applications")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        
        self._serverRule = {"AppPath" : self._tcpServer, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"2"}
        
        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        CommonAppProFns.resetAppProtToDefaults()
        # Install FW test tool
        logging.debug("Installing firewall test tool")
        if commonFns.installTestTool("fwtt", self._fwttDir) != True :
            logging.error("Failed to install firewall test tool")
            return 1 

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        
        #Step 0 : Add APP Prot Rule
        if CommonAppProFns.addAppProtRule(self._serverRule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add app prot Rule.")
            return 1
        
        #Step 1: Enable App prot traces
        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        #Step 2:  Launch TCP server
        _cmd =  self._tcpServer + " 127.0.0.1 7000"
        _p = subprocess.Popen(_cmd,shell=True, stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE)
        # Step 3 : Set a block all rule in firewall
        CommonFWFns.addFWRuleWithoutPorts("myrule","2","1","1","any","any") 
        # Step 4 : Launch TCP Client and try to connect to server
        try :
            _p = subprocess.call([self._client, "TCP", "127.0.0.1", "7000", "TCP Message"], stdout=subprocess.PIPE,stderr=subprocess.PIPE)
            logging.debug("%s exceuted"%self._client)
            return 0
        except :
            logging.error("Failed to launch application")
            return 1

        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        _regex="Granted permission to " + self._tcpServer + " for  accepting a TCP connection from 127.0.0.1:7000"

        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
            logging.error("TCP connection accepted by server from 127.0.0.1:7000.")
            return 1
        else:
            logging.info("TCP server denied the incoming connection.")

        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        CommonFWFns.deleteFWRule("myrule")
        CommonAppProFns.resetAppProtToDefaults()
        CommonAppProFns.disableApproTrace("reportMgrFlow")
        if commonFns.isProcessRunning(self._process) == True :
            try :
                logging.info("%s already running. Killing it" % self._process)
                subprocess.call(["killall", "-SIGTERM", self._process], stdout=subprocess.PIPE)
            except :
                logging.error("Failed to kill existing %s instance" % self._process)
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
