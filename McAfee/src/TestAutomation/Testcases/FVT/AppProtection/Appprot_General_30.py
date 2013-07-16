#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16502
# TestcaseDescription:  Verify that Verify application honors  rule for an application whose name length is as long as allowed by the OS

import sys
import stat
import os
import logging
import subprocess
import shutil
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
        logging.info("TestcaseID : 16502")
        logging.info("Description : Verify that Verify application honors  rule for an application whose name length is as long as allowed by the OS")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Step 0 : Install APTT
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Installation of AppPro Test Tool failed.")
            return 1
        
        # Step 1 : reset apppro
        CommonAppProFns.resetAppProtToDefaults()

        if CommonAppProFns.enableApproTrace("reportMgrFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        self._folderName=""
        for l in range(1,511): 
            self._folderName=self._folderName + "/1"
        # Step 0 : Delete the folder if it already exists
        try:
            shutil.rmtree(self._folderName)
        except:
            pass
        
        # Step 1 : Create a folder with max possible length, typically 1024 chars. We will keep last 2 chars for binary name
        try:
            if os.makedirs(self._folderName) == False:
                logging.error("Could not create folder %s" % self._folderName)
                return 1
        except:
            logging.error("Exception: Could not create folder %s" % self._folderName)
            return 1
        logging.debug("Created folder %s" % self._folderName)
        
        # Step 2 : Copy any app into the new floder
        self._sourceBinary=os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/TCPClient"
        self._destinationBinary =  self._folderName + "/b"
        try:
            if shutil.copyfile(self._sourceBinary, self._destinationBinary) == False:
                logging.error("Could not copy %s to %s" % (self._sourceBinary, self._destinationBinary))
                return 1
        except:
                logging.error("Exception:Could not copy %s to %s" % (self._sourceBinary, self._destinationBinary))
                return 1
        logging.debug("Copied %s to %s" % (self._sourceBinary, self._destinationBinary))

        # Step 3 : Provie execute permissions
        try:
            os.chmod(self._destinationBinary, stat.S_IEXEC)
        except:
            logging.error("Unable to provide execute permissions to %s " % self._destinationBinary)
            return 1
        logging.debug("Provided execute permissions to %s " % self._destinationBinary)

        # Step 4 : Add a deny rule for the app in the new folder
        self._rule = dict()
        self._rule["AppPath"]= self._destinationBinary
        self._rule["ExecAllowed"]="0"
        self._rule["Enabled"]="1"
        self._rule["NwAction"]="1"
        _retval = CommonAppProFns.addAppProtRule(self._rule)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule failed with code %d" % _retval)
            return 1
        logging.debug("Added rule for %s " % self._destinationBinary)
        
        # Step 5 : Launch the app
        try:
            _retval  =subprocess.call( [ self._destinationBinary ],
                                         stdout=subprocess.PIPE,
                                         stderr=subprocess.PIPE)
            logging.error("%s process was allowed to execute inspite of deny rule" % self._destinationBinary)
            return 1
        except:
            logging.info("%s process was denied execution as per rule" % self._destinationBinary)
        time.sleep(3)   
        logging.info("Execution went through fine")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # Step 0 : Verify that the app got blocked by looking at product log
        _pattern = "Denied " + self._destinationBinary +\
                    " from executing because  of profile rule match with " + self._destinationBinary
        logging.debug(" Looking for the pattern %s in product log" % _pattern)
        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _pattern) != True:
            logging.error("Expected error message not found in the product log")
            return 1

        logging.info("Expected error message found in the logs")
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Step 0 : Reset App Pro
        CommonAppProFns.disableApproTrace("reportMgrFlow")
        CommonAppProFns.resetAppProtToDefaults()
        # Step 1 : Remove the new folder
        try:
           shutil.rmtree(self._folderName)
        except:
           pass
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
