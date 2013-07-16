#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16538
# TestcaseDescription: Testcase to block all traffic.

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
        logging.info("TestcaseID : 16538")
        logging.info("Testcase to block all traffic")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        _customRule = []
        _anyPort = dict()
        _anyPort = {"IP":"ANY_IP","Port":"ANY_PORT","Protocol":"3",
                            "Direction":"3","Action":"2"}
        _customRule.append(_anyPort)

        self._clientRule = {"AppPath" : self._client, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"3",
                     "CustomRules":_customRule}

        _customRule2=[]
        _anyPort2 = dict()
        # Server to listen 'incoming' at 'any' port and at any IP.
        _anyPort2 = {"IP":"ANY_IP","Port":"ANY_PORT","Protocol":"3",
                            "Direction":"3","Action":"2"}

        _customRule2.append(_anyPort2)

        self._serverRule = {"AppPath" : self._tcpServer, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"3",
                     "CustomRules":_customRule2}

        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        CommonAppProFns.resetAppProtToDefaults()

        # Exclude APTT
        logging.debug("Exclude APTT")
        CommonAppProFns.setAppProExclusions([self._apttApp])

        _cmd =  self._tcpServer + " 127.0.0.1 7000"
        _p = subprocess.Popen(_cmd,shell=True, stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE)

        return 0
    

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Blocking All traffic for Client
        if CommonAppProFns.addAppProtRule(self._clientRule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule for client.")
            return 1

        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        return 0

    def verify(self):
        # Checking for the outgoing connection of TCPUDPClinet.
        try :
            _p = subprocess.call([self._client, "TCP", "127.0.0.1", "7000", "TCP Message"], stdout=subprocess.PIPE)

            _regex="Denied " + self._client + " from creating a TCP connection to 127.0.0.1:7000"

            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
                logging.info("TCP connection to server denied (as expected)")
            else:
                logging.error("TCP connection to server established (unexpected).")
                return 1
        except :
            logging.info("Failed to launch application (possible)")

        try :
            _p = subprocess.call([self._client, "UDP", "127.0.0.1", "7000", "UDP Message"], stdout=subprocess.PIPE)

            _regex="Denied " + self._client + " from creating a UDP connection to 127.0.0.1:7000"

            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
                logging.info("UDP connection to server denied (as expected)")
            else:
                logging.error("UDP connection to server established (unexpected).")
                return 1
        except :
            logging.info("Failed to launch application (possible)")

        # Deleting clinet rule to send data to server to test 'incoming for server'.
        if CommonAppProFns.deleteAppProtRule(self._clientRule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to delete client rule.")
            return 1

        # Blocking 'all traffic' for server.
        if CommonAppProFns.addAppProtRule(self._serverRule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule for server.")
            return 1

        try :
            _p = subprocess.call([self._client, "TCP", "127.0.0.1", "7000", "TCP Message"], stdout=subprocess.PIPE)

            _regex="Denied " + _self.tcpServer+ " from accepting a TCP connection from 127.0.0.1:7000"

            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
                logging.info("TCP connection denied by server from 127.0.0.1:7000.")
            else:
                logging.error("TCP accepted the incoming connection (unexpted).")
                return 1
        except :
            logging.info("Failed to launch application")

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
