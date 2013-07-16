#!/usr/bin/python

# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16459
# TestcaseDescription: Enable prompt options and try to install few applications.  

import sys
import logging
import threading
import time
import subprocess
import os.path
# Add common folder into the sys path for module importing
sys.path.append("../Common")

# Import CommonTest module into current namespace
from CommonTest import *
import commonFns
import CommonAppProFns
# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 16459")
        logging.info("Description : Enable prompt options and try to install few applications.") 

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the base initialization
        _retval = BaseTest.init(self)
        if _retval != 0:
            return 1
        self.appPath = os.path.dirname(os.path.abspath(sys.argv[0]))\
                        + "/data/SampleCocoaCarbonApps/80mac_eval_en.app"
        self.cmd = "open" + " " + self.appPath
        self.appName = "Meeting Maker Evaluation"
        self.sleep_time=10
        self.m_launch_app = TestCase._launch_app
        
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        CommonAppProFns.resetAppProtToDefaults()

        # Exclude APTT
        exclusionList = [os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool" ]
        retval = CommonAppProFns.setAppProExclusions(exclusionList)
        if retval == False:
            logging.error("Failed to add the app to exclusions")
            return 1
        return 0

    def execute(self):
        """Executes the test and returns 0 for pass and 1 for fail"""
        logging.info("Executing testcase %s" % testcaseName)
        
        logging.debug("Setting unknown app action to 'Prompt'")
        if CommonAppProFns.setUnknownAppAction(3) == False :
            logging.error("Failed to set unknown app action to 'Prompt'")
            return 1
        try :
            logging.debug("launching %s in new thread" % self.appPath)
            self.thread_return = None
            _thread = threading.Thread(target=self.m_launch_app,args=[self] )
            _thread.start()
        except :
            logging.error("Failed to start the thread")
            return 1
        
        time.sleep(self.sleep_time)   
        # deny the execution of the app
        retval = CommonAppProFns.alertDenyOnce()
        if(retval == True):
            logging.debug("Prompt appeared and Deny was chosen")
        else:
            logging.error("Error in selecting option")
            return 1
        # Wait for thread to join
        logging.debug("Waiting for thread to join")
        _thread.join()
        logging.debug("Thread joined")
        return self.thread_return

    def _launch_app(self):
        """Callback function which launches application.
            Called by Thread.run
        """
        logging.debug("Launching application %s" % self.appPath)
        try :
            retval = subprocess.call(self.cmd, shell=True)
            if retval != None :
                logging.error("Application launched")
                self.thread_return = 1
        except :
            logging.debug("Failed to launch application")
            self.thread_return = 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        regex = "Denied " + self.appPath +"/Contents/MacOS/80mac_eval_en" + " from executing because  unknown applications are blocked as per the settings"
        if commonFns.searchProductLog(regex) != True:
            logging.error("Failed to find the regular expression in log")
            return 1
        logging.debug("Application denied of executing")
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
