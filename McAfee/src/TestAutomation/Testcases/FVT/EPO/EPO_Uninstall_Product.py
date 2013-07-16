#!/usr/bin/python

# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID001
# TestcaseDescription:  Sample description

import sys
import logging
import os
import time
# Add common folder into the sys path for module importing
_script_path = os.path.abspath(os.path.dirname(sys.argv[0]))
_common_path = _script_path + '/../FVT/Common'
sys.path.append(_common_path)
sys.path.append(_script_path)
import commonFns
import ePOCommonFns

# Import ePolicyOrchestrator class in current namespace
from ePOCommonFns import ePolicyOrchestrator
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = os.path.basename(sys.argv[0][:-3])

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : ID001")
        logging.info("Description : Sample description")

    def init(self, ext_path):
        logging.info("Initializing testcase %s" % testcaseName)
        
        # Using the existing api.
        logging.debug('Reading the ePO details from config file')
        self._config_file = _common_path + '/mountConfig.xml'
        if not os.path.exists(self._config_file) :
            logging.error("Config file is missing. Could not continue.")
            return 1

        self._config = commonFns.getMountVolumeDetails(self._config_file, 'epo')
        
        logging.debug("Creating ePolicyOrchestrator object")
        self.epo = ePolicyOrchestrator(self._config['ip'], self._config['username'], self._config['password'])

        if not commonFns.isProductInstalled() :
            logging.debug("Product does not exist in the machine. Could not proceed further")
            return 1
        
        logging.debug("Checking if the package is already checked in the epo")
        if not self.epo.isProductCheckedIn(self.prod_name) :
            logging.error("Product is not checked in into ePO. Could not continue")
            return 1

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        logging.debug("Installing product %s version %s" %(self.prod_name, self.version))
        # This will create the task, and also send the wakeup agent.
        self.epo.uninstallProduct(self.prod_name, self.version)
        # Lets wait for 300 seconds for product to get installed.
        for t in range(0, 300, 5) :
            time.sleep(5)
            if not commonFns.isProductInstalled() :
                logging.debug('Product got Uninstalled')
                break
        else :
            logging.error("Product still exists after 300 seconds")
            return 1
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)

        logging.debug('Checking if product is installed')
        if not commonFns.isProductInstalled() :
            logging.debug('Product is uninstalled successfully')
            return 0
        logging.debug('Product still exists')
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
    retVal = testObj.init(sys.argv[2])

    # Perform execute once initialization succeeds...    
    if(retVal == 0):
        retVal = testObj.execute()

    # Once execution succeeds, perform verification...
    if(retVal == 0):
        retVal = testObj.verify()

    # Perform testcase cleanup
    retVal = retVal + testObj.cleanup()

    if(retVal == 0):
        resultString = "PASS"
    else:
        resultString = "FAIL"
        
    logging.info("Result of testcase %s: %s" % (testcaseName, resultString) )
    sys.exit(retVal)


