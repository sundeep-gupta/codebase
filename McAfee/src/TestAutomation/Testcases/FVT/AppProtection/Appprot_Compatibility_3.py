#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16427
# TestcaseDescription: Testcase to verify the compatibility between App protection and Other McAfee Products 

import sys
import logging
import subprocess
import time
import stat
import os

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")

import commonFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : ID16427")
        logging.info("Description : Testcase to verify the compatibility between App protection and Other McAfee Products") 

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        self.mnacDMGPath = os.path.dirname(os.path.abspath(sys.argv[0]))\
                             + "/data/SampleApplications/mnac.dmg"
        self.mpkgPath = "/Volumes/Kairos/mnac.mpkg"

        os.chmod(self.mnacDMGPath, stat.S_IRWXU | stat.S_IRWXG |  stat.S_IRWXO)    
        
        # Check if the OS version is not SnowLeopard. If yes then Pass the TC
        Cmd = "sw_vers | grep \"ProductVersion\" | awk -F \" \" '{print $2}' | awk -F \".\" '{print $2}'"
        process = subprocess.Popen(Cmd, shell=True, stdout=subprocess.PIPE)
        retVal = process.communicate()[0]
        ver = retVal[0];
        ver = ver.rstrip("\n")
        if ver == "6":
            logging.debug("OS is Snow Leopard")
            time.sleep(3)
            logging.info("Result of testcase %s: PASS" % (testcaseName) )
            sys.exit(0)
            
        logging.debug("OS is either Leopard/Tiger")    
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # Mount the MNac DMG
        Cmd1 = "open " + self.mnacDMGPath
        try:
            retval = subprocess.call(Cmd1, shell = True)
            if retval != 0 :
                logging.error("Unable to launch the Mnac DMG")
                return 1
        except:
            logging.error("Exception occured in Launching Mnac DMG")
            return 1

        time.sleep(5) 

        # Do a Silent Install of MNac 
        Cmd2 = "installer -pkg " + self.mpkgPath + " -target /"
        try:
            retval = subprocess.call(Cmd2, shell = True)
            if retval != 0 :
                logging.error("unable to install Mnac")
                return 1
        except:        
            logging.error("Exception occured in silent install of Mnac")
            return 1
        time.sleep(5)    
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        # Verify that all MSM process and MNac process are running 
        if commonFns.isProcessRunning("fmpd") != True :
            logging.error("Error FMP process is not running after MNac installation")
            return 1
        logging.debug("fmpd is running")    
        if commonFns.isProcessRunning("VShieldService") != True :
            logging.error("Error VShieldService process is not running after MNac installation")
            return 1
        logging.error("VShieldService is running")    
        if commonFns.isProcessRunning("VShieldScanManager") != True :
            logging.error("Error VShieldScanManager process is not running after MNac installation")
            return 1
        logging.debug(" VShieldScanManager is running")    
        if commonFns.isProcessRunning("FWService") != True :
            logging.error("Error Firewall process is not running after MNac installation")
            return 1
        logging.debug("FWService is running")    
        if commonFns.isProcessRunning("appProtd") != True :
            logging.error("Error appProtd process is not running after MNac installation")
            return 1
        logging.debug("appProtd is running")    
        if commonFns.isProcessRunning("Menulet") != True :
            logging.error("Error Menulet process is not running after MNac installation")
            return 1
        logging.debug("Menulet is running")    
        if commonFns.isProcessRunning("McAfee Reporter") != True :
            logging.error("Error McAfee Reporter process is not running after MNac installation")
            return 1
        logging.debug("McAfee Reporter is running")    
        if commonFns.isProcessRunning("MNacScanner") != True :
            logging.error("Error MNacScanner process is not running after MNac installation")
            return 1
        logging.debug("MNacScanner is running")    
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        Cmd3 = "sudo /Library/McAfee/mnac/uninstall.sh"
        try:
            retval = subprocess.call(Cmd3, shell=True)
            if retval != 0:
                logging .error("Uninstalltion of MNac failed")
        except:
            logging.error("Exception occured while uninstalling MNac")
        logging.debug("MNac Uninstalled successfully")

        subprocess.call([ "hdiutil",
                            "eject",
                            "/Volumes/Kairos" ],
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)

        logging.debug("MNac dmg unmounted successfully")   
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
