#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 32452
# TestcaseDescription:  Installation

import sys
import logging
import os
import subprocess
import re
import commonFns
import stat
import time

# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

# get current directory.
commonDir=os.path.dirname(os.path.abspath(sys.argv[0]))

class TestCase(BaseTest):
    # Class member variables
    _file = "some value"
    _filepath = "some value"
    _covFile="some value"
    _covPath="some value"
    _logDir=commonDir+"/../../Logs/"
    _coverageEnvFile="/private/etc/BullseyeCoverageEnv.txt"

    #__init__ method
    def __init__(self):
        logging.info("TestcaseID : 32452")
        logging.info("Description : Install the product")
        commonFns.cleanLogs()

    
    #Fn for initializing variables and downloading build
    #RETURN: 0 if successful. 1 otherwise  
    def init(self, buildPath):
        logging.info("Initializing testcase %s" % testcaseName)
        
        if os.getuid() != 0:
            logging.info("The script should be invoked as root")
            return 1
        #Lets remove any previous installation if available
        if commonFns.isProductInstalled() == True: 
            logging.info("Uninstalling existing product")
            subprocess.call( [ "/usr/local/McAfee/uninstallMSC" ],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        else:
            logging.info("No previous installation")

        _regexURL = "http://"       
        # if build path contains 'http://' then it's a 'url'.
        if re.search(_regexURL, buildPath) != None:
            # Build path is a 'url'.
            logging.debug("build path is a 'url'")
            for i in buildPath.split("/"):
                self._file=i

            # Store the parent directory of the given URL dmg path for coverage related processing...	
            _covPathDir = buildPath[:buildPath.find(self._file)]	
            self._file = self._file.replace("%20"," ")
            self._filepath="/tmp/"+self._file
   
            logging.debug("File name is " + self._file)
            logging.debug("File path is " + self._filepath)
 
            if commonFns.downloadFile(buildPath,self._filepath) == False:
                logging.info("Downloading from " + buildPath + " failed")
                return 1
            logging.debug("Downloading the build succeeded")

	    # Coverage file processing...
	    # Convert the dmg leaf name into the cov file name...
	    _i = self._file.rfind("-")
	    _j = self._file[:_i-1].rfind("-")

	    self._covFile = self._file[:_j] + self._file[_i:]
	    self._covFile = self._covFile.replace(".dmg",".cov")
	    self._covFile = self._covFile.replace(" ","%20")

	    # Construct full coverage file URL...
	    self._covPath = _covPathDir + self._covFile
	    
	    logging.debug("Cov file name is" + self._covFile)
	    logging.debug("Cov file path is" + self._covPath)

            # Now, download the cov URL into the local machine...
            # The logs directory was chosen so that after the entire BVT/FVT is run, the code coverage
            # measurements will be stored in the logs directory and it will be automatically picked
            # by the TAF server...
            if commonFns.downloadFile(self._covPath, self._logDir + self._covFile) == False:
                logging.info("Downloading from " + self._covPath + " Failed")

            else:        
                logging.debug("Downloading the cov file Succeeded")

                _covFilePath = os.path.abspath(self._logDir + self._covFile)
                os.chmod(_covFilePath, stat.S_IRWXU | stat.S_IRWXG | stat.S_IRWXO)
 		
                # Dump the local cov path into the BullseyeCoverageEnv.txt file so that
                # code coverage measurement will start...
                fd = open(self._coverageEnvFile, "w")

                # Write COVFILE=<local-cov-file-path> into the file...
                fd.write("COVFILE=" + _covFilePath)
                fd.close()

                # Give full permissions to the file...
                os.chmod(self._coverageEnvFile, stat.S_IRWXU | stat.S_IRWXG | stat.S_IRWXO)

        elif os.path.exists(buildPath) == True:
            logging.debug("build path is absolute.")
            for i in buildPath.split("/"):
                self._file=i

            self._filepath = buildPath
        else:
            logging.debug("build path is relative")
            for i in buildPath.split("/"):
                self._file=i

            self._filepath = commonDir + "/../" + buildPath
            if not os.path.exists(self._filepath):
                logging.debug("Relative path provided is not correct.")
                return 1

        return 0

    #Fn for mounting and installing the build
    #RETURN: 0 if successful. 1 otherwise  
    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
    
        logging.info("Mounting DMG " + self._filepath )
	os.chmod(self._filepath, stat.S_IRWXO)
       
        if commonFns.mountDMG(self._filepath , "/Volumes/TempMountPt") == False:
            logging.info("Mounting of DMG " + self._filepath.replace(" ","\ ") + " failed")
            return 1
        
        logging.debug("Mounting of DMG succeeded")
         
        _packageFile = "/Volumes/TempMountPt/" + self._file[:-4] + ".mpkg" 
        
        _retval = subprocess.call( [ "installer" ,
                                "-pkg",
                                _packageFile,
                                "-target",
                                "/Applications" ],
                                stdout=subprocess.PIPE,
                                stderr=subprocess.PIPE
                              )
        return _retval
    
    #Fn for checking if installation is fine and services are up
    #RETURN: 0 if successful. 1 otherwise  
    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        package="Suite"
        if re.search('Anti-malware', self._file) is not None:
            package = "Antimalware"
        if commonFns.isProductInstalled() == False:
            logging.error("isProductInstalled Failed")
            return 1
        # Temporary code change to get the test running in PPC...
        time.sleep(60)
        if commonFns.areAllServicesRunning(package) == False:
            logging.error("areAllServicesRunning Failed")
            return 1
 
        return 0
    #Fn for removing the temp file and ejecting the volume
    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        subprocess.call([ "hdiutil",
                          "eject",
                          "/Volumes/TempMountPt/" ],
                          stdout=subprocess.PIPE,
                          stderr=subprocess.PIPE)
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        commonFns.cleanLogs()

        try:
            os.remove(self._filepath)
        except OSError:
            pass


        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")

        return foundCrash

    def __del__(self):
        pass

if __name__ == "__main__":

    if len(sys.argv) == 2 and sys.argv[1] not in ['debug', 'error', 'trace', 'info'] :
        tmp = sys.argv[1]
	sys.argv[1] = 'info'
	sys.argv.append(tmp)

    # Setup testcase
    setupTestcase(sys.argv)

    testObj = TestCase()
    
    # Perform testcase operations
    if len(sys.argv) == 3:
        retVal = testObj.init(sys.argv[2])
    else:
        logging.error("Invalid argument count")
        retVal = 1 

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
