#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16476
# TestcaseDescription:  Testcase to verify KEXT stop monitoring

import sys
import logging
import subprocess
import time
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
    def __init__(self):
        logging.info("TestcaseID : 16476")
        logging.info("Description : Testcase to verify KEXT stop monitoring")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        # Lets kill any pre existing safari instance
        subprocess.call( [ "killall",
                           "-SIGKILL",
                           "Safari" ])
        logging.debug("Killing any pre existing safari instances")
        # Lets restart App Pro to get rid of any cache etc
        subprocess.call ( ["/usr/local/McAfee/AppProtection/bin/AppProtControl",
                            "restart" ])
        logging.debug("Restarting App Protection in order to clear cache etc")
        time.sleep(5)
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Change kext logging to 5
        if subprocess.call( [ "sysctl", 
                              "-w",
                              "kern.com_mcafee_app_protection_log=5" ]) != 0:
            logging.error("Could not change kext log level to 5.")
            return 1
        logging.debug("Changed log level to 5")
        #Disable App Protection
        if CommonAppProFns.disableAppProt() != True:
            logging.error("Could not disable application protection")
            return 1
        logging.debug("Disabled App Protection ")
        # Launch Safari
        if subprocess.call ( [ "open" ,
                               "/Applications/Safari.app" ]) != 0:
            logging.error("Unable to launch Safari.app")
            return 1
        logging.debug("Launched safari");
        time.sleep(5)
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        #check for safari related messages in system .log or kernel.log
        if commonFns.searchSystemLog("Block: Path - /Applications/Safari.app") == True:
            logging.error("Log found in system.log, which means we are still hooking. bad.")
            return 1
        
        if commonFns.searchKernelLog("Block: Path - /Applications/Safari.app") == True:
            logging.error("Log found in kernel.log, which means we are still hooking. bad.")
            return 1
        logging.error("Log not found either in system.log or in kernel.log. This is good")
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Change kext logging to 1
        if subprocess.call( [ "sysctl", 
                              "-w",
                              "kern.com_mcafee_app_protection_log=1" ]) != 0:
            logging.error("Could not change kext log level to 1.")
        # Lets kill the safari
        subprocess.call( [ "killall",
                           "-SIGKILL",
                           "Safari" ])
        # Reset App pro
        CommonAppProFns.resetAppProtToDefaults()
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
