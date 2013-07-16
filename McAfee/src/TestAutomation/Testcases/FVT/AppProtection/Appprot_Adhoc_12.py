#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 17435
# TestcaseDescription: Application behaviour when hard link is created and app is added to AppPro rule 

import sys
import logging
import subprocess
import os

# Import CommonTest module into current namespace
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
        logging.info("TestcaseID : 17435")
        logging.info("Description : Application behaviour when hard link is created and app is added to AppPro rule")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        _retval = BaseTest.init(self)
        if _retval != 0:
            return 1
        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        CommonAppProFns.resetAppProtToDefaults()
        self._rule = dict()
        self._binaryPath = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/UDPClient" 
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        # Set exclusion for aptt
        if CommonAppProFns.setAppProExclusions( [ os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt" ]) != True:
            logging.error("Unable to add aptt exclusion")
            return 1
        logging.debug("Added exclusion for aptt")
       
        # Set unknown app action to block
        if CommonAppProFns.setUnknownAppAction(2) != True:
            logging.error("Unable to set unknown apps to block. Can't proceed")
            return 1
        logging.debug("set unknown app action to deny")
        
        # Lets Add a rule for UDPClient binary
        self._rule["AppPath"]= self._binaryPath
        self._rule["ExecAllowed"]="1"
        self._rule["Enabled"]="1"
        self._rule["NwAction"]="1"
        _retval= CommonAppProFns.addAppProtRule(self._rule)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule failed with code " + str(_retval))
            return 1

        logging.debug("Added rule for UDPClient")
        # Lets create a hardlink for UDPClient
        retval = subprocess.call( [ "ln",
                                    "-f",
                                    self._binaryPath,
                                    self._binaryPath+"_hl" ] )
        if retval != 0:
            logging.error("Hardlink creation failed")
            return 1
        
        retval = subprocess.call( [ self._binaryPath+"_hl",
                                    "172.16.193.1",
                                    "500",
                                    "Message" ])
        if retval != 0:
            logging.error("Launching of UDPClient failed")
            return 1

        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
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
