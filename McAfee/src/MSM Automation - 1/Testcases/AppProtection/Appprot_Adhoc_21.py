#!/usr/bin/python

# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 17444
# TestcaseDescription: Test AppPro functionality test when application added to the AppPro rule gets changed using hard link

import sys
import logging
import subprocess
import os.path
import shutil
# Add common folder into the sys path for module importing
sys.path.append("../Common")

# Import CommonTest module into current namespace
from CommonTest import *
import commonFns
import CommonAppProFns
# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 17444")
        logging.info("Description : Test AppPro functionality when application added to the AppPro rule gets changed using hard link")

    def init(self):
	logging.info("Initializing testcase %s" % testcaseName)
        # Call the base initialization
        if BaseTest.init(self) != 0 :
            return 1
        self.data_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
        self.app_paths = ( self.data_dir + "/data/SampleApplications/UDPClient", \
            self.data_dir + "/data/SampleApplications/UDPServer")

        self.link_names = ( self.data_dir + "/data/SampleApplications/UDPClient_LINK", \
            self.data_dir + "/data/SampleApplications/UDPServer_LINK")

        self.rule = {"AppPath" : self.app_paths[1], "Enabled" : "1",
                     "ExecAllowed":"1",
                     "NwAction":"1"}


        # Install the test tool
        logging.debug("Installing appProtTestTool")
        if CommonAppProFns.installAppProtTestTool() != True :
            logging.error("Failed to install appProtTestTool")
            return 1
        logging.debug("Restting appProt to defaults")
        CommonAppProFns.resetAppProtToDefaults()
        # Set exclusion for appProtTestTool

        logging.debug("Exclude APTT ")
        CommonAppProFns.setAppProExclusions([os.path.dirname(\
                os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"])
        return 0

    def execute(self):
        """Executes the test and returns 0 for pass and 1 for fail"""
        logging.info("Executing testcase %s" % testcaseName)

        try :
            if os.path.exists(self.link_names[0]) :
                os.remove(self.link_names[0])
            logging.debug("Creating hardlink for " + self.app_paths[0])
            #os.link(self.app_paths[0], self.link_names[0])
            subprocess.call( [ "ln", "-f", self.app_paths[0], self.link_names[0]],
                    stdout=subprocess.PIPE,stderr=subprocess.PIPE)

            if os.path.exists(self.link_names[1]) :
                os.remove(self.link_names[1])
            logging.debug("Creating hardlink for " + self.app_paths[1])
            #os.link(self.app_paths[1], self.link_names[1])
            subprocess.call( [ "ln", "-f", self.app_paths[1], self.link_names[1]],
                    stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        except:
            logging.error("Exception occured while creating hardlinks.")
            return 1

        # Step 3 : Deny Hardlink1 to execute
        if CommonAppProFns.setUnknownAppAction(2) != True :
            logging.error("Unable to set Unknown App Action to Deny")
            return 1
        
        if CommonAppProFns.addAppProtRule(self.rule) != CommonAppProFns.SUCCESS :
            logging.error("Failed to set deny rule for %s" % self.rule["AppPath"])
            return 1

        # Step 4 : Perform move of Hardlink1 to Hardlink-2
        try :
            logging.debug("Moving %s to %s" % (self.link_names[0],
                                               self.link_names[1]))
            shutil.move(self.link_names[0], self.link_names[1])
        except :
            logging.error("Failed to move %s to %s" % (self.link_names[0],
                                                       self.link_names[1]))
            return 1

        # Launch the hardlink 2 and then terminate
        try :
            logging.debug("Opening the hardlink %s"% self.link_names[1])
            _p = subprocess.Popen([self.link_names[1]], stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE)
            if commonFns.isProcessRunning(self.link_names[1]) == True :
                _p.terminate()
        except :
            logging.debug("Failed to open the process %s" % self.link_names[1])
            return 0
        return 1

    def verify(self):
	logging.info("Verifying testcase %s" % testcaseName)

        # Check the McAfeeSecurity Log for Deny Message.
        if commonFns.searchProductLog(CommonAppProFns.REGEX_DENIED_UNKNOWN_APP) != True :
            logging.error("Failed to find the regular expression in log")
            return 1
        logging.debug("Application denied of executing")
	return 0

    def cleanup(self):
	logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        logging.debug("Copying logs")
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        # Perform test case specific cleanup
        CommonAppProFns.resetAppProtToDefaults()

        # Remove the hardlinks we created.
        logging.debug("Removing the hardlink files")
        try :
            # First hardlink has already been moved
            if os.path.exists(self.link_names[1]) :
                os.remove(self.link_names[1])
        except :
            logging.error("Failed to remove hardlink")

        # Clean Logs
        logging.debug("Cleaning the logs")
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
	    retVal=testObj.execute()

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
