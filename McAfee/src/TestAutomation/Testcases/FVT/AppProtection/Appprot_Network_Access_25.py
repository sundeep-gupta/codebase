#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16548
# TestcaseDescription: Testcase to verify the report generation using rule hit.

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
    _httpClient = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/HttpRequest"
    _ftpClient = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/FTPRequest"
    _apttApp = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"   
    _apttDir = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt"

    def __init__(self):
        logging.info("TestcaseID : 16548")
        logging.info("Testcase to verify the report generation using rule hit")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Making rule to allow 'FTP' port for 'FTP Client'.
        _customRule = []
        _anyPort = dict()
        _anyPort = {"IP":"ANY_IP","Port":"FTP","Protocol":"3",
                            "Direction":"3","Action":"1"}
        _customRule.append(_anyPort)

        self._ftpClientRule = {"AppPath" : self._ftpClient, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"3",
                     "CustomRules":_customRule}

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
        if CommonAppProFns.addAppProtRule(self._ftpClientRule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule for ftp client.")
            return 1

        _retVal = subprocess.call([self._ftpClient], stdout=subprocess.PIPE)

        try :
            if _retVal == 0:
                logging.info("FTP connection succeeded.")
            elif _retVal == 7:
                logging.info("FTP (passive) failed - active passed")
            else:
                logging.error("FTP Connection failed.")
                return 1
        except:
            logging.error("Failed to launch http client")            
            return 1

        return 0

    def verify(self):
        time.sleep(5)
        # Checking event generated by Application Protection in Mcafee Security log.
        _regex = "AppProtection: PID: \d+ : Denied " + self._ftpClient + " from creating a TCP connection to 194.71.11.69:\d+"            

        if commonFns.parseFile("/var/log/McAfeeSecurity.log", _regex) == True:
            logging.info("log for the event found.")
        else:
            logging.error("log for event not found.")
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