#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16531
# TestcaseDescription: Verify an Application can be Allowed Network Access from a specific Port #.


import os
import sys
import logging
import time
import subprocess
import threading

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
    _client = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/TCPUDPClient"
    _tcpServer = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/TCPServer"
    _process= "TCPServer"
    _apttApp = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"   
    _apttDir = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt"
    def __init__(self):
        logging.info("TestcaseID : 16531")
        logging.info("Verify an Application can be Allowed Network Access from a specific Port #")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Define variables.
        _customRule=[]
 
        _specPort = dict()
        # Server to listen 'incoming' at '6000' port and at IP: 127.0.0.1
        _specPort = {"IP":"127.0.0.1","Port":"6000","Protocol":"1",
                            "Direction":"1","Action":"1"}

        _customRule.append(_specPort)

        self._serverRule = {"AppPath" : self._tcpServer, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"3",
                     "CustomRules":_customRule}

        _cmd =  self._tcpServer + " 127.0.0.1 6000"
        _p = subprocess.Popen(_cmd,shell=True, stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE)

        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        CommonAppProFns.resetAppProtToDefaults()
        return 0
    

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        if CommonAppProFns.addAppProtRule(self._serverRule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule for Any port.")
            return 1

        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        return 0

    def verify(self):
        try :
            _p = subprocess.call([self._client, "TCP", "127.0.0.1", "6000", "TCP Message"], stdout=subprocess.PIPE)

            _regex="Granted permission to " + self._tcpServer + " for  accepting a TCP connection from 127.0.0.1:6000"

            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
                logging.info("TCP connection accepted by server from 127.0.0.1:6000.")
            else:
                logging.error("TCP server denied the incoming connection.")
                return 1
        except :
            logging.error("Failed to launch application")
            return 1
 
        return 0
        

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()
        CommonAppProFns.disableApproTrace("reportMgrFlow")
        if commonFns.isProcessRunning(self._process) == True :
            try :
                logging.info("%s already running. Killing it" % self._process)
                subprocess.call(["killall", "-SIGTERM", self._process], stdout=subprocess.PIPE)
            except :
                logging.error("Failed to kill existing %s instance" % self._process)

        # Clean the logs
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
