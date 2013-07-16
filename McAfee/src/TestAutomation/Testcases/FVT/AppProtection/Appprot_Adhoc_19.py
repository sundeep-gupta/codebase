#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 17442
# TestcaseDescription:  AppPro behaviour test when contents of an application added to appPro rule, gets changed

import sys
import logging
import shutil
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
    # Files which we will use as our test aps
    _app_1=os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleCocoaCarbonApps/Downloader.app"
    _app_2=os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleCocoaCarbonApps/CarbonDownloader.app"
    # Copies of Files which we will use as our test aps
    _app_1_copy=_app_1[:-4] + "_copy" + ".app"
    _app_2_copy=_app_2[:-4] + "_copy"  + ".app"

    def __init__(self):
        logging.info("TestcaseID : 17442")
        logging.info("Description : AppPro behaviour test when contents of an application added to appPro rule, gets changed")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        CommonAppProFns.resetAppProtToDefaults()

        try:
            shutil.copytree(self._app_1,self._app_1_copy)
            shutil.copytree(self._app_2,self._app_2_copy)
        except:
            logging.error("Unable to copy the aps")
            return 1

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Set exclusion for aptt
        if CommonAppProFns.setAppProExclusions( [ os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt" ]) != True:
            logging.error("Unable to add aptt exclusion")
            return 1
        logging.debug("Added exclusion for aptt")
    
        # Set unknown app action to block
        if CommonAppProFns.setUnknownAppAction(2) != True:
            logging.error("Unable to set unknown apps to block. Can't proceed")
            return 1
        logging.debug("set unknown app action to deny")

        # Lets Add a rule for first app
        _rule1 = dict()
        _rule1["AppPath"]= self._app_1_copy
        _rule1["ExecAllowed"]="1"
        _rule1["Enabled"]="1"
        _rule1["NwAction"]="1"
        if CommonAppProFns.addAppProtRule(_rule1) != CommonAppProFns.SUCCESS:
            logging.error("Addition of allow rule failed")
            return 1
        
        logging.debug("Added rule for app one")
        
        # Lets Add a rule for second app
        _rule2 = dict()
        _rule2["AppPath"]= self._app_2_copy
        _rule2["ExecAllowed"]="0"
        _rule2["Enabled"]="1"
        _rule2["NwAction"]="1"
        if CommonAppProFns.addAppProtRule(_rule2) != CommonAppProFns.SUCCESS:
            logging.error("Addition of deny rule failed")
            return 1
        logging.debug("Added rule for app two")

        # Mv second app to first 
        try:
            logging.debug("Removing " + self._app_1_copy + "/Contents/MacOS/Downloader")
            os.remove(self._app_1_copy + "/Contents/MacOS/Downloader")
            logging.debug("removal of " + self._app_1_copy + "/Contents/MacOS/Downloader succeeded")
            shutil.copy(self._app_2_copy + "/Contents/MacOS/CarbonDownloader", self._app_1_copy + "/Contents/MacOS/Downloader")
            # Lets create a softlink for UDPClient
            retval = subprocess.call( [ "ln",
                                    "-sf",
                                    self._app_2_copy + "/Contents/MacOS/CarbonDownloader",
                                    self._app_1_copy + "/Contents/MacOS/Downloader" ])
            logging.debug("linking " + self._app_2_copy + "'s binary  to " + self._app_1_copy + "'s binary succeeded")
        except:
            logging.error("linking " + self._app_2_copy + "'s binary  to " + self._app_1_copy + "'s binary failed")
            return 1

        time.sleep(5)
        try:
            retval = subprocess.call( [ "open" ,
                                        self._app_1_copy ])
        except:
            logging.info("Invocation of app failed as expected")         
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        time.sleep(10)
        if commonFns.searchProductLog("Denied " +
                                      self._app_2_copy + "/Contents/MacOS/CarbonDownloader"
                                      " from executing because  of profile rule match with") != True:
            logging.error("Expected error message not found in the product log")
            return 1
        logging.info("Expected error message found in the logs")
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        CommonAppProFns.resetAppProtToDefaults()
        try:   
            shutil.rmtree(self._app_1_copy)
            shutil.rmtree(self._app_2_copy)
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
