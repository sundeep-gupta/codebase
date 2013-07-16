#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16480
# TestcaseDescription:  Testcase to perform actions such as 1) Add 2) Delete and 3) Edit

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
        logging.info("TestcaseID : 16480")
        logging.info("Description : Testcase to perform actions such as 1) Add 2) Delete and 3) Edit")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Installation of AppPro Test Tool failed.")
            return 1
        
        CommonAppProFns.resetAppProtToDefaults()
        subprocess.call( [ "killall", "-SIGKILL","Safari" ],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Add a rule - Lets Add a rule for UDPServer binary
        self._rule1 = dict()
        self._rule1["AppPath"]= os.getcwd() + "/data/SampleApplications/UDPServer"
        self._rule1["ExecAllowed"]="0"
        self._rule1["Enabled"]="1"
        self._rule1["NwAction"]="1"
        _retval = CommonAppProFns.addAppProtRule(self._rule1)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule1 failed with code %d" % _retval)
            return 1
        
        # Add a rule - Lets Add a rule for UDPClient binary
        self._rule2 = dict()
        self._rule2["AppPath"]= os.getcwd() + "/data/SampleApplications/UDPClient"
        self._rule2["ExecAllowed"]="1"
        self._rule2["Enabled"]="1"
        self._rule2["NwAction"]="1"
        _retval = CommonAppProFns.addAppProtRule(self._rule2)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule2 failed with code %d" % _retval)
            return 1
        
        # Add a rule - Lets Add a rule for Safari
        self._rule3 = dict()
        self._rule3["AppPath"]= "/Applications/Safari.app"
        self._rule3["ExecAllowed"]="1"
        self._rule3["Enabled"]="1"
        self._rule3["NwAction"]="1"
        _retval = CommonAppProFns.addAppProtRule(self._rule3)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule3 failed with code %d" % _retval)
            return 1
       
        # Lets launch all three apps
        try:
            self._process1 =subprocess.Popen( [ os.getcwd() + "/data/SampleApplications/UDPServer" ],
                                         stdout=subprocess.PIPE,
                                         stderr=subprocess.PIPE)
            logging.error("First process was allowed to execute inspite of deny rule")
            return 1
        except:
            logging.info("First process was denied execution as per rule")

        try:
            self._process2 =subprocess.Popen( [ os.getcwd() + "/data/SampleApplications/UDPClient" ],
                                         stdout=subprocess.PIPE,
                                         stderr=subprocess.PIPE)
            logging.info("second process was allowed to execute inspite as per rule")
        except:
            logging.error("Second process was denied execution inspite of rule")
            return 1
        
        try:
            self._process3 =subprocess.Popen( [ "open",
                                                "/Applications/Safari.app"],
                                         stdout=subprocess.PIPE,
                                         stderr=subprocess.PIPE)
            logging.info("Third process was allowed to execute inspite as per rule")
        except:
            logging.error("Third process was denied execution inspite of rule")
            return 1
                                         
        time.sleep(2)
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        if commonFns.isProcessRunning("Safari") == False:
            logging.error("Safari is not running")
            return 1

        logging.error("Safari is runnning")

        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        CommonAppProFns.resetAppProtToDefaults()
        subprocess.call( [ "killall", "-SIGKILL","Safari" ])
        # Wait for our processes to go down
        self._process2.communicate()
        self._process3.communicate()
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
