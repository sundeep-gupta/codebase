#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16370
# TestcaseDescription: Testcase to check the Dependent store lookup for Whitelisted application.

import sys
import logging
import shutil
import os
import xml.dom.minidom
from xml.dom.minidom import parse

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")


import commonFns
# Import CommonTest module into current namespace
from CommonTest import *
# Import common functions for Application Protection.
import CommonAppProFns
# Get testcase name
testcaseName = sys.argv[0][:-3]
# Import SubProcess module to run processes from command line.
import subprocess

class TestCase(BaseTest):
    _application = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/ChildApp" 
    _traceLog = "/usr/local/McAfee/AppProtection/var/appProt.trace"
    _traceFile = "/usr/local/McAfee/AppProtection/var/traceValues.xml"
    _apttDir = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt"
    def __init__(self):
        logging.info("TestcaseID : ID16370")
        logging.info("Description : Testcase to check the Dependent store lookup for Whitelisted application.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
                return _retval
        # Creating backup copy of the application, which needs to be modified for the test.
        CommonAppProFns.resetAppProtToDefaults()
        # Removing 'traceLog'.
        os.remove(self._traceLog)
        # Install AppProt test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)

       # Add application to whitelisting.
        _exclusionList = [self._application]
        _excluRetVal = CommonAppProFns.setAppProExclusions(_exclusionList)

        if _excluRetVal == False:
            logging.error("Failed to add application to white list.")
            return 1

        logging.info("Application added to whitelist successfully.")        
        
        # Enabling trace log.
        commonFns.setXMLValueinFile(self._traceFile, "tracer", 5)
        commonFns.setXMLValueinFile(self._traceFile, "kextIfFlow", 5)

        logging.info("Reloading the application protection.")

        _retVal = subprocess.call(['/bin/sh', '-c', '/usr/local/McAfee/AppProtection/bin/AppProtControl reload'])
        
        if _retVal != 0:
            logging.error("Failed to reload Application protection.")
            return 1

        # Launching whitelisted Application.
        _retVal = subprocess.call(["/bin/sh", "-c", self._application])

        if _retVal != 0:
            logging.error("Application failed to launch.")
            return 1
        
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        
        regex = "KextInterface::getRequestsFromKext - " + self._application + " added to request queue"

        if commonFns.parseFile(self._traceLog, regex) == True:
            logging.info("Expected traces found in the logs")
            return 0
        else:
            logging.error("Expexted traces not found in logs")
            return 1

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        commonFns.setXMLValueinFile(self._traceFile, "tracer", 0)
        commonFns.setXMLValueinFile(self._traceFile, "kextIfFlow", 0)
        logging.info("Reloading to reset the application protection.")
        _retVal = subprocess.call(['/bin/sh', '-c', '/usr/local/McAfee/AppProtection/bin/AppProtControl reload'])
        if _retVal != 0:
            logging.error("Failed to reload Application protection for resetting.")

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
