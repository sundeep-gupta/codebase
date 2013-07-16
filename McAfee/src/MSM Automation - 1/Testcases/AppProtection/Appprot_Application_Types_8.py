#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16408
# TestcaseDescription:  Verify BSD applications be allowed restricted Network access

import sys
import logging
import subprocess
import time
import os

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
        logging.info("TestcaseID : 16408")
        logging.info("Description : Verify BSD applications be allowed restricted NetWork access")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        self.BSDAppPath=os.path.dirname(os.path.abspath(sys.argv[0])) \
                                           + "/data/SampleApplications/UDPClient"
        self.appName = "UDPClient"
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
        
        #Rule to Restricted Network access
        self.rule = { 
                    'AppPath' : self.BSDAppPath,
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
        # Check if the app is already running   
        if commonFns.isProcessRunning(self.appName) != True :
            logging.error("Application :%s is not running" %self.BSDAppPath)
        else:    
            Cmd = "killall -9 " + self.appName
            retval = subprocess.call(Cmd, shell=True)
            if(retval != 0): 
                logging.error("unable to kill %s application", self.appName)
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        logging.debug("Add a rule for restricted Network access")
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS :
            logging.error("Addition of rule failed")
            return 1
        try:
            # Try to launch
            logging.debug("Try to launch the application")
            retval = subprocess.call([self.BSDAppPath ,
                                        "127.0.0.1",
                                        "500",
                                        "Message"])
            if(retval != 0): 
                loggin.error("Unable to launch the %s", self.BSDAppPath)
                return 1
        except:
            logging.debug("Exception occured in launching %s", self.BSDAppPath)
            return 1
        return 0

    def verify(self):
		#cocoa application will not get launched
        logging.info("Verifying testcase %s" % testcaseName)
        regex = "Denied " + self.BSDAppPath + " from creating a UDP connection to 127.0.0.1:500" + \
                            " because  of profile rule match with " + self.BSDAppPath
        if commonFns.searchProductLog(regex) != True:
            logging.error("Expected error message not found in the product log")
            return 1
        logging.info("Expected error message found in the logs")    
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()

        CommonAppProFns.resetAppProtToDefaults()

        if commonFns.isProcessRunning(self.appName) != True :
            logging.error("Application :%s is not running" %self.BSDAppPath)
        else:    
            Cmd = "killall -9 " + self.appName
            retval = subprocess.call(Cmd, shell=True)
            if(retval != 0): 
                logging.error("unable to kill %s application", self.appName)
		
        # Our cleanUp
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
