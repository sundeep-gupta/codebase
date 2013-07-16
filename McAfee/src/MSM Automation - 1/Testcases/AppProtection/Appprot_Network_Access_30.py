#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16554
# TestcaseDescription: Testcase to verify a network rule to specific port by an application.

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
    _httpClient = os.getcwd() + "/data/SampleApplications/HttpRequest"
    _ftpClient = os.getcwd() + "/data/SampleApplications/FTPRequest"
    _apttApp = os.getcwd() + "/data/aptt/appProtTestTool"   
    _apttDir = os.getcwd() + "/data/aptt"

    def __init__(self):
        logging.info("TestcaseID : 16554")
        logging.info("Testcase to verify a network rule to specific port by an application")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Making rule to block 'HTTP' port for 'HTTP Client'.
        _customRule = []
        _anyPort = dict()
        _anyPort = {"IP":"ANY_IP","Port":"HTTP","Protocol":"3",
                            "Direction":"3","Action":"2"}
        _customRule.append(_anyPort)

        self._httpClientRule = {"AppPath" : self._httpClient, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"3",
                     "CustomRules":_customRule}

        _customRule2=[]
        _anyPort2 = dict()
        # Server to listen 'incoming' at 'any' port and at any IP.
        _anyPort2 = {"IP":"ANY_IP","Port":"ANY_PORT","Protocol":"3",
                            "Direction":"3","Action":"1"}

        _customRule2.append(_anyPort2)

        self._ftpClientRule = {"AppPath" : self._ftpClient, "Enabled" : "1",
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

        return 0
    

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Blocking All traffic for Client
        if CommonAppProFns.addAppProtRule(self._httpClientRule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule for http client.")
            return 1

        if CommonAppProFns.addAppProtRule(self._ftpClientRule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule for ftp client.")
            return 1

        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        _retVal = subprocess.call([self._httpClient], stdout=subprocess.PIPE)

        try :
            if _retVal == 0:
                logging.error("HTTP connection succeeded (unexpected).")
                return 1
            else:
                logging.info("HTTP Connection succeeded")
        except:
            logging.info("Failed to launch http client")            

        _retVal = subprocess.call([self._ftpClient], stdout=subprocess.PIPE)

        try:
            if _retVal == 0:
                logging.info("FTP connection succeeded.")
            else:
                logging.error("FTP connection denied.")
        except:
            logging.error("FTP client launch failed.") 
            return 1

        return 0

    def verify(self):
        # Checking for the outgoing connection of TCPUDPClinet.
        _regex = "Denied " + self._httpClient + " from creating a TCP connection to 174.143.137.108:80"

        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
            logging.info("log for the 'denial' of HTTP connection found.")
        else:
            logging.error("Didn't find log for the 'denial' of HTTP connection.")
            return 1

        _regex = "Granted permission to " + self._ftpClient + " for  creating a TCP connection to 194.71.11.69:21"            

        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
            logging.info("log for the FTP connection found.")
        else:
            logging.error("log for FTP connection not found.")
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
