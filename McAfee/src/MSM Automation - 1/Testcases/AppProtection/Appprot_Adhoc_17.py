#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 17440
# TestcaseDescription:  Application execution test when soft link is created and app is added to deny rule

import sys
import logging
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
    _rule = dict()
    _binaryPath = os.getcwd() + "/data/SampleApplications/TCPUDPClient" 
    def __init__(self):
        logging.info("TestcaseID : 17440")
        logging.info("Description : Application execution test when soft link is created and app is added to deny rule")

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
        _retval = CommonAppProFns.addAppProtRule(self._rule)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule failed with error" + str(_retval))
            return 1
        logging.debug("Added deny rule for UDPClient")
        
        # Lets create a softlink for UDPClient
        retval = subprocess.call( [ "ln",
                                    "-sf",
                                    self._binaryPath,
                                    self._binaryPath+"_hl" ] )
        if retval != 0:
            logging.error("Softlink creation failed")
            return 1
        
        try:
            retval = subprocess.call( [ self._binaryPath+"_hl",
                                    "UDP",
                                    "172.16.193.1",
                                    "500",
                                    "Message" ])
            logging.error("softlink was able to execute properly. This is wrong")
            return 1
        except:
            logging.info("Received exception while launching app. This is the right behaviour")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        if commonFns.searchProductLog(CommonAppProFns.REGEX_DENIED_RULE) != True:
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
        # delete the softlink
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
