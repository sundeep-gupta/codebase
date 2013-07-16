#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16376
# TestcaseDescription: Verify libraries loaded from non-standards paths using DYLD_LIBRARY_PATH environment variables are n.

import sys
import logging
import shutil
import xml.dom.minidom
from xml.dom.minidom import parse

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

class TestCase(BaseTest):
    _application = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/SampleApplications/TwoSharedLibs" 
    _curLocLib1 = os.getcwd() + "/data/SampleApplications/libSample1.dylib"
    _curLocLib2 = os.getcwd() + "/data/SampleApplications/libSample2.dylib"
    _depLib1 = "/usr/local/lib/libSample1.dylib"
    _depLib2 = "/usr/local/lib/libSample2.dylib"
    _DYLD_Lib1 = "/tmp/libSample1.dylib"
    _DYLD_Lib2 = "/tmp/libSample2.dylib"
    _traceLog = "/usr/local/McAfee/AppProtection/var/appProt.trace"
    _traceFile = "/usr/local/McAfee/AppProtection/var/traceValues.xml"
    _apttDir = os.getcwd() + "/data/aptt"
    def __init__(self):
        logging.info("TestcaseID : ID16376")
        logging.info("Description : Verify libraries loaded from non-standards paths using DYLD_LIBRARY_PATH environment variables are n.")

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
                return _retval

        # Install AppProt test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        # Creating backup copy of the application1, which needs to be modified for the test.
        CommonAppProFns.resetAppProtToDefaults()

        if not os.path.exists("/usr/local/lib"):
            os.makedirs("/usr/local/lib")
        
        shutil.copy(self._curLocLib1, self._depLib1)
        shutil.copy(self._curLocLib2, self._depLib2)
        shutil.copy(self._curLocLib1, self._DYLD_Lib1)
        shutil.copy(self._curLocLib2, self._DYLD_Lib2)
        # Removing 'traceLog'.
        os.remove(self._traceLog)

        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        
        # Enabling trace log.
        commonFns.setXMLValueinFile(self._traceFile, "tracer", 5)
        commonFns.setXMLValueinFile(self._traceFile, "appStoreFlow", 5)
        commonFns.setXMLValueinFile(self._traceFile, "depStoreFlow", 5)

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
        
        # Modify dependent library information to test dependency information addition.
        logging.info("Modifying dependent libraries so that application need DYLD_LIBRARY_PATH to launch it.")
        shutil.copy(self._curLocLib1, self._depLib2)
        shutil.copy(self._curLocLib2, self._depLib1)
        regex1 = "DependentStore::addAppToDependent - Entered for app = " + self._depLib1 + " , dep =" + self._application
        regex2 = "DependentStore::addAppToDependent - Entered for app = " + self._depLib2 + " , dep =" + self._application

        if commonFns.parseFile(self._traceLog, regex1) == True and commonFns.parseFile(self._traceLog, regex2) == True:
            logging.info("expected traces found in the logs")
        else:
            logging.error("traces not found in logs.")

        _retVal = subprocess.call(["/bin/sh", "-c", self._application])

        if _retVal != 0:
            logging.info("Application launch failed without DYLD_LIBRARY_PATH (as expected)")
        else:
            logging.error("Application launched unexpectedly without DYLD_LIBRARY_PATH")
            return 1
        
        # Launching application with DYLD_LIBRARY_PATH info.
        _retVal = subprocess.call(['/bin/sh', '-c', self._application], env={"DYLD_LIBRARY_PATH": "/tmp"})

        if _retVal != 0:
            logging.error("Application launch failed with DYLD_LIBRARY_PATH.")
            return 1        
        else :
            logging.info("Application launched with DYLD_LIBRARY_PATH.")

        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        _regex1 = self._DYLD_Lib1
        _regex2 = self._DYLD_Lib2

        if commonFns.parseFile(self._traceLog, _regex1) == True or commonFns.parseFile(self._traceLog, _regex2) == True:
            logging.error("Unexpected traces found in the logs")
            return 1
        else:
            logging.info("traces not found in logs. (as expected)")

        return 0

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

        os.remove(self._depLib1)
        os.remove(self._depLib2)
        os.remove(self._DYLD_Lib1)
        os.remove(self._DYLD_Lib2)        
        CommonAppProFns.resetAppProtToDefaults()
        commonFns.cleanLogs()

        if foundCrash != 0:
            logging.info("TwoSharedLibs binary crash expected...")
            foundCrash = 0

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
