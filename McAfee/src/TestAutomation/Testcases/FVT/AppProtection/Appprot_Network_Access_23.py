#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16545
# TestcaseDescription: Testcase to perform a renew operation of IP Address.


import os
import sys
import logging
import subprocess
import socket
import time

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
        logging.info("TestcaseID : 16545")
        logging.info("Testcase to perform a renew operation of IP Address")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        return 0
    
    def getIP(self):
        _cmdIP = "ifconfig | grep 'broadcast' | awk '{print $2}' | head -1"
        _p = subprocess.Popen(['/bin/sh', '-c', _cmdIP], stdout=subprocess.PIPE)
        _p.wait()
        # Do not parse output if command failed.
        if _p.returncode != 0 :
            logging.error("Not able to get IP address from system")
            return 1

        return _p.stdout.read()

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

        if(self.getIP() != 1):
            logging.info("The system IP address is: %s" % self.getIP())   
        else:
            logging.error("Not able to get IP address of the system.")
            return 1

        _cmd = "ipconfig set en0 BOOTP; ipconfig set en0 DHCP"
        _retVal = subprocess.call(['/bin/sh', '-c', _cmd])        

        time.sleep(10)

        if _retVal != 0:
            logging.error("Not able to renew IP through DHCP lease.")
            return 1

        if(self.getIP() != 1):
            logging.info("The 'Renewed' system IP address is: %s" % self.getIP())
        else:
            logging.error("Not able to get IP address of the system.")
            return 1

        return 0

    def verify(self):
        # Checking for the outgoing connection of TCPUDPClinet.

        return 0

        

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        logging.debug("Resetting the application protection to defaults")
        CommonAppProFns.resetAppProtToDefaults()
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
