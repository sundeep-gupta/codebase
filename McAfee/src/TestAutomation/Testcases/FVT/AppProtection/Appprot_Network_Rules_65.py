#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16647
# TestcaseDescription: Set Restricted Network Access for application: Scenario 65

import sys
import logging
import subprocess
import time
import os

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")


import commonFns
# Import CommonTest module into current namespace
from CommonTest import *
import CommonAppProFns
# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 16647")
        logging.info("Description : Set Restricted Network Access for application: Scenario 65")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Create all variables here
        self._init_variables()

        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1

        self._cleanup()

        # start the tcp servers
        if self._start_tcp_server() == 1 :
            return 1

        logging.debug("Enabling Application protection traces for %s " % self.trace_var)
        if CommonAppProFns.enableApproTrace(self.trace_var) != True:
            logging.error("Failed to enable trace for %s" % self.trace_var)
            return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Add rule to deny application execution
        logging.debug("Add rule to deny application execution")
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS :
            logging.error("Failed to set deny rule for %s" % self.rule["AppPath"])
            return 1
        try :
            logging.debug("Checking the outgoing deny with port %s" % self.server_port_1)
            subprocess.call(self.cmd_port_1, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        except :
            logging.error("TCP client failed to run!")
            return 1
        
        # Because we denied TCP, UDP should be allowed as per rule
        try :
            logging.debug("Checking the outgoing allow with port %s for UDP" % self.udp_port_1)
            subprocess.call(self.cmd_udp_1, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        except :
            logging.error("UDP client failed to run!")
            return 1

        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        time.sleep(10)
        
        # Outside of range it must be allowed.
        logging.debug("Checking TCP Deny: %s" % self.regex_deny_tcp)
        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",self.regex_deny_tcp) != True:
            logging.error("Failed to match : %s" % self.regex_deny_tcp)
            return 1

        logging.debug("Checking UDP Allow : %s" % self.regex_allow_udp)
        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace",self.regex_allow_udp) != True:
            logging.error("Failed to match : %s" % self.regex_allow_udp)
            return 1
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)

        logging.debug("Disabling Application protection traces for %s " % self.trace_var)
        if CommonAppProFns.disableApproTrace(self.trace_var) != True :
            logging.error("Failed to disable trace for %s" % self.trace_var)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        self._cleanup()
        commonFns.cleanLogs()

        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")

        return foundCrash

    def _cleanup(self):

        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()

        # If process present, then kill
        if commonFns.isProcessRunning(self.app_path) == True :
            try :
                logging.debug("%s is already running. Killing it!" % self.process)
                subprocess.call(["killall", "-SIGTERM", self.process], stdout=subprocess.PIPE)
            except :
                logging.error("Failed to kill the process")

        if commonFns.isProcessRunning(self.tcp_server) == True :
            try :
                logging.debug("%s is already running. Killing it!" % self.tcp_server)
                subprocess.call(["killall", "-SIGTERM", self.tcp_server], stdout=subprocess.PIPE)
            except :
                logging.error("Failed to kill the process")
        return 0

    def _init_variables(self):
        self.pwd = os.path.dirname(os.path.abspath(sys.argv[0]))
        self.tcp_server_path = self.pwd + "/data/SampleApplications/TCPServer"
        self.server_port_1 = "5075"
        self.udp_port_1    = "5050"

        self.tcp_server = "TCPServer"
        self.trace_var = "reportMgrFlow"
        self.host_ip  = "127.0.0.1"
        self.prot     = "TCP"
        self.prot_udp = "UDP"
        self.app_path = self.pwd + "/data/SampleApplications/TCPUDPClient"
        self.process  = "TCPUDPClient"
        self.cmd_port_1  = [self.app_path, self.prot, self.host_ip, self.server_port_1, "Test Message"]
        self.cmd_udp_1  = [self.app_path, self.prot_udp, self.host_ip, self.udp_port_1, "Test Message"]


        self.rule     = {
                "AppPath"     : self.app_path,
                "Enabled"     : "1",
                "ExecAllowed" : "1",
                "NwAction"    : "3",
                "CustomRules" : [
                     # Add rule to DENY outoging for BOTH[TCP and UDP] connection
                     {
                        'IP'       : "ANY_IP",
                        'Port'     : "ANY_PORT",
                        'Protocol' : '1', # TCP
                        'Direction': '2', # OUTGOING
                        'Action'   : '2'  # DENY
                     },
                     # For DENY We need to add another rule for ALLOW
                     {
                        'IP'       : "ANY_IP",
                        'Port'     : "ANY_PORT",
                        'Protocol' : '3', # ANY
                        'Direction': '3', # ANY
                        'Action'   : '1'  # ALLOW
                     },
                ]
        }

        self.regex_deny_tcp = "Denied %s from creating a %s connection to %s:%s because  of profile rule match with %s" % (self.app_path, self.prot, self.host_ip, self.server_port_1, self.app_path)
        self.regex_allow_udp = "Granted permission to %s for  creating a %s connection to %s:%s because  of profile rule match with %s" % (self.app_path, self.prot_udp, self.host_ip, self.udp_port_1, self.app_path)

    def _start_tcp_server(self):

        logging.debug("Start the TCP Server at port : %s")
        if subprocess.Popen([self.tcp_server_path, self.host_ip, self.server_port_1],
                stdout=subprocess.PIPE) is None :
            logging.error("Failed to start TCP Server at port %s" % self.server_port_1)
            return 1


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
