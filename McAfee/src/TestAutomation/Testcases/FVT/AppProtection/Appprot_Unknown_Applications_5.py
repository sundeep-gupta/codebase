#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16569
# TestcaseDescription: Verify when user allows unknown application from McAfee Alert, product shall populate all required p

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
        logging.info("TestcaseID : 16569")
        logging.info("Verify when user allows unknown application from McAfee Alert, product shall populate all required .")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Define variables.
        self.app_path =  os.path.dirname(os.path.abspath(sys.argv[0]))\
                + "/data/SampleApplications/UDPClient"
        self.sleep_time = 5
        self.m_launch_app = TestCase._launch_app
        self.rule = {"AppPath" : self.app_path, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"1"}
        
        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        CommonAppProFns.resetAppProtToDefaults()
     
        # Exclude APTT
        logging.debug("Exclude APTT")
        CommonAppProFns.setAppProExclusions([os.path.dirname(\
                os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"])
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Set unknown app to prompt
        logging.debug("Setting unknown app action to 'prompt'")
        if CommonAppProFns.setUnknownAppAction(3) == False :
            logging.error("Failed to set unknown app action to 'Prompt'")
            return 1

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
        if CommonAppProFns.alertAllowWithNetworkAlways("taf", "test") != True :
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
            _p = subprocess.Popen([self.app_path,"127.0.0.1","5000","Message"], stdout=subprocess.PIPE)
            if _p == None :
                logging.error("Failed to launch application")
                self.thread_return = 1
        except :
            logging.error("Failed to launch application")
            self.thread_return = 1
        self.thread_return = 0

    def verify(self):

        logging.info("Verifying testcase %s" % testcaseName)
        self.rule2=CommonAppProFns.getAppProtRules()
        for key in self.rule:
            if self.rule[key]!=self.rule2[0][key]:
                logging.error(" Rules are not equal")
                return 1;
        try :
            logging.debug("Launching %s" % self.app_path)
            subprocess.call([self.app_path, "127.0.0.1", "5000","Message"],\
                            stdout=subprocess.PIPE)
            logging.debug("Application got launced.")
            return 0
        except:
            logging.debug("Failed to launch application as expected")
            return 1
        logging.info("Rules are matched So Rule Got updated to AppPro Rule Store")

        
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()
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
