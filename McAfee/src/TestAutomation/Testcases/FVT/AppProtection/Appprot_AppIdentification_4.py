#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16367
# TestcaseDescription: Collecting dependant library list for the application added to the AppPro rule list.

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
    _application = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/TwoSharedLibs" 
    _depLib1 = "/usr/local/lib/libSample1.dylib"
    _depLib2 = "/usr/local/lib/libSample2.dylib"
    _traceLog = "/usr/local/McAfee/AppProtection/var/appProt.trace"
    _traceFile = "/usr/local/McAfee/AppProtection/var/traceValues.xml"
    _apttDir = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt"

    def __init__(self):
        logging.info("TestcaseID : ID16367")
        logging.info("Description : Collecting dependant library list for the application added to the AppPro rule list.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
                return _retval
        # Removing 'traceLog'.
        os.remove(self._traceLog)
        if not os.path.exists("/usr/local/lib"):
            os.makedirs("/usr/local/lib")

        # Install AppProt test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        # Creating backup copy of the application1, which needs to be modified for the test.
        CommonAppProFns.resetAppProtToDefaults()
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        
        # Enabling trace log.
        commonFns.setXMLValueinFile(self._traceFile, "tracer", 1)
        commonFns.setXMLValueinFile(self._traceFile, "appStoreFlow", 1)
        commonFns.setXMLValueinFile(self._traceFile, "depStoreFlow", 1)

        logging.info("Reloading the application protection.")

        _retVal = subprocess.call(['/bin/sh', '-c', '/usr/local/McAfee/AppProtection/bin/AppProtControl reload'])
        
        if _retVal != 0:
            logging.error("Failed to reload Application protection.")
            return 1

        # Adding rule for application to deny its execution.
        _rule = dict()
        _rule["AppPath"] = self._application;
        _rule["ExecAllowed"] = '1'
        _rule["Enabled"] = '1'
        _rule["NwAction"] = '1'

        _retVal = CommonAppProFns.addAppProtRule(_rule)

        if _retVal != CommonAppProFns.SUCCESS:
            logging.error("Adding rule for application failed.")
            return 1
        logging.info("Rule added successfully for application.")

        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        
        regex1 = "DependentStore::addAppToDependent - Entered for app = " + self._depLib1 + " , dep =" + self._application
        regex2 = "DependentStore::addAppToDependent - Entered for app = " + self._depLib2 + " , dep =" + self._application

        if commonFns.parseFile(self._traceLog, regex1) == True and commonFns.parseFile(self._traceLog, regex2) == True:
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
        commonFns.setXMLValueinFile(self._traceFile, "appStoreFlow", 0)
        commonFns.setXMLValueinFile(self._traceFile, "depStoreFlow", 0)
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
