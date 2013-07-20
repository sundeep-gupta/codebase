#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: testAppProtectionUTDemo
# TestcaseDescription: Demo UT for AppProtection

import sys
import logging
import os
import re
import subprocess

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")

import commonFns
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):

    # test binary name...
    _testBinaryFilePath = "enter unit test binary path"    

    def __init__(self):
        logging.info("TestcaseID : testAppProtectionUTDemo")
        logging.info("Demo UT for AppProtection")

    def init(self, testZipPath):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retVal = BaseTest.init(self)
        if _retVal != 0 :
            return _retVal

        _retVal = commonFns.setupUT(testZipPath)

        if _retVal != 0 :
            logging.error("Setup UT failed...")
            return _retVal

        # After zip file extraction, check for testAppProtectionUTDemo binary...
        #if os.path.exists(self._testBinaryFilePath):
        #    logging.info("test binary found locally for execution")
        #else:
        #    logging.error("test binary not found locally for execution")
        #    return 1

        return 0
    

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        # Now, run the test binary...
        #_process = subprocess.Popen(self._testBinaryFilePath, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        #_retVal = _process.communicate()

        #logging.info(_retVal[0])
        #logging.info(_retVal[1])

        # Check whether test binary passed...
        #_m = re.search("Ran [0-9]* tests, [0-9]* failed", _retVal[1])

        # Mark the testcase as success only when specific pattern occurs...
        #if _m is not None:
        #    _startIdx = _m.group(0).find(", ")
        #    _endIdx = _m.group(0).find(" failed")
        #    _retVal = int(_m.group(0)[_startIdx+2 : _endIdx])
        #    
        #    if _retVal == 0:
        #        # Pattern found and so return success...
        #        return 0
            
        #return 1

        return 0

    def verify(self):

        return 0       

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()

        # Cleanup the UT setup...
        commonFns.cleanupUT()
        
        # Clean the logs
        commonFns.cleanLogs()

        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")

        return foundCrash

    def __del__(self):
        pass

if __name__ == "__main__":

    if len(sys.argv) == 2 and sys.argv[1] not in ['debug', 'error', 'trace', 'info'] :
        tmp = sys.argv[1]
	sys.argv[1] = 'info'
	sys.argv.append(tmp)

    # Setup testcase
    setupTestcase(sys.argv)

    testObj = TestCase()

    # Perform testcase operations
    if len(sys.argv) == 3:
        retVal = testObj.init(sys.argv[2])
    else:
        logging.error("Invalid argument count")
        retVal = 1 

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