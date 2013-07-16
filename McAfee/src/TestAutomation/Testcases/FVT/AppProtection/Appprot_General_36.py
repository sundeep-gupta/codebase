#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 16508
# TestcaseDescription:  Verify that exclusions are path dependent [same application from different paths must be allowed to

import sys
import logging
import stat
import subprocess
import os
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
        logging.info("TestcaseID : 16508")
        logging.info("Description : Verify that exclusions are path dependent [same application from different paths must be allowed to")

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

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Step 0 : Create Two folders 
        self._folder1="/private/tmp/folder_1"
        self._folder2="/private/tmp/folder_2"
        try:
            shutil.rmtree(self._folder1)
        except:
            pass
        try:
            shutil.rmtree(self._folder2)
        except:
            pass

        try:
            os.mkdir(self._folder1)
        except:
            logging.error("Could not create %s" % self._folder1)
            return 1
        try:
            os.mkdir(self._folder2)
        except:
            logging.error("Could not create %s" % self._folder2)
            return 1

        # Step 1 : Copy TCPClient into both the folders.
        self._srcBinary=os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/TCPClient"
        self._destBinary1=self._folder1 + "/TCPClient"
        self._destBinary2=self._folder2 + "/TCPClient"
        try:
            shutil.copyfile(self._srcBinary,self._destBinary1)
            os.chmod(self._destBinary1, stat.S_IEXEC)
        except:
            logging.error("Copying of %s to %s failed" % (self._srcBinary,self._destBinary1))
            return 1
        try:
            shutil.copyfile(self._srcBinary,self._destBinary2)
            os.chmod(self._destBinary2, stat.S_IEXEC)
        except:
            logging.error("Copying of %s to %s failed" % (self._srcBinary,self._destBinary2))
            return 1
        logging.debug("Folders and binaries in the folders are ready")

        # Step 2 : Add deny rule for folder 1 TCPClient
        self._rule = dict()
        self._rule["AppPath"]= self._destBinary1
        self._rule["ExecAllowed"]="0"
        self._rule["Enabled"]="1"
        self._rule["NwAction"]="1"
        _retval = CommonAppProFns.addAppProtRule(self._rule)
        if _retval != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule failed with code %d" % _retval)
            return 1
        logging.debug("Added rule for %s " % self._destBinary1)
        
        # Step 3 : Add exclusion
        if CommonAppProFns.setAppProExclusions( [ self._folder2 ]) == False:
            logging.error("Exclusion set failed for %s" % self._folder2)
            return 1
        logging.debug("Setting of exclusions succeeded")

        # Step 4 : Launch TCPClient from folder 1
        try:
            _retval  =subprocess.call( [ self._destBinary1 ],
                                         stdout=subprocess.PIPE,
                                         stderr=subprocess.PIPE)
            logging.error("%s process was allowed to execute inspite of deny rule" % self._destBinary1)
            return 1
        except:
            logging.info("%s process was denied execution as per rule" % self._destBinary1)
        time.sleep(3)   
        logging.info("Execution went through fine")
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # Step 0 : Verify that TCPClient got blocked from product log
        _pattern = "Denied " + self._destBinary1 +\
                    " from executing because  of profile rule match with " + self._destBinary1
        logging.debug(" Looking for the pattern %s in product log" % _pattern)
        if commonFns.searchProductLog(_pattern) != True:
            logging.error("Expected error message not found in the product log")
            return 1
        logging.info("Expected error message found in the logs")

        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Step 0 : Remove the folders
        try:
            shutil.rmtree(self._folder1)
        except:
            pass
        try:
            shutil.rmtree(self._folder2)
        except:
            pass

        # Step 1 : reset app protection
        CommonAppProFns.resetAppProtToDefaults()

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
