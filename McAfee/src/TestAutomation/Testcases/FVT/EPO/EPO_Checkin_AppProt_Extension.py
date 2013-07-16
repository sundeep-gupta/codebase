#!/usr/bin/python

# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID001
# TestcaseDescription:  Sample description

import sys
import logging
import os

# Add common folder into the sys path for module importing
_script_path = os.path.abspath(os.path.dirname(sys.argv[0]))
_common_path = _script_path + '/../Common'
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
        self.ext_name = 'APROTMAC1000'
        logging.debug("Creating ePolicyOrchestrator object")
        self.epo = ePolicyOrchestrator(self._config['ip'], self._config['username'], self._config['password'])
        
        logging.debug("Checking if extension is already installed and removing it.")
        if self.epo.checkExtensionExists(self.ext_name) :
            self.epo.uninstallExtension(self.ext_name)
        # Now get the path where the extension to be installed is sitting.
        self.ext_path = 'file:///' + os.path.abspath(ext_path)
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        logging.debug('Installing the extension %s '% self.ext_name)
        self.epo.installExtension(self.ext_path)
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        if self.epo.checkExtensionExists(self.ext_name) :
            logging.debug("Successfully installed the extension")
            return 0
        logging.debug("Failed to install the extension")
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
    if len(sys.argv) < 3 :
        logging.error("Need the path of extension to install. Could not continue")
        retVal = 1
    else :
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


