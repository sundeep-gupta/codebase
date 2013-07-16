#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16486
# TestcaseDescription:  Testcase to verify the re-registeration with FMP

import sys
import logging
import subprocess
import time
import os

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")

import commonFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 16486")
        logging.info("Description : Testcase to verify the re-registeration with FMP")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Step 0 Truncate FMP Trace file
        try:
            _fd=os.open("/usr/local/McAfee/fmp/var/fmpdtraces.log",os.O_TRUNC)
            os.close(_fd)
        except:
            logging.error("os error")
            return 1
        # Step 1 Set the regFlow trace to level 5 in fmp trace value file
        commonFns.setXMLValueinFile("/usr/local/McAfee/fmp/config/traceValues.xml",
                                    "regFlow",
                                    5)
        # Step 2 Kill fmp.
        subprocess.call(["killall","-SIGKILL","fmpd"],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        time.sleep(20)
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # Step 0 Look for the registration request in FMP trace file
        if commonFns.parseFile("/usr/local/McAfee/fmp/var/fmpdtraces.log","Registration request from FMID 3") != True:
            logging.error("Registration message not found in trace log")
            return 1
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Step 0 Set the trace value back.
        commonFns.setXMLValueinFile("/usr/local/McAfee/fmp/config/traceValues.xml",
                                    "regFlow",
                                    0)
        # Step 1 reload FMP
        subprocess.call(["/usr/local/McAfee/fmp/bin/fmp","reload"],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
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
