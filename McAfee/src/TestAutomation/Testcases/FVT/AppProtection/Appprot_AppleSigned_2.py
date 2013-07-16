#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16394
# TestcaseDescription: Uncheck "allow apple signed binaries option" in leopard , every apple should prompt when opened.

import sys
import logging
import time
import subprocess
import threading
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
        logging.info("TestcaseID : 16394")
        logging.info("Description : Uncheck \"allow apple signed binaries option\" in leopard , every apple should prompt when opened.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Define variables.
        self.process = 'iTunes'
        self.app_path = "/Applications/iTunes.app/Contents/MacOS/iTunes"
        self.sleep_time = 5
        self.m_launch_app = TestCase._launch_app
        
        # Install AppProt test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1

        # Perform testcase specific cleanup before starting execution
        self._cleanup()

        # Exclude APTT
        logging.debug("Exclude APTT")
        CommonAppProFns.setAppProExclusions([os.path.dirname(\
                os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"])
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Disable apple signed binaries
        logging.debug("unchecking allow applesigned binaries")
        if CommonAppProFns.allowAppleSignedBinaries(False) == False :
            logging.error("Failed to uncheck allow applesigned binaries")
            return 1

        # Set unknown app to prompt
        logging.debug("Setting unknown app action to 'prompt'")
        if CommonAppProFns.setUnknownAppAction(3) == False :
            logging.error("Failed to set unknown app action to 'Prompt'")
            return 1

        # Launch application which is apple signed and not white-listed
        # in a new thread
        try :
            logging.debug("launching %s in new thread" % self.app_path)
            self.thread_return = None
            _thread = threading.Thread(target=self.m_launch_app,args=[self] )
            _thread.start()
        except :
            logging.error("Failed to start the thread")
            return 1

        #  Check if prompt is coming or not.
        logging.debug("Sleeping for %d seconds" % self.sleep_time)
        time.sleep(self.sleep_time)
        if CommonAppProFns.alertAllowWithNetworkOnce() != True :
            logging.error("Failed to verify the application launch")
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
        logging.debug("Launching application %s" % self.app_path)
        try :
            _p = subprocess.Popen([self.app_path], stdout=subprocess.PIPE)
            if _p == None :
                logging.error("Failed to launch application")
                self.thread_return = 1
        except :
            logging.error("Failed to launch application")
            self.thread_return = 1
        self.thread_return = 0

    def verify(self):

        logging.info("Verifying testcase %s" % testcaseName)
        # Check if process is running
        if commonFns.isProcessRunning(self.process) != True :
            logging.error("Failed to launch application using alert")
            return 1
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()

        # Perform testcase specific cleanup
        self._cleanup()
        
        # Clean the logs
        commonFns.cleanLogs()

        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")

        return foundCrash

    def _cleanup(self):
        # Reset app-pro preferences
        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()

        # If process already running, kill it.
        if commonFns.isProcessRunning(self.process) == True :
            try :
                logging.debug("%s already running. Killing it" % self.process)
                subprocess.call(["killall", "-SIGTERM", self.process], stdout=subprocess.PIPE)
            except :
                logging.error("Failed to kill existing %s instance" % self.process)
                return 1
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
