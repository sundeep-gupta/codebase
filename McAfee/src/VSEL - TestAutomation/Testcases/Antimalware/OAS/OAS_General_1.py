#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 829
# TestcaseDescription : Rename engine libraries.

import sys
import logging
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
class TestCase(BaseTest):

    def __init__(self):
        logging.info("TestcaseID : 829")
        logging.info("Rename engine libraries.")
        self._engine_lib_path     = self.getConfig('ENGINE_LIB_PATH')

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)

        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        if not os.path.islink(self._engine_lib_path) :
            logging.error("Engine lib file %s must be a link" % self._engine_lib_path)
            return 1
        self._engine_lib_realpath = os.path.realpath(self._engine_lib_path)
        if (not os.path.exists(self._engine_lib_realpath)) :
            logging.error("Real file of engine lib, %s, does not exist" % self._engine_lib_realpath)

        if not commonAntiMalwareFns.resetToDefaults() :
            logging.error("Failed to reset to defaults")
            _retval = 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        logging.debug("Disabling OAS")
        if not commonOASFns.disableOAS() :
            logging.error("Failed to disable OAS")
        logging.debug("Renaming the engine lib file")
        os.rename(self._engine_lib_realpath, self._engine_lib_realpath + '.RENAMED')
        logging.debug("Enabling OAS after renaming file")
        if commonOASFns.enableOAS() :
            logging.error("OAS enabled, which should have not.")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        foundCrash = foundCrash + self._cleanup()
        commonFns.cleanLogs()
         
        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")
            
        return foundCrash
          
    def _cleanup(self) :
        _retval = 0        
        if os.path.exists(self._engine_lib_realpath + '.RENAMED') :
            logging.debug("Moving renamed file back to original file")
            os.rename(self._engine_lib_realpath + '.RENAMED', self._engine_lib_realpath)
            if not os.path.exists(self._engine_lib_realpath) :
                logging.error("Failed to revert the renamed file to engine lib file")
                _retval = 1
        if not commonAntiMalwareFns.resetToDefaults() :
            logging.error("Failed to reset to defaults")
            _retval = 1

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
