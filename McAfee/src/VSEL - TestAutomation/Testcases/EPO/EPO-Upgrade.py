#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID-123
# TestcaseDescription: Product Upgrade from EPO

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
from commonAntiMalwareFns import VALID_VSEL_KEYS
from commonAntiMalwareFns import VSEL_ID_VERSION_MAP
# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : ID-123")
        logging.info("Description : Product upgrade from Epo")
    
    def init(self, version):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check

        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        # Get current version and save.
        productVersion = commonAntiMalwareFns.getProductInfo()
        self._current_version = productVersion['version']
        logging.debug("Currently installed version is %s " % self._current_version)

	logging.debug("Deleting any existing tasks in the epo")
        if not commonEpoFns.EPODeleteAllTasks(gethostname()):
            logging.error("Not able to delete the task")
            return 1

        logging.info("All tasks deleted")
        self._vsel_prod_id = version
        self._version    = VSEL_ID_VERSION_MAP[version]['VSEL_VERSION']
        self._ma_version = VSEL_ID_VERSION_MAP[version]['MA_VERSION']
        self._ma_prod_id = VSEL_ID_VERSION_MAP[version]['MA_PROD_ID']
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        
        # First we create MA upgrade task and then VSEL upgrade.
        # TODO : Check the prod id and version are correct for all cases. 
        # TODO : Check if we need to wait till 'Mue_InUse' completes in MA case also"
        logging.debug("Upgrading MA")
        if commonEpoFns.installProduct(self._ma_prod_id, self._ma_version) != 0:
            logging.error("Failed to install product with ID : %s and version %s" % (self._vsel_prod_id, self._version))
            return 1
        logging.debug("Upgrading %s to %s" % (self._vesl_prod_id, self._version))
        if commonEpoFns.installProduct(self._vsel_prod_id, self._version) != 0:
            logging.error("Failed to install product with ID: %s and version : %s" % (self._vsel_prod_id, self._version))
            return 1
        # We need to wait till update finishes
        logging.debug("This is LYNXSHLD installation")
        logging.debug("Sleeping for 90 seconds, to let services come up.")
        time.sleep(90)
        while True :
            if commonAntiMalwareFns.areAllServicesRunning():
                break
        logging.debug("Waiting for update to complete, by checking 'Mue_InUse' process")
        self.datVersion = commonAntiMalwareFns.GetDatVersion()
        logging.debug("Current dat version is : %s " % self.datVersion)
        while True :
            output =commands.getoutput('ps -A')
            if 'Mue_InUse' not in  output:
                break
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

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        logging.debug("Performing the BOM check for verification")
        if not commonAntiMalwareFns.compareMD5(commonAntiMalwareFns.getMD5Dict()) :
            logging.error("MD5 Check failed. Upgrade will fail")
            return 1
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
    if len(sys.argv) != 3 :
        print "Invalid arguments passed"
        sys.exit(1)
    if sys.argv[2] not in VALID_VSEL_KEYS[2:] :
        print ("%s is not a valid upgrade version" % sys.argv[2])
        sys.exit(1)
    
    # Setup testcase
    setupTestcase(sys.argv)
    

    testObj = TestCase()

    # Perform testcase operations
    retVal = testObj.init(sys.argv[2])
    # Perform execute once initialization succeeds...    
    print retVal
    if(retVal == 0):
        print "Executing now"
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
