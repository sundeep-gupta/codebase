#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16555
# TestcaseDescription: Testcase to verify a network rule to specific port by an application.


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
        logging.info("TestcaseID : 16555")
        logging.info("Testcase to verify a network rule to specific port by an application")

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

        _retVal = CommonAppProFns.setUnknownAppAction(3)
        if _retVal == False:
            logging.error("'prompt' action is not set.")
            return 1

        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        _retVal = subprocess.call([self._ftpClient], stdout=subprocess.PIPE)

        try :
            if _retVal == 0:
                logging.info("FTP connection succeeded.")
            elif _retVal == 7:
                logging.info("FTP (active) connection succeeded.")
            else:
                logging.error("FTP Connection failed.")
                return 1
        except:
            logging.error("Failed to launch http client")            
            return 1

        _retVal = subprocess.Popen(["/bin/sh", "-c", self._httpClient], stdout=subprocess.PIPE)

        time.sleep(1)

        _retVal = CommonAppProFns.alertAllowWithNetworkOnce()
        if _retVal == False:
            logging.error("Not getting 'prompt' for http client.")
            return 1
        else:
            logging.info("Got 'prompt' for http client..")

        return 0

    def verify(self):
        # Checking 'http client' log.
        _regex = "Prompted user to grant " + self._httpClient  + " permission for  executing"

        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
            logging.info("log for the 'prompt' of HTTP connection found.")
        else:
            logging.error("Didn't find log for the 'prompt' of HTTP connection.")
            return 1

        # Checking 'ftp client' log.
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
