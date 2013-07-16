#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16434
# TestcaseDescription: Verify Recent events shows the recently blocked application

import sys
import logging
import time
import subprocess
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
        logging.info("TestcaseID : 16434")
        logging.info("Description : Verify Recent events shows the recently blocked application")

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

        # Create data
        self.app_path = os.path.dirname(os.path.abspath(sys.argv[0]))\
            + "/data/SampleApplications/TCPUDPClient"
        self.process = "TCPUDPClient"
        self.cmd = [self.app_path, "UDP", "127.0.0.1", "1000", "Test"]
        self.rule = {"AppPath" : self.app_path, "Enabled" : "1",
                     "ExecAllowed":"0",
                     "NwAction":"1"}
        self.sleep_time = 10
        self._cleanup()
        # Store the current 'Recent Events' count
        logging.debug("Fetching recentEvents table's row count")
        self.prev_events = commonFns.getRecentEvents()
        if self.prev_events is None :
            return 1

        # Restart the appProtd
        # 'restart' of appProtd is not working, so killing it and then restarting
        logging.debug("Restarting appProtection will take %d seconds " % (self.sleep_time * 2))
        subprocess.call(["/usr/local/McAfee/AppProtection/bin/AppProtControl","restart"],
                            stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        time.sleep(self.sleep_time)

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        # STEP 1 Add an application to rule list and block execution for it
        logging.debug("Add rule to deny application execution")
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS :
            logging.error("Failed to set deny rule for %s" % self.rule["AppPath"])
            return 1

        # STEP 2. Launch the blocked application
        try :
            logging.debug("Launching %s" % self.app_path)
            subprocess.Popen(self.cmd, stdout=subprocess.PIPE)
        except :
            logging.debug("Failed to launch application as expected")
        time.sleep(self.sleep_time)
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # STEP 3 Check the application block event in 'Recent Events'
        logging.debug("Fetching recentEvents table's row count")
        rows = commonFns.getRecentEvents()
        if rows is None :
            return 1

        logging.debug("Comparing current event count with previous event count")
        i = 0
        for row in rows :
            logging.debug("Comparing %s and %s" % (row[1], self.prev_events[i][1]))
            if row[1] != self.prev_events[i][1] :
                return 0
            i=i+1

        logging.error("previous and current recent events records are same")
        return 1

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Perform test specific cleanup
        self._cleanup()
        # Now cleanup the logs
        commonFns.cleanLogs()

        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")

        return foundCrash

    def _cleanup(self):
        CommonAppProFns.resetAppProtToDefaults()
        # Kill the application if it is already running.
        if commonFns.isProcessRunning(self.process) == True :
            try :
                logging.debug("%s already running. Killing it" % self.process)
                subprocess.call(["killall", "-SIGTERM", self.process], stdout=subprocess.PIPE)
            except :
                logging.error("Failed to kill existing %s instance" % self.process)
                return 1
        return 0

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
