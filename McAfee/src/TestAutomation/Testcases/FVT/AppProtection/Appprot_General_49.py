#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16521
# TestcaseDescription:  Verify the application rule is disabled by unchecking the checkbox against the added appln rule.

import sys
import logging
import os
import subprocess
import time

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
        logging.info("TestcaseID : 16521")
        logging.info("Description : Verify the application rule is disabled by unchecking the checkbox against the added appln rule.")

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
        self._app = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleCocoaCarbonApps/Downloader.app"
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
        
        # Step 1 : Disable the rule
        self._rule["Enabled"]="0"
        _retval = CommonAppProFns.modifyAppProtRule(self._rule)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Modification of rule failed with code %d" % _retval)
            return 1
        logging.info("Modified rule for %s " % self._app)
        
        # Step 2 : Launch the Downloader.app
        try:
            retval = subprocess.call( [ "open", self._app ],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
            if retval != 0:
                logging.error("Execution got denied even though rule is disabled")
                return 1
            
            logging.info("%s got launched as expected" % self._app)
        except:
            logging.error("Execution got denied even though rule is disabled")
            return 1
        time.sleep(3)
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # Step 0: Verify that app has come up
        self._processname=self._app +"/Contents/MacOS/Downloader"
        if commonFns.isProcessRunning(self._processname) == True: 
            logging.info("%s process is running"% self._processname)
            return 0
        logging.error("%s process is not running"%self._processname)
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Step 0 : kill the app
        subprocess.call(["killall", "-SIGTERM","Downloader"],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        # Step 1 : Reset App Pro
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
