# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
#!/usr/bin/python
# TestcaseID: 32942
# TestcaseDescription:  Uninstall the product

import sys
import os
import logging
import subprocess
import commonFns
# Add common folder into the sys path for module importing
sys.path.append("../Common")

# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 32942")
        logging.info("Description : Uninstall the product")
        commonFns.cleanLogs()

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        if commonFns.isProductInstalled() == False:
            logging.error("Product is not installed")
            return 1
        
        if os.getuid() != 0:
            logging.error("The script should be invoked as root")
            return 1
        return 0

    def execute(self):
        subprocess.call( [ "/usr/local/McAfee/uninstallMSC" ])
        logging.info("Executing testcase %s" % testcaseName)
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        if os.path.exists("/usr/local/McAfee") == True:
            logging.error("Product root directory still exists")
            return 1
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)

        # If Bullseye coverage env file exists, we need to remove it since
        # the build just got uninstalled...
        coverageEnvFile = "/private/etc/BullseyeCoverageEnv.txt"
        if os.path.exists(coverageEnvFile):
            retVal = subprocess.call(["rm","-f",coverageEnvFile])
            if retVal != 0:
                logging.error("Error in removing " + coverageEnvFile)
        
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
