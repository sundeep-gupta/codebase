#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16517
# TestcaseDescription:  Verify that irrespective of application name  binary name is reflected in application rule added

import sys
import logging
import os
import subprocess
import time

# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
import CommonAppProFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 16517")
        logging.info("Description : Verify that irrespective of application name  binary name is reflected in application rule added")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        # Step 0 : Install APTT
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Installation of AppPro Test Tool failed.")
            return 1
        
        # Step 1 : Reset App Pro
        CommonAppProFns.resetAppProtToDefaults()
        
        # Step 2 : kill the app
        subprocess.call(["killall", "-SIGTERM","Downloader"],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        self._app = os.getcwd() + "/data/SampleCocoaCarbonApps/Downloader.app"
        # Step 0 : Add rule for Downloader.app
        self._rule = dict()
        self._rule["AppPath"]= self._app
        self._rule["ExecAllowed"]="0"
        self._rule["Enabled"]="1"
        self._rule["NwAction"]="1"
        _retval = CommonAppProFns.addAppProtRule(self._rule)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule failed with code %d" % _retval)
            return 1
        logging.info("Added rule for %s " % self._app)
        
        # Step 1 : Launch the Downloader.app
        try:
            # Dont bother about return code. "open" always returns 0
            subprocess.call( [ "open", self._app ],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        except:
            pass
        
        return 0


    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        self._processname=self._app +"/Contents/MacOS/Downloader"
        if commonFns.searchProductLog(self._processname) == True:
            logging.info("Binary name %s found in product log"%self._processname)
            return 0
        logging.error("Binary name %s not found in product log"%self._processname)
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Step 0 : Reset App Pro
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
