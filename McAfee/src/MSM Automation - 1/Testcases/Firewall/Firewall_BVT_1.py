#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 18038
# TestcaseDescription:  This TC to verify default rules set for firewall

import sys
import logging
import re
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
        logging.info("TestcaseID : 18038")
        logging.info("Description : This TC to verify default rules set for firewall")

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
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # Step 0: Verify the default fw rule is present
        if commonFns.parseFile('/usr/local/McAfee/Firewall/var/MscRules',"5002") != True:
            logging.error("Default firewall rule not found")
            return 1
        logging.info("Default firewall rule found")
        # Step 0: Verify the McAfee Server are present in 
        trustedGroups=CommonFWFns.getTrustedGroups()
        for tg in trustedGroups:
            if tg["GroupName"] == "McAfee Servers":
                logging.debug("We found our mcafee servers in the trusted group")
                return 0

        logging.error("We did not find McAfee Servers in the the trusted group")
        return 1

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
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
