#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 17445
# TestcaseDescription:  AppProtd daemon behaviour test when profile.data is corrupted

import sys
import logging
import os
import shutil
import subprocess
import time

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")


import commonFns
# Import CommonTest module into current namespace
from CommonTest import *

import commonFns
import CommonAppProFns
# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 17445")
        logging.info("Description : AppProtd daemon behaviour test when profile.data is corrupted")

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

        
        self.app_path = os.path.dirname(os.path.abspath(sys.argv[0]))\
            + "/data/SampleApplications/UDPClient"
        self.new_path = self.app_path + "_newpath"
        self.sleep_time = 30
        self.rule = {
            'AppPath' : self.new_path,
            'ExecAllowed' : '0',
            'Enabled' : '1',
            'NwAction' : '1'
        }
        # test case specific cleanup.
        self._cleanup()
        
        # Copy the app as backup.
        if not os.path.exists(self.app_path) :
            logging.error("Test application not found : %s" % self.app_path)
            return 1

        try :
            logging.debug("Taking backup of the application %s" % self.app_path)
            shutil.copy(self.app_path, self.new_path)
        except shutil.Error:
            logging.error("Failed to take backup of the application")
            return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        # Step 1 : Add the app in profile
        logging.debug("Setting app pro rule for %s" % self.new_path)
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to set rule for the app ")
            return 1

        # Step 2 : Remove the app from the disk
        try :
            logging.debug("Removing %s from disk" % self.new_path)
            os.remove(self.new_path)
        except:
            logging.error("Failed to remove the application from filesystem")
            return 1

        # Step 3 : Restart appPro
        try :
            logging.debug("Restarting appProtd")
            _cmd = ["/usr/local/McAfee/AppProtection/bin/AppProtControl","restart"]
            _retval = subprocess.call(_cmd, stdout=subprocess.PIPE)
            logging.debug("AppProtControl restart returned %s " % str(_retval))
            logging.debug("Sleeping for 30 seconds")
            time.sleep(self.sleep_time)
        except :
            logging.error("Failed to restart appProtd daemon")
            return 1
        return 0

    def verify(self):

        logging.info("Verifying testcase %s" % testcaseName)

        # Run getAppRules to verify if appProtd is working
        logging.debug("Verifying if appProtd is running by getting the rules.")
        _rules = CommonAppProFns.getAppProtRules()
        if _rules is None :
            logging.error("Failed to get appProt Rules")
            return 1
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs
        logging.debug("Copying the crash logs (if any)")
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Perform test case specific cleanup
        self._cleanup()
        # Clean Logs
        logging.debug("Cleaning the logs")
        commonFns.cleanLogs()

        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")

        return foundCrash

    def _cleanup(self):
        try :
            # Remove the app from profile.
            logging.debug("Resetting application protection to defaults.")
            CommonAppProFns.resetAppProtToDefaults()

            # Bring back the application
            if os.path.exists(self.new_path) :
                logging.debug("%s still exists, removing it " % self.new_path)
                try :
                    os.remove(self.new_path)
                except :
                    logging.warn("Failed to remove %s" % self.new_path )
        except AttributeError :
            # This occur when we fail in init without initializing the attr.
            # Just ignore
            pass
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
