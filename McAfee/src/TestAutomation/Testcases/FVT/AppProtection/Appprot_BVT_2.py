#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 18043
# TestcaseDescription:  This TC is to check whether App Protection exclusion works

import sys
import stat
import os
import logging
import subprocess
import shutil
import time

# Add common folder into the sys path for module importing
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
        logging.info("TestcaseID : 18043")
        logging.info("Description : This TC is to check whether App Protection exclusion works")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Step 0 : Install APTT
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Installation of AppPro Test Tool failed.")
            return 1
        
        # Step 1 : reset apppro
        CommonAppProFns.resetAppProtToDefaults()

        return 0

    def execute(self):
        self._destinationBinary="/Applications/Chess.app"
        self._folderName="/Applications"
        logging.info("Executing testcase %s" % testcaseName)
        # Step 0 : Add a deny rule for the app in the new folder
        self._rule = dict()
        self._rule["AppPath"]= self._destinationBinary
        self._rule["ExecAllowed"]="0"
        self._rule["Enabled"]="1"
        self._rule["NwAction"]="1"
        _retval = CommonAppProFns.addAppProtRule(self._rule)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule failed with code %d" % _retval)
            return 1
        logging.debug("Added rule for %s " % self._destinationBinary)
        
        # Step 1 : Add exclusion
        if CommonAppProFns.setAppProExclusions( [ self._folderName ]) == False:
            logging.error("Exclusion set failed for %s" % self._folderName)
            return 1
        logging.debug("Setting of exclusions succeeded")
        # Step 2 : Launch the app
        try:
            _retval  =subprocess.call( [ "open",self._destinationBinary ],
                                         stdout=subprocess.PIPE,
                                         stderr=subprocess.PIPE)
            logging.info("%s process was allowed to execute as per exclusion" % self._destinationBinary)
        except:
            logging.error("%s process was allowed to execute inspite of exclusion" % self._destinationBinary)
            return 1
        time.sleep(3)   
        logging.info("Execution went through fine")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Step 0 : Reset App Pro
        CommonAppProFns.resetAppProtToDefaults()
        # Step 1: Kill chess
        subprocess.call( [ "killall", "-SIGTERM","Chess"],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
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
