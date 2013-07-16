#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 17441
# TestcaseDescription:  AppPro behaviour test when a binary added to appPro rule, gets changed

import sys
import logging
import shutil
import os
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
    # Files which we will use as our test binaries
    _binary_1=os.getcwd() + "/data/SampleApplications/UDPServer"
    _binary_2=os.getcwd() + "/data/SampleApplications/UDPClient"
    # Copies of Files which we will use as our test binaries
    _binary_1_copy=_binary_1 + "_copy"
    _binary_2_copy=_binary_2 + "_copy"

    def __init__(self):
        logging.info("TestcaseID : 17441")
        logging.info("Description : AppPro behaviour test when a binary added to appPro rule, gets changed")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        try:
            shutil.copy(self._binary_1,self._binary_1_copy)
            shutil.copy(self._binary_2,self._binary_2_copy)
        except:
            logging.error("Unable to copy the binaries")
            return 1
       
        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        CommonAppProFns.resetAppProtToDefaults()
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Set exclusion for aptt
        if CommonAppProFns.setAppProExclusions( [ os.getcwd() + "/data/aptt" ]) != True:
            logging.error("Unable to add aptt exclusion")
            return 1
        logging.debug("Added exclusion for aptt")
    
        # Set unknown app action to block
        if CommonAppProFns.setUnknownAppAction(2) != True:
            logging.error("Unable to set unknown apps to block. Can't proceed")
            return 1
        logging.debug("set unknown app action to deny")

        # Lets Add a rule for first binary
        _rule1 = dict()
        _rule1["AppPath"]= self._binary_1_copy
        _rule1["ExecAllowed"]="1"
        _rule1["Enabled"]="1"
        _rule1["NwAction"]="1"
        if CommonAppProFns.addAppProtRule(_rule1) != CommonAppProFns.SUCCESS:
            logging.error("Addition of allow rule failed")
            return 1
        
        logging.debug("Added rule for binary one")
        
        # Lets Add a rule for second binary
        _rule2 = dict()
        _rule2["AppPath"]= self._binary_2_copy
        _rule2["ExecAllowed"]="0"
        _rule2["Enabled"]="1"
        _rule2["NwAction"]="1"
        if CommonAppProFns.addAppProtRule(_rule2) != CommonAppProFns.SUCCESS:
            logging.error("Addition of deny rule failed")
            return 1
        logging.debug("Added rule for binary two")

        # Mv second binary to first 
        try:
            shutil.move(self._binary_2_copy,self._binary_1_copy)
            logging.debug("Moving " + self._binary_2_copy + " to " + self._binary_1_copy + " succeeded")
        except:
            logging.error("Moving " + self._binary_2_copy + " to " + self._binary_1_copy + " failed")
            return 1

        time.sleep(5)
        try:
            retval = subprocess.call( [ self._binary_1_copy,
                                    "172.16.193.1",
                                    "500",
                                    "Message" ])
            logging.info("Invocation of binary succeeded. This is not good")
            return 1         
        except:
            logging.info("Invocation of binary failed as expected")         
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        if commonFns.searchProductLog("Denied " +
                                      self._binary_1_copy +
                                      " from executing because  it matched with profile rule for") != True:
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
        try:   
            os.remove(self._binary_1_copy)
            os.remove(self._binary_2_copy)
        except:
            pass
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
