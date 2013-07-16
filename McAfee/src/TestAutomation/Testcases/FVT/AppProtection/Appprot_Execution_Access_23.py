#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16471
# TestcaseDescription: "Test overinstalling of the application and adding AppPro rule"

import sys
import logging
import subprocess
import time
import os

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
        logging.info("TestcaseID : 16471")
        logging.info("Description : Test overinstalling of the application and adding AppPro rule") 

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        self.cocoaAppPath=os.path.dirname(os.path.abspath(sys.argv[0])) \
                           + "/data/SampleCocoaCarbonApps/Downloader.app"
        self.destPath = "/Applications/"
        self.destAppPath = "/Applications/Downloader.app"
        self.appName = "Downloader"
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        # Part of cleanUp    
        CommonAppProFns.resetAppProtToDefaults()
        
        logging.debug("Copy the app to /Applications/ directory")
        try:
            Cmd = "cp -Rf " + self.cocoaAppPath + " " + self.destPath
            retval = subprocess.call(Cmd, shell=True)
            if(retval != 0):
                loggin.error("Unable to copy to /Applications %s", self.cocoaAppPath)
                return 1
            time.sleep(5)
        except:
            logging.error("Exception occured in copying %s", self.cocoaAppPath)
            return 1
        # Set exclusion for appProtTestTool
        logging.debug("Exclude APTT ")
        CommonAppProFns.setAppProExclusions([os.path.dirname(\
                                        os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"])

        #Rule to allow execution
        self.rule = {
            'AppPath' : self.destAppPath,
            'ExecAllowed' : '1',
            'Enabled' : '1',
            'NwAction' : '1'
            }
         # Check if the app is already running   
        if commonFns.isProcessRunning(self.appName) != True :
            logging.debug("Application :%s is not running" %self.cocoaAppPath)
        else:    
            Cmd = "killall -9 " + self.appName
            retval = subprocess.call(Cmd, shell=True)
            if(retval != 0):
                logging.error("unable to kill %s application", self.appName)    
        return 0

    def execute(self):
        logging.debug("Executing testcase %s" % testcaseName)

        logging.debug("set unknown modified app to deny")
        if CommonAppProFns.setUnknownAppAction(2) == False :
            logging.error("Failed to set unknown app action to 'Deny'")
            return 1

        logging.debug("Add the rule to %s", self.destAppPath)
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule failed")
            return 1

        try:
            logging.debug("Copy the app again  to /Applications/ directory")
            cpCmd = "cp -Rf " + self.cocoaAppPath + " " + self.destPath
            retval = subprocess.call(cpCmd, shell=True)
            if(retval != 0):
                loggin.error("Unable to copy again  %s", self.cocoaAppPath)
                return 1
            time.sleep(5)
        except:
            logging.error("Exception occured in copying again %s", self.cocoaAppPath)
            return 1
           
        try:
            logging.debug("Try to launch the application")
            openCmd = "open " + self.destAppPath
            retval = subprocess.call(openCmd, shell=True)
            if(retval != 0):
                logging.debug("Unable to launch the app %s", destAppPath)
                return 1
            time.sleep(5)
        except:
            logging.error("Exception occured while launching the app %s", self.destAppPath)
            return 1
        return 0 

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        if commonFns.isProcessRunning(self.appName) == True :
            logging.debug("Application :%s is running" % self.destAppPath)
            return 0
        return 1

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy all the logs
        foundCrash = 0
        foundCrash = commonFns.copyLogs()

        Cmd = "killall -9 " + self.appName
        retval = subprocess.call(Cmd, shell=True)
        if(retval != 0):
            logging.error("unable to kill %s application", self.appName)   
            
        CommonAppProFns.resetAppProtToDefaults()
        try:
            shutil.rmtree(self.destAppPath)
            logging.debug("removed the app from /Applications as part of clean up")
        except:
            pass
        # Clean them.
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
