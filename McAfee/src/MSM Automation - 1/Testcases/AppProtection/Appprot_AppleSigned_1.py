#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16393
# TestcaseDescription:  Testcase to check the default allow for Apple Signed Application  (Leopard & Snow Leopard ONLY)

import sys
import logging
import subprocess
import time
# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 16393")
        logging.info("Description : Testcase to check the default allow for Apple Signed Application  (Leopard & Snow Leopard ONLY)")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Enable Kext Logging
        logging.debug("Setting kext logging for application protection to 3")
        try :
            _retval = subprocess.call(["sysctl", "-w", "kern.com_mcafee_app_protection_log=3" ]\
                    , stdout=subprocess.PIPE)
            if _retval != 0 :
                logging.error("Failed to set kext logging")
                return 1
        except :
            logging.error("Failed to run sysctl command")
            return 1
        
        # /bin/ls is apple-signed binary.
        self.app_path = "/bin/ls"
        self.regex = "Bypassing /usr/lib/dyld as it is the loader"
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Launch the application which is apple signed.
        try :
            logging.debug("Launching the application %s " % self.app_path)
            _retval = subprocess.call([self.app_path], stdout=subprocess.PIPE)
            if _retval != 0 :
                logging.error("Application launch failed with exit code : %d " % _retval)
                return 1
            # Need some delay for kernel.log to get message.
            time.sleep(5)
        except :
            logging.error("Launching of application failed")
            return 1
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # Check the Kernel Log.
        logging.debug("Checking kernel log")
        if commonFns.searchAllLogs(self.regex) != True :
            logging.error("Message not found in kernel log")
            return 1
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Disable Kext Logging
        logging.debug("Setting kext logging for application protection to 1")
        try :
            _retval = subprocess.call(["sysctl", "-w", "kern.com_mcafee_app_protection_log=1" ]\
                    , stdout=subprocess.PIPE)
            if _retval != 0 :
                logging.error("Failed to set kext logging")
                return 1
        except :
            logging.error("Failed to run sysctl command")
            return 1
        # Clean up the logs
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
