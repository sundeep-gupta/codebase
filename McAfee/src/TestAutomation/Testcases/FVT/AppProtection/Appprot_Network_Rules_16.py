#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16598
# TestcaseDescription: Set Restricted Network Access for application: Scenario 16


import os
import sys
import logging
import time
import subprocess
import threading
import socket

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
        logging.info("TestcaseID : 16598")
        logging.info("Set Restricted Network Access for application: Scenario 17.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Define variables.
        self.hostIp=socket.gethostbyname(socket.gethostname())
        self.subnetAddr= self.hostIp+"/24"
        self.app_path_client =  os.path.dirname(os.path.abspath(sys.argv[0]))\
                + "/data/SampleApplications/TCPClient"
        self.app_path_server= os.path.dirname(os.path.abspath(sys.argv[0]))\
                + "/data/SampleApplications/TCPServer"
        self.process= "TCPServer"
        self.customRule=[]
        _cr = dict()
        _cr = {"IP":self.hostIp,"Port":"ANY_PORT","Protocol":"3",
                            "Direction":"3","Action":"2"}
        self.customRule.append(_cr)
        self.rule1 = {"AppPath" : self.app_path_server, "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"3",
                     "CustomRules":self.customRule}

        self.rule2 = {"AppPath" : self.app_path_client, "Enabled" : "1",
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

        _cmd =  self.app_path_server +" "+self.hostIp+ " 5000"
        process=subprocess.Popen(_cmd,shell=True, stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE)
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        if CommonAppProFns.addAppProtRule(self.rule1) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule")
            return 1
        if CommonAppProFns.addAppProtRule(self.rule2) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule")
            return 1
        logging.debug("Setting unknown app action to 'Deny'")
        if CommonAppProFns.setUnknownAppAction(2) == False :
            logging.error("Failed to set unknown app action to 'Deny'")
            return 1
         #enable trace
        if CommonAppProFns.enableApproTrace("reportMgrFlow")!=True:
            return 1
        return 0

    def verify(self):

        try :
            _p = subprocess.call([self.app_path_client,self.hostIp,"5000","Message"], stdout=subprocess.PIPE)
            if _p != 0 :
                time.sleep(10)
                logging.debug("Failed to connect TCPServer as expected")
                _regex="Denied "+self.app_path_client+" from creating a TCP connection to "+self.hostIp
                if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",_regex) != True:
                    logging.error("regex is not matching")
                    return 1

        except :
            logging.info("Failed to launch application as expected")
            return 0
        logging.info("Failed to connect TCPServer due to subnet address match Denied rule as expected ")
        return 0
        

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()
        if commonFns.isProcessRunning(self.process) == True :
            try :
                logging.debug("%s already running. Killing it" % self.process)
                subprocess.call(["killall", "-SIGTERM", self.process], stdout=subprocess.PIPE)
            except :
                logging.error("Failed to kill existing %s instance" % self.process)
                return 1
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
