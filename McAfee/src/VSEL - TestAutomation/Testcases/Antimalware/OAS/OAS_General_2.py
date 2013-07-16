#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID001
# TestcaseDescription:  Sample description

import sys
import logging
import zipfile
import shutil
import os

# Add common folder into the sys path for module importing
sys.path.append("../../Common")
sys.path.append("../")
import commonFns
import commonAntiMalwareFns
import commonOASFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]
testcaseDir = os.path.dirname(os.path.abspath(sys.argv[0]))
class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : lsh-223")
        logging.info("Description : To verify that OAS is stopping the unarchiving of an eicar sample.zip ")
        self._data_dir = testcaseDir + '/data/lsh-223'
        self._eicar_file = self._data_dir + '/eicar.txt'
        self._zip_file = self._data_dir + '/eicar.zip'

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        logging.debug("Resetting VSEL to default settings")
        if not self._cleanup() :
            logging.error("Failed to perform initialization tasks.")
        if not commonOASFns.disableOASArchiveScanning() :
            logging.error("Failed to disable OAS archive scanning")
            return 1
        if not commonOASFns.disableOAS() :
            logging.error("Failed to disable OAS")
            return 1
        if not os.path.isdir(self._data_dir) :
            os.mkdir(self._data_dir)
        if not commonAntiMalwareFns.createEicarInfection(self._eicar_file) :
            logging.error("Failed to create eicar infection file")
            return 1
        zf = zipfile.ZipFile(self._zip_file, 'w')
        zf.write(self._eicar_file)
        zf.close()
        if not os.path.exists(self._zip_file) :
            logging.error('Failed to create zip file.')
            return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        zf = zipfile.ZipFile(self._zip_file, 'r')
        for n in zf.namelist() :
            print n
            file(self._data_dir + '/extract_eicar.txt', 'wb').write(zip.read(self._eicar_file))
        zf.close()
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        if os.path.exists(self._data_dir + '/extract_eicar.txt') :
            logging.error("File extracted, which should not have been done!")
            return 1
        if not commonAntiMalwareFns.isFileQuarantined(self._data_dir+ '/extract_eicar.txt') :
            logging.error("File is not quarantined.")
            return 1
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        foundCrash += self._cleanup()
        commonFns.cleanLogs()
        
        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")

        return foundCrash
    def _cleanup(self):
        logging.debug("Resetting to defaults")
        _retval = 0
        if not commonAntiMalwareFns.resetToDefaults() :
            logging.error('Failed to reset to defaults')
            _retval = 1
        if os.path.exists(self._data_dir) :
            logging.debug("Removing the directory ; " + self._data_dir)
            shutil.rmtree(self._data_dir)
        return _retval
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
    retVal = retVal + testObj.cleanup()

    if(retVal == 0):
        resultString = "PASS"
    else:
        resultString = "FAIL"
        
    logging.info("Result of testcase %s: %s" % (testcaseName, resultString) )
    sys.exit(retVal)
