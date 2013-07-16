#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16608
# TestcaseDescription: Set Restricted Network Access for application: Scenario 26

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
        logging.info("TestcaseID : 16608")
        logging.info("Set Restricted Network Access for application: Scenario 26.")

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
        self.process= "TCPServer"

        self.port_range_min=5000
        self.port_range_max=5100

        self.customRule=[]
        _portRangeStr=str(self.port_range_min)+"-"+str(self.port_range_max)
        _cr = dict()
        _cr = {"IP":self.hostIp,"Port":_portRangeStr,"Protocol":"1",
                            "Direction":"3","Action":"1"}
        self.customRule.append(_cr)
        self.rule = {"AppPath" : self.app_path_client, "Enabled" : "1",
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

        self.randPortNumStr = str(random.randint(self.port_range_min, self.port_range_max))     
        _cmd =  self.app_path_server +" "+self.hostIp+" "+ self.randPortNumStr
        process=subprocess.Popen(_cmd,shell=True, stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE)
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS:
            logging.error("Failed to add Rule")
            return 1
        
        if CommonAppProFns.enableApproTrace("reportMgrFlow")!=True:
            return 1
        
        return 0

    def verify(self):

        try :
            logging.debug("Launching %s" % self.app_path_client)

            subprocess.call([self.app_path_client, self.hostIp, self.randPortNumStr,"Message"],\
                            stdout=subprocess.PIPE)
            time.sleep(10)
            
            _regex="Granted permission to "+self.app_path_client+" for  creating a TCP connection to "+self.hostIp
            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",_regex) != True:
                logging.error("TCP connection not granted for port in the port range")
                return 1
            
        #needs to verify AppProt trace file for rule match
        except:
            logging.debug("Failed to launch application  ")
            return 1

        logging.info("Network access successful for port in the port range")
        
        try :
            logging.debug("Launching %s" % self.app_path_client)

            # Mark port number outside the port range
            _randPortNum = self.port_range_max + random.randint(0,1000)
            subprocess.call([self.app_path_client, self.hostIp, str(_randPortNum),"Message"],\
                            stdout=subprocess.PIPE)
            time.sleep(10)
            
            _regex="Denied "+self.app_path_client+" from creating a TCP connection to "+self.hostIp
            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",_regex) != True:
                logging.error("TCP connection not denied for port outside the port range")
                return 1
            
        #needs to verify AppProt trace file for rule match
        except:
            logging.debug("Failed to launch application  ")
            return 1

        logging.info("Network access denied properly for port outside the port range")

        try :
            logging.debug("Launching %s" % self.app_path_client)

            # Get all byte numbers into the list
            _ipNumsList = self.hostIp.split('.')

            # Get the last IP byte number as integer
            _lastIpByteNum = int(_ipNumsList[3])

            # Increment the last IP byte number
            _lastIpByteNum = (_lastIpByteNum + 1) % 256

            # Generate the complete IP address
            _finalIp = _ipNumsList[0]
            _finalIp = _finalIp + "." + _ipNumsList[1]
            _finalIp = _finalIp + "." + _ipNumsList[2]
            _finalIp = _finalIp + "." + str(_lastIpByteNum)
            
            subprocess.call([self.app_path_client, _finalIp, self.randPortNumStr,"Message"],\
                            stdout=subprocess.PIPE)
            time.sleep(10)
            
            _regex="Denied "+self.app_path_client+" from creating a TCP connection to "+self.hostIp
            if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",_regex) != True:
                logging.error("TCP connection not denied for IP address outside the IP input values")
                return 1
            
        #needs to verify AppProt trace file for rule match
        except:
            logging.debug("Failed to launch application  ")
            return 1

        logging.info("Network access denied properly for IP address outside the IP input values")
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
