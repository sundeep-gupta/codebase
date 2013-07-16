#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16388
# TestcaseDescription: Testcase to track file modification changes of a Whitelisted Application.

import sys
import logging
import shutil

# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
# Import CommonTest module into current namespace
from CommonTest import *
# Import common functions for Application Protection.
import CommonAppProFns
# Get testcase name
testcaseName = sys.argv[0][:-3]
# Import SubProcess module to run processes from command line.
import subprocess
import time

class TestCase(BaseTest):
    _application = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/TwoSharedLibs"
    _apttApp = os.getcwd() + "/data/aptt/appProtTestTool"
    # Library on which our application depends.
    _depLib1 = os.getcwd() + "/data/SampleApplications/libSample1.dylib"
    _depLib2 = os.getcwd() + "/data/SampleApplications/libSample2.dylib"
    # Installing the dependent libraries to be used by application.
    _instDepLib1 = "/usr/local/lib/libSample1.dylib"
    _instDepLib2 = "/usr/local/lib/libSample2.dylib"
    _apttDir = os.getcwd() + "/data/aptt"
    def __init__(self):
        logging.info("TestcaseID : ID16388")
        logging.info("Description: Testcase to track file modification changes of a Whitelisted Application.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval

        # Calculating Hash (MD5) of the application (before modification)
        self._origHashForApp = commonFns.getMD5ForFile(self._application)         

        if not os.path.exists("/usr/local/lib"):
            os.makedirs("/usr/local/lib")

        try:
            shutil.copy(self._depLib1, self._instDepLib1)
            shutil.copy(self._depLib2, self._instDepLib2)
        except:
            logging.error("Unable to copy the libraries")
            return 1

        # Install AppProt test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1

        CommonAppProFns.resetAppProtToDefaults()
        if CommonAppProFns.enableApproTrace("appStoreFlow") != True:
            logging.error("Unable to enable appPro trace.")
            return 1

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Adding 'aptt' to whitelisting.
        _exclusionList = [self._apttApp]
        _retVal = CommonAppProFns.setAppProExclusions(_exclusionList)

        if _retVal == False:
            logging.error("'apttApp' addition to whitelist failed.")
            return 1

        logging.info("'apttApp' added to whitelist successfully.")
        # Adding a rule for application.
        _rule = dict()
        _rule["AppPath"] = self._application;
        _rule["ExecAllowed"] = '1'
        _rule["Enabled"] = '1'
        _rule["NwAction"] = '1'

        _retVal = CommonAppProFns.addAppProtRule(_rule)

        if _retVal != CommonAppProFns.SUCCESS:
            logging.error("Addition of rule failed for the application.")
            return 1

        logging.info("Added rule for the application successfully.")

        logging.info("Modifying dependent lib.") 
        shutil.copy(self._depLib1, self._instDepLib2)
        time.sleep(3)
        logging.info("Restoring the dependent lib.")
        shutil.copy(self._depLib2, self._instDepLib2)
        # Calculating Hash (MD5) of the application (after modification)
        self._modiHashForApp = commonFns.getMD5ForFile(self._application)

        # Launching whitelisted Application (for verification that modified application is not corrupted.)
        _p = subprocess.Popen(["/bin/sh", "-c", self._application], stdout=subprocess.PIPE)

        if _p.returncode != 0:
            logging.error("Application launch failed.")

        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        _regex = "ApplicationStore::findAppByHash - Entered for " + self._modiHashForApp

        if commonFns.parseFile("/usr/local/McAfee/AppProtection/var/appProt.trace", _regex) == True:
            logging.info("Modified Application Hash found in log.")
            return 0
        else:
            logging.error("Modified Application Hash not found in log.")
            return 1

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        CommonAppProFns.resetAppProtToDefaults()
        CommonAppProFns.disableApproTrace("appStoreFlow")
        commonFns.cleanLogs()
        os.remove(self._instDepLib1)
        os.remove(self._instDepLib2)

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
