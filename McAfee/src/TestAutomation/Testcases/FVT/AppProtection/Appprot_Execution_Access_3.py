#!/usr/bin/python

# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16438
# TestcaseDescription: Testcase to check the last launch results - Targeted for Unknown modified Whitelisted application 

import sys
import logging
import time
import subprocess
import os.path

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")

# Import CommonTest module into current namespace
from CommonTest import *
import commonFns
import CommonAppProFns
# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 16438")
        logging.info("Description : Testcase to check the last launch results - Targeted for Unknown modified Whitelisted application") 

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the base initialization
        _retval = BaseTest.init(self)
        if _retval != 0:
            return 1
        self.ppcAppPath = os.path.dirname(os.path.abspath(sys.argv[0])) \
                                   + "/data/SampleCocoaCarbonApps/PPCDownloader.app"
        
        self.pathToSourceBinary = os.path.dirname(os.path.abspath(sys.argv[0])) \
                                   + "/data/SampleCocoaCarbonApps/Downloader.app/Contents/MacOS/Downloader"

        self.pathToModifyBinary = os.path.dirname(os.path.abspath(sys.argv[0])) \
                                   + "/data/SampleCocoaCarbonApps/PPCDownloader.app/Contents/MacOS/"
        self.appName = "Downloader"
        self.sleep_time=12
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1

        CommonAppProFns.resetAppProtToDefaults()
        if commonFns.isProcessRunning(self.appName) != True :
            logging.error("Application :%s is not running", self.appName)
        else:
            Cmd = "killall -9 " + self.appName
            retval = subprocess.call(Cmd, shell=True)
            if(retval != 0):
                logging.error("unable to kill %s application", self.appName)

        # Exclude APTT
        exclusionList = [ os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool", self.ppcAppPath ]
        retval = CommonAppProFns.setAppProExclusions(exclusionList)
        if retval == False:
            logging.error("Failed to add the app to exclusions")
            return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        logging.debug("Setting unknown app action to 'Prompt'")
        if CommonAppProFns.setUnknownAppAction(3) == False :
            logging.error("Failed to set unknown app action to 'Prompt'")
            return 1

        logging.debug("Modify the application")
        Cmd = "cp -Rf " + self.pathToSourceBinary + " " + self.pathToModifyBinary
        try :
            _retval=subprocess.call(Cmd, shell=True)
            if _retval != 0:
                logging.info("Failed to Modify Application")
                return 1
        except :
            # Check the McAfeeSecurity Log for Deny Message.
            logging.error("Failed to Modify application")
            return 1
        # Launch the app after Modification
        try:
            Cmd = "open " + self.ppcAppPath
            retval = subprocess.call(Cmd, shell=True)
            if(retval != 0):
                loggin.error("Unable to launch the %s", self.ppcAppPath)
                return 1    
        except:
            logging.error("Exception occured in launching %s", self.ppcAppPath)
            return 1
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # even after the app got modified, it should launch 
        if commonFns.isProcessRunning(self.appName) != True :
            logging.error("Error application :%s not running" % self.ppcAppPath)
            return 1
        return 0    

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        logging.debug("Copying logs")
        foundCrash = 0
        foundCrash = commonFns.copyLogs()

        # part of our clean Up
        CommonAppProFns.resetAppProtToDefaults()

        if commonFns.isProcessRunning(self.appName) != True :
            logging.error("Application :%s is not running", self.appName)
        else:
            Cmd = "killall -9 " + self.appName
            retval = subprocess.call(Cmd, shell=True)
            if(retval != 0):
                logging.error("unable to kill %s application", self.appName)

        logging.debug("Cleaning the logs")
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
        testObj.execute()

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
