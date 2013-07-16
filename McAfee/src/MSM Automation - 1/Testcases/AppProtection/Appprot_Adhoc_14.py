#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 17437
# TestcaseDescription:  Application execution test when hard link is created and app is added to deny rule

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
    _rule = dict()
    _binaryPath = os.getcwd() + "/data/SampleApplications/TCPUDPClient" 
    def __init__(self):
        logging.info("TestcaseID : 17437")
        logging.info("Description : Application execution test when hard link is created and app is added to deny rule")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        _retval = BaseTest.init(self)
        if _retval != 0:
            return 1
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Installation of AppPro Test Tool failed.")
            return 1
        CommonAppProFns.resetAppProtToDefaults()
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Lets Add a rule for UDPClient binary
        self._rule["AppPath"]= self._binaryPath
        self._rule["ExecAllowed"]="0"
        self._rule["Enabled"]="1"
        self._rule["NwAction"]="1"
        if CommonAppProFns.addAppProtRule(self._rule) != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule failed")
            return 1
        logging.debug("Added deny rule for UDPClient")
        
        # Lets create a hardlink for UDPClient
        retval = subprocess.call( [ "ln",
                                    "-f",
                                    self._binaryPath,
                                    self._binaryPath+"_hl" ] )
        if retval != 0:
            logging.error("Hardlink creation failed")
            return 1

        time.sleep(3) 

        try:
            retval = subprocess.call( [ self._binaryPath+"_hl",
                                    "UDP",
                                    "172.16.193.1",
                                    "500",
                                    "Message" ])
            if retval == 0:
                logging.error("hardlink was able to execute properly. This is wrong")
                return 1
            else:
                logging.info("Received error while launching app. This is the right behaviour")
                return 0 
        except:
            logging.info("Received exception while launching app. This is the right behaviour")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        time.sleep(10)
        if commonFns.searchProductLog("Denied " +
                                      self._binaryPath +
                                      " from executing because  of profile rule match") != True:
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
        # delete the hardlink
        try:
            os.remove(self._binaryPath+"_hl")
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
