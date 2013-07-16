#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 1884
# TestcaseDescription: Start/Stop/Restart of VSEL Daemon

import sys
import logging
import time
import subprocess
# Add common folder into the sys path for module importing
sys.path.append("../Antimalware")
import commonFns
import commonAntiMalwareFns
import commonOASFns

# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name

testcaseName = sys.argv[0][:-3]
class TestCase(BaseTest):

    def __init__(self):
        logging.info("TestcaseID : 1884")
        logging.info(" Start/Stop/Restart of VSEL Daemon")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        #Stooping the nails service
        if not commonAntiMalwareFns.nailsStop() :
            logging.error("Unable to stop nails service")
            return 1
        logging.info("nails service stopped successfully.")

        #Starting the nails service
        if not commonAntiMalwareFns.nailsStart() :
            logging.error("Unable to start nails service")
            return 1
        logging.info("nails service started successfully.")
        
        #Reloading the nails service
        if not commonAntiMalwareFns.nailsReload():
            logging.error("Unable to reload nails service")
            return 1
        logging.info("nails service reloaded successfully.")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        foundCrash = foundCrash + self._cleanup()
        commonFns.cleanLogs()

        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")
        return foundCrash

    def _cleanup(self):
        _retval = 0
        if not commonAntiMalwareFns.resetToDefaults() :
            logging.error("Failed to reset to defaults")
            _retval = 1
        return _retval

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
