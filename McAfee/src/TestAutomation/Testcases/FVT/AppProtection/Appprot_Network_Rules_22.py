#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16604
# TestcaseDescription: Set Restricted Network Access for application: Scenario 22


import os
import sys
import logging
import time
import subprocess
import threading
import socket
import random

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
        logging.info("TestcaseID : 16604")
        logging.info("Set Restricted Network Access for application: Scenario 22.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Define variables.
        self.hostIp=socket.gethostbyname(socket.gethostname())
        self.subnetAddr=socket.gethostbyname(socket.gethostname())+"/24"
        self.app_path =  os.path.dirname(os.path.abspath(sys.argv[0]))\
                + "/data/SampleApplications/UDPClient"

        self.port="5000"

        self.customRule=[]
        _cr = dict()
        _cr = {"IP":self.subnetAddr,"Port":self.port,"Protocol":"3",
                            "Direction":"3","Action":"2"}
        self.customRule.append(_cr)

        # Add allow-all-remaining sub-rule
        _cr1 = dict()
        _cr1 = {"IP":"ANY_IP","Port":"ANY_PORT","Protocol":"3",
                            "Direction":"3","Action":"1"}
        self.customRule.append(_cr1)

        
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

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule")
            return 1

        #enable trace
        if CommonAppProFns.enableApproTrace("reportMgrFlow")!=True:
            return 1

        return 0

    def verify(self):

        try :
            logging.debug("Launching %s" % self.app_path)
            subprocess.call([self.app_path, self.hostIp, self.port,"Message"],\
                            stdout=subprocess.PIPE)
            time.sleep(10)
            
            _regex="Denied "+self.app_path+" from creating a UDP connection to "+ self.hostIp
            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",_regex) != True:
                logging.error("UDP connection not denied for the given single port")
                return 1
            
        #needs to verify AppProt trace file for rule match
        except:
            logging.error("Failed to launch application ")
            return 1
        logging.info("Subnet Network action is denied")
        
        try :
            logging.debug("Launching %s" % self.app_path)

            # Mark port number other than given single input port
            _randPortNum = int(self.port) + random.randint(1,1000)
            subprocess.call([self.app_path, self.hostIp, str(_randPortNum),"Message"],\
                            stdout=subprocess.PIPE)
            time.sleep(10)
            
            _regex="Granted permission to "+self.app_path+" for  creating a UDP connection to "+self.hostIp
            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",_regex) != True:
                logging.error("UDP connection not granted for port other than single given port")
                return 1
            
        #needs to verify AppProt trace file for rule match
        except:
            logging.debug("Failed to launch application  ")
            return 1

        logging.info("Network access granted properly for port other than the single port")

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
