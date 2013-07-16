#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 1910
# TestcaseDescription:  lsh-1910 : Install VSEL and verify dat updates work 

import sys
import logging
import time
import subprocess
# Add common folder into the sys path for module importing
import commonFns
sys.path.append("../Antimalware/")
import commonAntiMalwareFns
import commonOASFns

# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name

testcaseName = sys.argv[0][:-3]
class TestCase(BaseTest):

    def __init__(self):
        logging.info("TestcaseID : 1910")
        logging.info(" lsh-1910 : Install VSEL and verify dat updates work")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        self._datpath = self.getConfig('PAYLOAD_PATH') + '/dat/incremental'
        if not os.path.isdir(self._datpath) :
            logging.error("Payload for dat is not existing %s" % self._datpath)
            return 1
        # Old dat copying 
        if not commonAntiMalwareFns.replaceDat(self._datpath) :
            logging.error("Old dat copy failed")
            return 1
        logging.debug("Old dat copy successful.")
        self.datVersion = commonAntiMalwareFns.GetDatVersion()
        #Starting Manual Update
        if not commonAntiMalwareFns.runUpdate() :
            logging.error("Manual Update failed")
            return 1
        logging.info("Manual Update is successful.")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        self.latestdat = commonAntiMalwareFns.GetDatVersion()
        if self.latestdat < self.datVersion:
            logging.error("Update is Failed to get Latest dats")
            return 1
        logging.info("Updated with Latest dats")
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

    def _cleanup(self) :
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
    retVal = retVal + testObj.cleanup()

    if(retVal == 0):
        resultString = "PASS"
    else:
        resultString = "FAIL"

    logging.info("Result of testcase %s: %s" % (testcaseName, resultString) )
    sys.exit(retVal)
