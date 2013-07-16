#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16605
# TestcaseDescription: Set Restricted Network Access for application: Scenario 23

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
        logging.info("TestcaseID : 16605")
        logging.info("Set Restricted Network Access for application: Scenario 23.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Define variables.
        self.hostIp=socket.gethostbyname(socket.gethostname())
        self.subnetAddr=self.hostIp+"/24"
        self.port="5000"
        self.app_path_client =  os.path.dirname(os.path.abspath(sys.argv[0]))\
                + "/data/SampleApplications/TCPClient"
        self.app_path_server= os.path.dirname(os.path.abspath(sys.argv[0]))\
                + "/data/SampleApplications/TCPServer"
        self.process= "TCPServer"
        self.customRule=[]
        _cr = dict()
        _cr = {"IP":self.subnetAddr,"Port":self.port,"Protocol":"1",
                            "Direction":"3","Action":"2"}
        self.customRule.append(_cr)

        # Add allow-all-remaining subrule
        _cr1 = dict()
        _cr1 = {"IP":"ANY_IP","Port":"ANY_PORT","Protocol":"3",
                            "Direction":"3","Action":"1"}
        self.customRule.append(_cr1)
        
        self.rule1 = {"AppPath" : self.app_path_client, "Enabled" : "1",
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
        if CommonAppProFns.addAppProtRule(self.rule1) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule")
            return 1

        #enable trace
        if CommonAppProFns.enableApproTrace("reportMgrFlow")!=True:
            return 1
       
        return 0

    def verify(self):

        try :
            logging.debug("Launching %s" % self.app_path_client)
            process=subprocess.call([self.app_path_client,self.hostIp,self.port,"Message"], stdout=subprocess.PIPE)
            time.sleep(10)

            _regex="Denied "+self.app_path_client+" from creating a TCP connection to "+ self.hostIp
            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",_regex) != True:
                logging.error("TCP connection not denied for given single port")
                return 1
               
        except :
            logging.error("Failed to launch application")
            return 1

        logging.info("TCP Subnet network action denied as expected ")

        try :
            logging.debug("Launching %s" % self.app_path_client)

            # Mark port number outside the port range
            _randPortNum = int(self.port) + random.randint(1,1000)
            subprocess.call([self.app_path_client, self.hostIp, str(_randPortNum),"Message"],\
                            stdout=subprocess.PIPE)
            time.sleep(10)
            
            _regex="Granted permission to "+self.app_path_client+" for  creating a TCP connection to "+self.hostIp
            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",_regex) != True:
                logging.error("TCP connection not granted for port other than given single port")
                return 1
            
        #needs to verify AppProt trace file for rule match
        except:
            logging.debug("Failed to launch application  ")
            return 1

        logging.info("Network access granted properly for port other than given single port")

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
        #Disable Trace value
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
