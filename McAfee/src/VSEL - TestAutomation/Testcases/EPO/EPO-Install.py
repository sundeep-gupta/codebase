#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 2271 
# TestcaseDescription: Product Deployment  from Epo 

import time
import sys
import os
from socket import gethostname
import commands
import logging
from Tasks import *

# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
sys.path.append("../Antimalware")
import commonAntiMalwareFns
import commonEpoFns

# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 2271")
        logging.info("Description : Product Deployment from Epo")
    
    def init(self, prod_id):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check

        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        self._prod_id = prod_id
        self._version = VSEL_ID_VERSION_MAP[prod_id]['VSEL_VERSION']
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
	if not commonEpoFns.EPODeleteAllTasks(gethostname()):
            logging.error("Not able to delete the task")
            return 1
        logging.info("All tasks deleted")
        if commonEpoFns.installProduct(self._prod_id, self._version) != 0 :
            logging.error("Installation failed")
            return 1

        logging.debug("Sleeping for 90 seconds to let services come up")
	time.sleep(90)
        while True :
            if commonAntiMalwareFns.areAllServicesRunning() == True:
                break
        
        self.datVersion = commonAntiMalwareFns.GetDatVersion()
        while True :
       	    output =commands.getoutput('ps -A')
       	    if 'Mue_InUse' not in  output: 
                break
        return 0
        


    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        logging.debug("Sleeping to let services start")
        time.sleep(60)
        if commonAntiMalwareFns.isProductInstalled() == False:
            logging.error("isProductInstalled Failed")
            return 1
        if commonAntiMalwareFns.areAllServicesRunning() == False:
            logging.error("areAllServicesRunning Failed")
            return 1
        self.latestdat = commonAntiMalwareFns.GetDatVersion()
        if self.latestdat < self.datVersion:
            logging.error("Update is Failed to get Latest dats")
            return 1
        logging.info("Updated with Latest dats")

        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
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
    #retVal += testObj.cleanup()

    if(retVal == 0):
        resultString = "PASS"
    else:
        resultString = "FAIL"
        
    logging.info("Result of testcase %s: %s" % (testcaseName, resultString) )
    sys.exit(retVal)
