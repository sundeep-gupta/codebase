#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 18041
# TestcaseDescription:  This TC is to verify whether entries can be added to trusted list of firewall

import sys
import logging
import subprocess
# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
import CommonFWFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 18041")
        logging.info("Description : This TC is to verify whether entries can be added to trusted list of firewall")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        # Step 0 : Install FWTT
        if CommonFWFns.installFirewallTestTool() != True:
            logging.error("Unable to install firewall testtool")
            return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Step 0: Set FW prrefs to custom rules
        if CommonFWFns.enableCustomRules() != True:
            logging.error("Could not set fw prefs to custom")
            return 1
        logging.debug("Set the firewall prefs to custom")

        # Step 1:  Add trusted list
        trusted_list = dict()
        ips=[]
        ips.append("192.168.215.127")
        trusted_list["GroupName"] = "my_group"
        trusted_list["Hosts"]=ips

        if CommonFWFns.addTrustedList(trusted_list) != True:
            logging.error("Unable to add trusted list")
            return 1
        logging.debug("Added a trusted list entry")
        # Step 2: Add deny ping rule
        if CommonFWFns.addFWRuleWithoutPorts("ping",2,3,1,"me","any") != True:
            logging.error("Could not set deny outgoing ping rule")
            return 1
        logging.debug("Set the deny outgoing ping rule")
        
        # Step 3: Run ping
        rc = subprocess.call( ["ping","-c","1","192.168.215.127"],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        if rc != 0:
            logging.error("Ping to 192.168.215.127 failed")
            return 1
        logging.debug("Ping succeeded.")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Step 0 : Set FW Prefs to allow all
        CommonFWFns.disableCustomRules()
        # Step 1 : Delete the outgoing ping rule
        CommonFWFns.deleteFWRule("ping")
        # Step 2 : Delete trusted list entry
        CommonFWFns.deleteTrustedList("my_group")
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
