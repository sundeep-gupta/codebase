#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 17446
# TestcaseDescription: App Pro feature behaviour test when Trash gets empty

import sys
import logging
import shutil
import subprocess
import os
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
        logging.info("TestcaseID : 17446")
        logging.info("Description :  App Pro feature behaviour test when Trash gets empty")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call common init code.
        if BaseTest.init(self) != 0 :
            return 1

        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        CommonAppProFns.resetAppProtToDefaults()
        self.app_actual = os.path.abspath(os.path.dirname(sys.argv[0]))\
                        + "/data/SampleApplications/UDPClient"
        self.app_path = self.app_actual + "_Copy"
        if not os.path.exists(self.app_actual) :
            logging.debug("Test application not found %s" % self.app_actual)
            return 1
        try :
            logging.debug("Copying to %s" % self.app_path)
            shutil.copy(self.app_actual, self.app_path)
        except:
            logging.error("Failed to copy %s" % self.app_actual)
            return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        
        # Step 0 : Set exclusion for aptt
        if CommonAppProFns.setAppProExclusions( [ os.getcwd() + "/data/aptt" ]) != True:
            logging.error("Unable to add aptt exclusion")
            return 1
        
        # Step 1 : Set unknown app action to deny
        logging.debug("Change unknown app action to deny")
        _retval = CommonAppProFns.setUnknownAppAction(2)
        if _retval == None :
            logging.error("Failed to set Unknown App Action to Deny")
            return 1
        try :
            # Step 2 : Move an unknown application to Trash
            logging.debug("Moving application to trash")
            shutil.move(self.app_path, os.environ['HOME'] + "/.Trash/UDPClient_Copy")
        except :
            logging.error("Failed to move the application to trash" )
            return 1
            
        try :
            # Step 4 : Empty Trash now
            logging.debug("Emptying Trash")
            # To actually simulate the testcase, use finder to empty
            # the trash
            _applescript = "osascript -e 'tell application \"Finder\" to Empty Trash'"
            logging.debug(_applescript)
            if subprocess.call(["/bin/sh", "-c", _applescript]) != 0 :
               logging.error("Failed to delete the files from trash using oas")
        except :
            logging.error("Failed to delete the files from trash")
            return 1

        return 0



    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        
        # Check the McAfeeSecurity Log for Deny Message.
        if commonFns.searchProductLog(
            "Denied .+ because of profile rule match") == True :
            logging.error("Application is blocked by AppProt : match found in log")
            return 1
        return 0

    def cleanup(self):
	logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        logging.debug("Copying logs")
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        if os.path.exists(self.app_path):
            logging.debug("Application still exist which should not happen")
            try :
                os.remove(self.app_path)
            except:
                logging.warn("Failed to cleanup %s" % self.app_path)

        if os.path.exists(os.environ['HOME'] + '/.Trash/UDPClient_Copy') :
            logging.debug("Remnants found in Trash")
            try :
                os.remove(os.environ['HOME'] + '/.Trash/UDPClient_Copy')
            except :
                logging.warn("Failed to clean trash")
        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()
        # Clean Logs
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
