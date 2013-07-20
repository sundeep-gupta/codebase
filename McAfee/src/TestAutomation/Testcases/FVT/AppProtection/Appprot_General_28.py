#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16500
# TestcaseDescription:  Verify that rule addition removal takes place as expected when applications which has some binaries

import sys
import logging
import os
import subprocess
import time
import shutil

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
        logging.info("TestcaseID : 16500")
        logging.info("Description : Verify that rule addition removal takes place as expected when applications which has some binaries")

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
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        
        #Step 0 : Create a copy of our demo app
        self._originalApp=os.path.dirname(os.path.abspath(sys.argv[0]))+ "/data/SampleCocoaCarbonApps/Downloader.app"
        self._app=os.path.dirname(os.path.abspath(sys.argv[0]))+ "/data/SampleCocoaCarbonApps/Downloader_copy.app"
        
        try:
            shutil.copytree(self._originalApp,self._app)
            logging.info("Copied %s to %s" %(self._originalApp,self._app))
        except:
            logging.error("Unable to create a copy of the app")
            return 1
        # Step 1 : Copy the executable in the app with another name in the same app
        self._processname=self._app +"/Contents/MacOS/Downloader"
        self._processnamecopy=self._app +"/Contents/MacOS/Downloadercopy"

        try:
            shutil.copyfile(self._processname,self._processnamecopy)
            logging.info("Copied %s to %s" %(self._processname,self._processnamecopy))
        except:
            logging.error("Unable to create a copy of the binary")
            return 1
        
        # Step 2 : Add rule for Downloader.app
        self._rule = dict()
        self._rule["AppPath"]= self._app
        self._rule["ExecAllowed"]="0"
        self._rule["Enabled"]="1"
        self._rule["NwAction"]="1"
        _retval = CommonAppProFns.addAppProtRule(self._rule)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule failed with code %d" % _retval)
            return 1
        logging.info("Addition of rule succeeded")

        # Step 3 : Remove the rule
        _retval = CommonAppProFns.deleteAppProtRule(self._rule)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Removal of rule failed with code %d" % _retval)
            return 1
        logging.info("Removal of rule succeeded")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Step 0 : Reset App Pro
        CommonAppProFns.resetAppProtToDefaults()
        # Step 1 : Delete the copy
        try:
            shutil.rmtree(self._app)
        except:
            pass
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