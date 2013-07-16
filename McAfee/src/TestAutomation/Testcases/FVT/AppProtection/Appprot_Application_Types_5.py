#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16404
# TestcaseDescription: Verify BSD process can be allowed execution

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
        logging.info("TestcaseID : 16404")
        logging.info("Verify BSD process can be allod execution")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Define variables.
        self.BSDAppPath =  os.path.dirname(os.path.abspath(sys.argv[0]))\
                + "/data/SampleApplications/UDPServer"
        self.sleep_time = 5
        self.appName = "UDPServer"
        self.m_launch_app = TestCase._launch_app
        self.rule = {"AppPath" : self.BSDAppPath, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"1"}
        
        # Install AppProt test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
     
        # Part of cleanUp    
        CommonAppProFns.resetAppProtToDefaults()

        # Exclude APTT
        logging.debug("Exclude APTT")
        CommonAppProFns.setAppProExclusions([os.path.dirname(\
                os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"])
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        try :
            logging.debug("launching %s in new thread" % self.BSDAppPath)
            self.thread_return = None
            _thread = threading.Thread(target=self.m_launch_app,args=[self] )
            _thread.start()
        except :
            logging.error("Failed to start the thread")
            return 1

        #  Check if prompt is coming or not.
        logging.debug("Sleeping for %d seconds" % self.sleep_time)
        time.sleep(self.sleep_time)
        
        # Wait for thread to join
        logging.debug("Waiting for thread to join")
        _thread.join()
        logging.debug("Thread joined")
        return self.thread_return

    def _launch_app(self):
        """Callback function which launches application.
        Called by Thread.run
        """
        logging.debug("Launching application %s" % self.BSDAppPath)
        try :
            _p = subprocess.Popen([self.BSDAppPath,"127.0.0.1","5000"], stdout=subprocess.PIPE)
            if _p == None :
                logging.error("Failed to launch application")
                self.thread_return = 1
        except :
            logging.error("Failed to launch application")
            self.thread_return = 1
        self.thread_return = 0

    def verify(self):

        logging.info("Verifying testcase %s" % testcaseName)
        if commonFns.isProcessRunning(self.appName) != True :
            logging.error("Application is not running")
            return 1
        logging.debug("Application is running")    
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()
        Cmd = "killall -9 " + self.appName
        retval = subprocess.call(Cmd, shell=True)
        if(retval != 0):
            logging.error("unable to kill %s application", self.appName)

        # Clean the logs
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
