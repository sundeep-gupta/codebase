#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16458
# TestcaseDescription:  Deny the execution of the application. Login with some non admin user and try to launch the application. 

import sys
import logging
import subprocess
import time
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
        logging.info("TestcaseID : 16458")
        logging.info("Description : Deny the execution of the application. Login with some non admin user and try to launch the application.") 

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        self.cocoaAppPath = "/Applications/Safari.app" 
        self.appName = "Safari"
        self.userName = "taf"
        self.password = "test"
        self.CommandPath = os.getcwd() + "/../Common/"

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

        #Rule to deny execution
        self.rule = { 
                    'AppPath' : self.cocoaAppPath,
                    'ExecAllowed' : '0',
                    'Enabled' : '1',
                    'NwAction' : '1' 
                    }  
        # Check if the app is already running   
        if commonFns.isProcessRunning(self.appName) != True :
            logging.error("Application :%s is not running", self.appName)
        else:    
            Cmd = "killall -9 " + self.appName
            retval = subprocess.call(Cmd, shell=True)
            if(retval != 0): 
                logging.error("unable to kill %s application", self.appName)
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        #Add a cocoa application to AppPro rule list and Block execution
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS :
            logging.error("Addition of rule failed")
            return 1

        if not commonFns.userExists(self.userName) :
            logging.error("User " + self.userName + " which is required to run the testscript not found")
            return 1

        # Add a login Item to Launch the application
        logging.debug("Add a login item to User")
        if commonFns.addLoginItem(self.userName,self.CommandPath,"logback.command") == False:
            logging.error("Error while adding loginItem to User1")
            return 1

        logging.debug("FastUser switch to User")
        if commonFns.fastUserSwitching(self.userName, self.password) == False:
            logging.error(" Unable to do Fast user switch")
            return 1
        time.sleep(10)
        return 0

    def verify(self):
		#cocoa application will not get launched
        logging.info("Verifying testcase %s" % testcaseName)
        if commonFns.isProcessRunning(self.appName) == True :
            logging.error("Error application :%s is running" % self.cocoaAppPath)
            return 1
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()

        CommonAppProFns.resetAppProtToDefaults()
        
        if commonFns.isProcessRunning(self.appName) != True :
            logging.error("Application :%s is not running" %self.cocoaAppPath)
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
