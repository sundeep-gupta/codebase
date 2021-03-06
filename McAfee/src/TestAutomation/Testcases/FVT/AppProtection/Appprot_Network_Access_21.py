#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16543
# TestcaseDescription: Testcase to check action taken upon non-matching rule.

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
        logging.info("TestcaseID : 16543")
        logging.info("Testcase to check action taken upon non-matching rule.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Adding TCP protocol deny rule. We haven't added rule for 'UDP' protocol.
        _customRule=[]

        _tcpDny = dict()
        _tcpDny = {"IP":"ANY_IP","Port":"ANY_PORT","Protocol":"1",
                            "Direction":"3","Action":"2"}

        _customRule.append(_tcpDny)

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
            logging.error("Failed to add Rule for TCP Block.")
            return 1

        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        return 0

    def verify(self):
        try :
            # Launching client to send UDP data packets, it should not be allowed as per global rule which by default is deny.
            _p = subprocess.call([self._client, "UDP", "127.0.0.1", "5000", "UDP Message"], stdout=subprocess.PIPE)

            _regex="Denied " + self._client + " from creating a UDP connection to 127.0.0.1:5000"

            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
                logging.info("UDP connection not allowed (global rule take over).")
            else:
                logging.error("UDP connection allowed (global rule is not taking over.)")
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
