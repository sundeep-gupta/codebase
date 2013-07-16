#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16586
# TestcaseDescription: Set Restricted Network Access for application: Scenario 4 

import sys
import logging
import time
import subprocess
import threading
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
        logging.info("TestcaseID : 16586")
        logging.info("Set Restricted Network Access for application: Scenario 4.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Define variables.
        self.app_path =  os.path.dirname(os.path.abspath(sys.argv[0]))\
                + "/data/SampleApplications/UDPClient"
        self.customRule=[]
        _cr = dict()
        _cr = {"IP":"ANY_IP","Port":"ANY_PORT","Protocol":"3",
                            "Direction":"3","Action":"2"}
        self.customRule.append(_cr)
        self.rule = {"AppPath" : self.app_path, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"3",
                     "CustomRules":self.customRule}
        
        # Install AppProt test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1

        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()

               # Exclude APTT
        logging.debug("Exclude APTT")
        CommonAppProFns.setAppProExclusions([os.path.dirname(\
                os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"])
         #enable AppPro Trace
        if CommonAppProFns.enableApproTrace("reportMgrFlow")!=True:
            return 1
     
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule")
            return 1
        logging.debug("Setting unknown app action to 'Deny'")
        if CommonAppProFns.setUnknownAppAction(2) == False :
            logging.error("Failed to set unknown app action to 'Deny'")
            return 1

        return 0

    def verify(self):

        try :
            logging.debug("Launching %s" % self.app_path)
            subprocess.call([self.app_path, "127.0.0.1", "5000","Message"],\
                            stdout=subprocess.PIPE)
            time.sleep(10)
            
            _regex="Denied "+self.app_path+" from creating a UDP connection to 127.0.0.1:5000"
            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",_regex) != True:
                logging.error("regex is not matching")
                return 1
        except:
            logging.debug("Failed to launch application as expected")
            return 0 
        logging.info("UDP network Action is Denied")
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()
        #disable Appro traces
        CommonAppProFns.disableApproTrace("reportMgrFlow")
        # Clean the logs
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
