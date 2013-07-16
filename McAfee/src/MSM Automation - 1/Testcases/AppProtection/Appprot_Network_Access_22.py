#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16544
# TestcaseDescription: Testcase to check action for unknown network with prompt option.

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
    _apttApp = os.getcwd() + "/data/aptt/appProtTestTool"   
    _apttDir = os.getcwd() + "/data/aptt"

    def __init__(self):
        logging.info("TestcaseID : 16544")
        logging.info("Testcase to check action for unknown network with prompt option.")

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

        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        # Exclude APTT
        logging.debug("Exclude APTT")
        
        _exclusionList = [self._apttApp]
        _retVal = CommonAppProFns.setAppProExclusions(_exclusionList)

        if _retVal == False:
            logging.error("Not able to set exclusion for 'aptt'.")


        return 0
    

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        # Setting uknown/modified applications to 'prompt'.
        _retVal = CommonAppProFns.setUnknownAppAction(3);
        if _retVal == False:
            logging.error("'prompt' action is not set.") 
            return 1

        _cmd = self._client + " UDP 127.0.0.1 7000 \"UDP Message\""
        _p = subprocess.Popen(["/bin/sh", "-c", _cmd], stdout=subprocess.PIPE)

        time.sleep(1)
        _retVal = CommonAppProFns.alertAllowWithNetworkOnce()

        if _retVal == False:
            logging.error("Not getting 'prompt' for the application.")
            return 1
        else:
            logging.info("Successfully clicked on the alert to 'allow once with network' option.")
    
        return 0

    def verify(self):
        # Checking for the outgoing connection of TCPUDPClinet.

        _regex1 = "Prompted user to grant " + self._client + " permission for  executing because  user needs to be prompted for unknown applications"
        _regex2 = "Granted permission to " + self._client  + " for  creating a UDP connection to 127.0.0.1:7000"

        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex1) and commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex2) == True:
            logging.info("Expected logs found.")
        else:
            logging.error("Expected logs not found.")
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
