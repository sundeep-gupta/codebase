#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16435
# TestcaseDescription: Verify History screen lists the blocked application event

import sys
import logging
import time
import subprocess

# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
import CommonAppProFns

# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 16435")
        logging.info("Description : Verify History screen lists the blocked application event")

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
        # Store the current 'history' count
        logging.debug("Fetching history table's row count")
        self.p_history = commonFns.getHistory()
        if self.p_history is None :
            return 1

        self._cleanup()
        # Restart the appProtd
        # 'restart' of appProtd is not working, so killing it and then restarting
        logging.debug("Restarting appProtection [ will sleep %d seconds ]" % self.sleep_time )
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
            # We expect an exception, thus coming here fails the testcase
            logging.error("Application got launced.")
            return 1
        except :
            logging.debug("Failed to launch application as expected")
        time.sleep(self.sleep_time)
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # STEP 3 Check the application block event in 'History'
        logging.debug("Fetching history table's row count")
        rows = commonFns.getHistory()
        if rows is None :
            logging.error("getHistory returned None")
            return 1
        if len(rows) > len(self.p_history) :
            return 0
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
