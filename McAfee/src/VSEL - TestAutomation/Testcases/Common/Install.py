#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 1732
# TestcaseDescription:  Installation of VSEL

import sys
import logging
import os
import re
import tarfile
import shutil
import time
sys.path.append("../Antimalware/")
import commonFns
import commonAntiMalwareFns
# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]
# get current directory.
commonDir=os.path.dirname(os.path.abspath(sys.argv[0]))

class TestCase(BaseTest):
    # Class member variables
    def __init__(self):
        logging.info("TestcaseID : 1732")
        logging.info("Description : Installation of VSEL")

    def init(self, buildPath, version):
        logging.info("Initializing testcase %s" % testcaseName)
        self._version = version
        self._destination  = os.path.dirname(os.path.abspath(sys.argv[0])) + '/data/build'
        self._options_file = os.path.dirname(os.path.abspath(sys.argv[0])) +'/data/nails.options'
        if not os.path.exists(self._options_file) :
            logging.error("File %s does not exist. Cannot continue with installation" % self._options_file)
            return 1
        if not os.path.isdir(self._destination) :
            logging.error("Directory %s does not exist. Cannot continue with installation " % self._destination)
            return 1

        logging.debug("Removing the existing files if any")
        [ os.remove(self._destination + '/' + _file) for _file in os.listdir(self._destination) if _file not in [ '.svn' ,'nails.options']]

        # Lets remove any previous installation if available
        logging.debug("Checking if product is installed")
        if commonAntiMalwareFns.isProductInstalled() : 
            logging.info("Uninstalling existing product")
            if not commonAntiMalwareFns.UnInstallPackage() :
                logging.error("UnInstallation failed")
                return 1
            logging.debug("UnInstallation successful.")
        else:
            logging.debug("No previous installation")

        _regexURL = "http://"       
        # if build path contains 'http://' then it's a 'url'.
        if re.search(_regexURL, buildPath) :
            logging.debug("build path is a 'url'")
            for i in buildPath.split("/"):
                self._file = i

            self._file     = self._file.replace("%20"," ")
            self._filepath = self._destination + self._file
    
            logging.debug("Downloading the build at " + self._filepath)
            if not commonFns.downloadFile(buildPath, self._filepath) :
                logging.info("Downloading from " + buildPath + " failed")
                return 1
            logging.debug("Downloaing the build succeeded")
        else :
            buildPath = os.path.abspath(buildPath)
            if not os.path.exists(buildPath) :
                logging.error("build path (%s) does not exist" % buildPath)
                return 1
            logging.debug("build path %s exists" % buildPath)
            for i in buildPath.split("/"):
                self._file = i
            self._filepath = buildPath

        return 0
   
    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        
        logging.debug("Extracting %s to %s" % (self._filepath, self._destination))
        tar = tarfile.open(self._filepath)
        _files = tar.getnames()
        tar.extractall(path=self._destination)
        
        shutil.copy(self._options_file, '/root')
        
        logging.debug("Installing the package %s" % self._filepath)
        
        # For Ubuntu '.deb' and '.rpm' for all others.
        _packages = [ _p for _p in _files if re.search('\.rpm$', _p) ]
        if commonFns.getOSDetails()['os_name'] == 'Ubuntu' :
            _packages = [ _p for _p in _files if re.search('\.deb$', _p) ]
        # For LinuxShield 1.5.0, nwa and LinuxShield
        if self._version and self._version ==  commonAntiMalwareFns.VALID_VSEL_KEYS[0] :
            ar_regex = ['^LinuxShield']
        
        # For other versions, it is cma, rt and linuxshield / mcafee
        elif self._version and self._version == commonAntiMalwareFns.VALID_VSEL_KEYS[1] :
            ar_regex = ['^MFErt', '^MFEcma', '^LinuxShield']
        else :
            ar_regex = ['^MFErt', '^MFEcma', '^McAfee']
        
        # arrange in order
        _ordered_packages = []
        for regex in ar_regex :
            _ordered_packages = _ordered_packages + [ _p for _p in _packages if re.search(regex, _p) ]
        
        # If we could not find the required packages in order, then there is a problem.
        if len(_ordered_packages) < len(ar_regex) :
            logging.error("Not able to find packages in extracted archive")
            return 1

        for _p in _ordered_packages :
            logging.debug("Installing %s " % ( self._destination + '/' + _p))
            if  not commonFns.install(self._destination + '/'  + _p) :
                logging.error("Installation of package %s failed" % _p)
                return 1
            time.sleep(10)
        
        logging.info("Installation successful.")
        return 0
         
    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        logging.debug("Sleeping to let services start")
        time.sleep(60)
        if commonAntiMalwareFns.isProductInstalled() == False:
            logging.error("isProductInstalled Failed")
            return 1
        if commonAntiMalwareFns.areAllServicesRunning() == False:
            logging.error("areAllServicesRunning Failed")
            return 1
        return 0
    
    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        
        logging.debug("Removing the existing files if any")
        [ os.remove(self._destination + '/' + _file) for _file in os.listdir(self._destination) if _file not in [ '.svn' ]]
        
        commonFns.cleanLogs()

        try:
            # Do not remove file if it is not downloaded.
            if re.match('^http', sys.argv[2]) :
                os.remove(self._filepath)
        except OSError:
            logging.debug("Failed to remove " + self._filepath)

        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")

        return foundCrash

    def __del__(self):
        pass

if __name__ == "__main__":
    # Setup testcase
    setupTestcase(sys.argv)

    testObj = TestCase()

    if len(sys.argv) in [3, 4]:
        if len(sys.argv) == 4 and sys.argv[3] not in commonAntiMalwareFns.VALID_VSEL_KEYS :
            logging.error("Invalid version specified")
            sys.exit(1)
        else :
            retVal = testObj.init(sys.argv[2], sys.argv[3])
    else:
        logging.error("Invalid argument count")
        sys.exit(1)

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
