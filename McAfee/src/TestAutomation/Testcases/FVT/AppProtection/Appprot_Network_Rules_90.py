#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16672
# TestcaseDescription: Set Restricted Network Access for application: Scenario 90

import sys
import logging
import subprocess
import time
import os

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")


import commonFns
# Import CommonTest module into current namespace
from CommonTest import *
import CommonAppProFns
# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 16672")
        logging.info("Description : Set Restricted Network Access for application: Scenario 90")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        self.trace_var = "reportMgrFlow"
        self.host_ip  = "127.0.0.1"
        self.port     = "5050"
        self.port2    = "6000"
        self.prot     = "UDP"
        self.app_path = os.path.dirname(os.path.abspath(sys.argv[0]))\
                        + "/data/SampleApplications/TCPUDPClient"
        self.process  = "TCPUDPClient"
        self.cmd      = [self.app_path, self.prot, self.host_ip, self.port, "Test Message"]
        self.rule     = {
                "AppPath"     : self.app_path,
                "Enabled"     : "1",
                "ExecAllowed" : "1",
                "NwAction"    : "3",
                "CustomRules" : [
                     # Add rule to allow outoging UDP connection
                     {
                        'IP'       : self.host_ip,
                        'Port'     : self.port + "-" + self.port2,
                        'Protocol' : '2', # UDP
                        'Direction': '2', # OUTGOING
                        'Action'   : '2'  # DENY
                     },
                     # For DENY We need to add another rule for ALLOW
                     {
                        'IP'       : "ANY_IP",
                        'Port'     : "ANY_PORT",
                        'Protocol' : '3', # ANY
                        'Direction': '3', # BOTH
                        'Action'   : '1'  # ALLOW
                     },
                ]
        }
        self.regex = "Denied %s from creating a %s connection to %s:%s because  of profile rule match with %s" % (self.app_path, self.prot, self.host_ip, self.port, self.app_path)

        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1

        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()

        logging.debug("Enabling Application protection traces for %s " % self.trace_var)
        if CommonAppProFns.enableApproTrace(self.trace_var) != True:
            logging.error("Failed to enable trace for %s" % self.trace_var)
            return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Add rule to deny application execution
        logging.debug("Add rule to deny application execution")
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS :
            logging.error("Failed to set deny rule for %s" % self.rule["AppPath"])
            return 1
        try :
            logging.debug("Checking the outgoing allow with %s" % self.app_path)
            subprocess.call(self.cmd, stdout=subprocess.PIPE)
        except :
            logging.error("UDP client failed for outgoing connection!")
            return 1
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        time.sleep(10)
        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",self.regex) != True:
            logging.error("Failed to match : %s" % self.regex)
            return 1
        return 0

    def cleanup(self):
        return 0
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()

        self._cleanup()

        logging.debug("Disabling Application protection traces for %s " % self.trace_var)
        if CommonAppProFns.disableApproTrace(self.trace_var) != True :
            logging.error("Failed to disable trace for %s" % self.trace_var)

        commonFns.cleanLogs()

        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")

        return foundCrash

    def _cleanup(self):

        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()

        # If process present, then kill
        if commonFns.isProcessRunning(self.app_path) == True :
            try :
                logging.debug("%s is already running. Killing it!" % self.process)
                subprocess.call(["killall", "-SIGTERM", self.process], stdout=subprocess.PIPE)
            except :
                logging.error("Failed to kill the process")
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
