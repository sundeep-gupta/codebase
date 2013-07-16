#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16396
# TestcaseDescription:  Uncheck allow apple signed binaries option in leopard , launch safari, set action to deny, outgoing

import sys
import logging
import subprocess
import re
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
        logging.info("TestcaseID : 16396")
        logging.info("Description : Uncheck allow apple signed binaries option in leopard , launch safari, set action to deny, outgoing")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        # Define variables
        self.app_path = "/usr/bin/nslookup"
        self.process = 'nslookup'
        self.cmd = [self.app_path, "www.google.com"]
        self.regex = "Denied " + self.app_path + " from creating a UDP "\
                + "connection to (.*) because  of profile rule match with "\
                + self.app_path
        self.rule = {
            'AppPath' : self.app_path,
            'ExecAllowed' : '1',
            'Enabled' : '1',
            'NwAction' : '3',
            'CustomRules' : [
                # Rule to block outgoing
                { 
                'IP' : 'ANY_IP',
                'Port' : 'ANY_PORT',
                'Protocol' : '3',
                'Direction' : '2',
                'Action' : '2'
                },
                # Rule to allow incoming
                {
                'IP' : 'ANY_IP',
                'Port' : 'ANY_PORT',
                'Protocol' : '3',
                'Direction' : '1',
                'Action' : '1'
                },
            ]
        }

        # Install AppProt test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        
        # Reset app-pro preferences
        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()
        
        # make sure network is available by running nslookup
        if self._check_network() == 1 :
            return 1

        if self.network == False :
            logging.error("Network connection is required for this test")
            return 1

        # If process already running, kill it.
        if commonFns.isProcessRunning(self.process) == True :
            try :
                logging.debug("%s already running. Killing it" % self.process)
                subprocess.call(["killall", "-SIGTERM", self.process], stdout=subprocess.PIPE)
            except :
                logging.error("Failed to kill existing %s instance" % self.process)
                return 1
        return 0

    def _check_network(self):
        """Runs nslookup to check the network connection"""
        self.network = None
        try :
            logging.debug("Running %s to check network connectivity" % self.app_path)
            _p = subprocess.Popen(self.cmd, stdout=subprocess.PIPE)
            _p.wait()
            _out = _p.stdout.read()
            if re.search("Address:\s+\d+\.\d+\.\d+\.\d+", _out) == None :
                logging.debug("Failed to resolve address")
                self.network = False
            else :
                logging.debug("Able to resolve address")
                self.network = True
        except :
            logging.error("Failed to run %s" % self.app_path)
            return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        # Disable apple signed binaries
        logging.debug("unchecking allow applesigned binaries")
        if CommonAppProFns.allowAppleSignedBinaries(False) == False :
            logging.error("Failed to uncheck allow applesigned binaries")
            return 1
        # Set rule to deny outgoing for the application
        logging.debug("Setting rule for %s" % self.app_path)
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS :
            logging.error("Failed to set the deny outgoing rule for %s" % self.app_path)
            return 1
        # Launch application which is apple signed to access network
        if self._check_network() == 1 :
            return 1
        if self.network != False :
            logging.debug("Outgoing connections are still allowed")
            return 1
        
        return 0


    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # Make sure there is no outgoing connection
        if commonFns.searchProductLog(self.regex) == False :
            logging.error("Failed to match %s in product log" % self.regex)
            return 1
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        
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
