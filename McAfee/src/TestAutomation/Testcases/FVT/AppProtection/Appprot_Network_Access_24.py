#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16547
# TestcaseDescription: Testcase to verify the support for service names.

import sys
import logging
import time
import subprocess
import threading
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
    _httpClient = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/HttpRequest"
    _ftpClient = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/FTPRequest"
    _apttApp = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"   
    _apttDir = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt"

    def __init__(self):
        logging.info("TestcaseID : 16547")
        logging.info("Testcase to verify the support for service names.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        _customRule = []
        _httpAllow = dict()
        # Using 'HTTP' port for 'HttpRequest' application for testing HTTP services.
        _httpAllow = {"IP":"ANY_IP","Port":"HTTP","Protocol":"3",
                            "Direction":"3","Action":"1"}
        _customRule.append(_httpAllow)
        self._httpClientRule = {"AppPath" : self._httpClient, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"3",
                     "CustomRules":_customRule}

        # Using 'FTP' port for 'FTPRequest' application for testing FTP services.
        _customRule1 = []
        _ftpAllow = dict()
        _ftpAllow = {"IP":"ANY_IP","Port":"FTP","Protocol":"3",
                            "Direction":"3","Action":"1"}
        _customRule1.append(_ftpAllow)

        self._ftpClientRule = {"AppPath" : self._ftpClient, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"3",
                     "CustomRules":_customRule1}

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
        if CommonAppProFns.addAppProtRule(self._httpClientRule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule for HTTP service.")
            return 1

        if CommonAppProFns.addAppProtRule(self._ftpClientRule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule for FTP service.")
            return 1

        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        _retVal = subprocess.call([self._httpClient], stdout=subprocess.PIPE)

        try :
            if _retVal == 0:
                logging.info("HTTP service started.")
            else:
                logging.error("HTTP service failed to start.")
                return 1
        except:
            logging.error("HTTP client fail to launch.")
            return 1

        _retVal = subprocess.call([self._ftpClient], stdout=subprocess.PIPE)

        try:
            if _retVal == 0:
                logging.info("FTP service started.")
            elif _retVal == 7:
                logging.info("FTP (ACTIVE) service started.")
            else:
                logging.error("FTP service failed to start.")
            
        except:
            logging.error("FTP client launch failed.")
            return 1

        return 0

    def verify(self):
        # Checking for the outgoing connection of TCPUDPClinet.
        _regex = "Granted permission to " + self._httpClient + " for  creating a TCP connection to 174.143.137.108:80"

        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
            logging.info("log for the HTTP service found.")
        else:
            logging.error("log for HTTP service not found.")
            return 1

        _regex = "Granted permission to " + self._ftpClient + " for  creating a TCP connection to 194.71.11.69:21"

        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
            logging.info("log for the FTP service found.")
        else:
            logging.error("log for FTP service not found.")
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
