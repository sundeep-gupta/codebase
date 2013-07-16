#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16623
# TestcaseDescription: Set Restricted Network Access for application: Scenario 41

import sys
import logging
import time
import subprocess
import threading
import socket
import random

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
        logging.info("TestcaseID : 16623")
        logging.info("Set Restricted Network Access for application: Scenario 41.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Define variables.
        self.hostIp=socket.gethostbyname(socket.gethostname())
        self.app_path_client =  os.path.dirname(os.path.abspath(sys.argv[0]))\
                + "/data/SampleApplications/TCPClient"
        self.app_path_server= os.path.dirname(os.path.abspath(sys.argv[0]))\
                + "/data/SampleApplications/TCPServer"
        self.process="TCPServer"

        self.port="5000"
        
        self.customRule=[]
        _cr = dict()
        _cr = {"IP":self.hostIp,"Port":"ANY_PORT","Protocol":"1",
                            "Direction":"1","Action":"2"}
        self.customRule.append(_cr)

        self.rule = {"AppPath" : self.app_path_server, "Enabled" : "1",
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


        _cmd =  self.app_path_server +" "+self.hostIp+" "+ self.port
        process=subprocess.Popen(_cmd,shell=True, stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE)

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add multiple sub-rules")
            return 1
        
        if CommonAppProFns.enableApproTrace("reportMgrFlow")!=True:
            return 1
        
        return 0

    def verify(self):

        try :
            logging.debug("Launching %s" % self.app_path_client)

            subprocess.call([self.app_path_client, self.hostIp, self.port,"Message"],\
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
            time.sleep(10)
            
            _regex="Denied "+self.app_path_server+" from accepting a TCP connection from "+self.hostIp
            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",_regex) != True:
                logging.error("TCP connection not denied for the given IP address")
                return 1
            
        #needs to verify AppProt trace file for rule match
        except:
            logging.debug("Failed to launch application  ")
            return 1

        logging.info("Network access successfully denied for given IP address")
        
        logging.info("Restricted Network Rule working as expected")
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()
        CommonAppProFns.disableApproTrace("reportMgrFlow")
        # Clean the logs
        commonFns.cleanLogs()
        
        # If process present, then kill
        if commonFns.isProcessRunning(self.process) == True :
            try :
                logging.debug("%s is already running. Killing it!" % self.process)
                subprocess.call(["killall", "-SIGTERM", self.process], stdout=subprocess.PIPE)
            except :
                logging.error("Failed to kill the process")

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
