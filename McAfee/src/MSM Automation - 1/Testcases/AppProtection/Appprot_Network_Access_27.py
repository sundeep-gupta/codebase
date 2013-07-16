#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16550
# TestcaseDescription: Testcase of App Protection on a Network Application generating outgoing traffic.

import sys
import logging
import time
import subprocess
import threading
import urllib
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
    _apttApp = os.getcwd() + "/data/aptt/appProtTestTool"   
    _apttDir = os.getcwd() + "/data/aptt"

    def __init__(self):
        logging.info("TestcaseID : 16550")
        logging.info("Testcase of App Protection on a Network Application generating outgoing traffic.")

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

        # Exclude APTT
        logging.debug("Exclude APTT")

        _exclusionList = [self._apttApp]
        _retVal = CommonAppProFns.setAppProExclusions(_exclusionList)

        if _retVal == False:
            logging.error("Not able to set exclusion for 'aptt'.")

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        if CommonAppProFns.enableApproTrace("processHelperFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        try :
            _retVal = subprocess.call([self._client, "UDP", "127.0.0.1", "5000", "UDP Message"], stdout=subprocess.PIPE)
            if _retVal != 0:
                logging.error("Failed to launch Packet Injection Tool.")
                return 1
        except :
            logging.error("Failed to launch Packet Injection Tool.")
            return 1

        return 0

    def verify(self):
        _regex1 = "Granted permission to " + self._client + " for  creating a UDP connection to 127.0.0.1:5000"
        _regex2 = "\( " + self._client + " , \d+\) - Acquired Lock"

        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex1) == True:
            logging.info("Protocol, destination IP, destination Port of outgoing connection found in 'log'")
        else:
            logging.error("expected log not found.")
            return 1

        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex2) == True:
            logging.info("'pid' of source is found in 'log'")
        else:
            logging.error("expected log not found.")
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
        CommonAppProFns.disableApproTrace("processHelperFlow")
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
