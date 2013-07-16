#!/usr/bin/python

# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16473
# TestcaseDescription: Testcase to verify the preferences are in binary format

import sys
import logging
import subprocess
import re
import os.path

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")

# Import CommonTest module into current namespace
from CommonTest import *
import commonFns

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 16473")
        logging.info("Description : Testcase to verify the preferences are in binary format")
        pass

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        _retval = BaseTest.init(self)
        if _retval != 0:
            return 1
        
        self.path = "/Library/Preferences/com.mcafee.ssm.appprotection.plist"
        logging.debug("Path of plist file is %s" % self.path)
        return 0

    def execute(self):
        """Executes the test and returns 0 for pass and 1 for fail"""
        logging.info("Executing testcase %s" % testcaseName)

        # If file does not exist or is not a file, we return fail
        if (not os.path.isfile(self.path)) :
            logging.error("%s is not a file" % self.path)
            return 1

        if (self._istext()):
            logging.error("%s is a text file " % self.path)
            return 1

        logging.debug("%s is NOT a text file " % self.path)
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        commonFns.cleanLogs()

        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")

        return foundCrash

    def __del__(self):
        self.path = None
        pass

    def _istext(self):
        logging.debug("Running 'file' command on %s" % self.path)
        return (re.search(r':.* text',
            subprocess.Popen(["file", '-L', self.path],
                stdout=subprocess.PIPE).stdout.read()) is not None)


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
