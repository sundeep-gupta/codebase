#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16529
# TestcaseDescription: Verify an Application can be Allowed Network Access to a specific Port #

import sys
import logging
import time
import subprocess
import threading
# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
import CommonAppProFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    _client = os.getcwd() + "/data/SampleApplications/TCPUDPClient"
    _tcpServer = os.getcwd() + "/data/SampleApplications/TCPServer"
    _process= "TCPServer"
    _apttApp = os.getcwd() + "/data/aptt/appProtTestTool"   
    _apttDir = os.getcwd() + "/data/aptt"
    def __init__(self):
        logging.info("TestcaseID : 16529")
        logging.info("Verify an Application can be Allowed Network Access to a specific Port #")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Define variables.
        _customRule=[]
 
        _specPort = dict()
        _specPort = {"IP":"127.0.0.1","Port":"5000","Protocol":"1",
                            "Direction":"2","Action":"1"}

        _customRule.append(_specPort)

        self._clientRule = {"AppPath" : self._client, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"3",
                     "CustomRules":_customRule}

        _cmd =  self._tcpServer + " 127.0.0.1 5000"
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
        if CommonAppProFns.addAppProtRule(self._clientRule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule for specific port.")
            return 1

        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        return 0

    def verify(self):
        try :
            _p = subprocess.call([self._client, "TCP", "127.0.0.1", "5000", "TCP Message"], stdout=subprocess.PIPE)

            _regex="Granted permission to " + self._client + " for  creating a TCP connection to 127.0.0.1:5000"

            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
                logging.info("TCP connection to server established at port 5000 on server 127.0.0.1.")
            else:
                logging.error("TCP connection to server denied.")
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
