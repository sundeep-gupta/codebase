#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: ID16426 
# TestcaseDescription:  Testcase to verify the compatibility between App protection and Apple's Airport Connectivity 

import sys
import logging
import subprocess
import time
import socket
import re
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
        logging.info("TestcaseID : ID16426")
        logging.info("Description : Testcase to verify the compatibility between App protection and Apple's Airport Connectivity") 

    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check
        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        logging.debug("Check for OS Version first !!")
        Cmd = "sw_vers | grep \"ProductVersion\" | awk -F \" \" '{print $2}' | awk -F \".\" '{print $2}'"
        process = subprocess.Popen(Cmd, shell=True, stdout=subprocess.PIPE)
        retVal = process.communicate()[0]
        ver = retVal[0];
        ver = ver.rstrip("\n")
        if ver == "6":
            logging.debug("*** OS is Snow Leopard ***")
            # run the listallhardwareports option first
            Cmd = "networksetup -listallhardwareports"
            try:
                process = subprocess.Popen(Cmd, shell=True, stdout=subprocess.PIPE)
                retVal = process.communicate()[0]
                # regex match to get the either en0 or en1 for airport
                m = re.search("AirPort\\nDevice:\s(en\d)", retVal)
                self.hardwarePort = m.group(1)
                if m is not None:
                    Cmd1 = "networksetup -setairportpower %s on" % self.hardwarePort 
                    # Check for SL OS. If YES, we need to pass hardwarePort (en0/en1) as a 
                    # parameter to networksetup command
                    try:
                        retval = subprocess.call(Cmd1, shell=True)
                        if retval != 0 :
                            logging.error("Unable to turn on the airport")
                            return 1
                    except:
                        logging.error("Exception occured in airport on")
                        return 1
                else:
                    logging.error("Unable to get ether H/W port for Airport")
            except:
                logging.error("Exception occured in getting H/W port")
                return 1
            Cmd2= 'networksetup -setairportnetwork %s "BigPhoenix" "VirexLsh"' % self.hardwarePort 
            try:
                retval = subprocess.call(Cmd1, shell=True)
                if retval != 0 :
                    logging.error("Unable to turn on the airport")
                    return 1
            except:
                logging.error("Exception occured in airport on")
                return 1
            time.sleep(5)
            logging.debug("Done with all the commands on Snow-Leopard")        
        else:
            # Run different commands for leopard 
            logging.debug("*** OS is Leopard ***")
            Cmd1 = "networksetup -setairportpower on"
            try:
                retval = subprocess.call(Cmd1, shell=True)
                if retval != 0 :
                    logging.error("Unable to turn on the airport")
                    return 1
            except:
                logging.error("Exception occured in airport on")
                return 1

            #Check if the link is already done
            if os.path.islink("/usr/sbin/airport") == True:
                logging.debug("airport link already exists")
            else:
                # Create a symbolic link to the airport command
                Cmd3 = "ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/sbin/airport"
                try:
                    retval = subprocess.call(Cmd3, shell=True)
                    if retval != 0 :
                        logging.error("Unable to make a symbolic link to airport cmd")
                        return 1
                except:
                    logging.error("Exception occured while making a symbolic link to airport cmd") 
                    return 1
            Cmd2 = "airport --associate=BigPhoenix --password=VirexLsh"
            try:
                retval = subprocess.call(Cmd2, shell=True)
                if retval != 0 :
                    logging.error("Unable to make connection with BigPhoenix N/W")
                    return 1
            except:
                logging.error("Exception occured while making a connection with BigPhoenix N/W")
                return 1
            time.sleep(5)
            logging.debug("Done with all the commands on Leopard")        
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        time.sleep(10)
        # check for the ip address
        hostIp = socket.gethostbyname(socket.gethostname())
        pattern = re.compile(r"""
                    \b                                           # matches the beginning of the string
                    (25[0-5]|                                    # matches the integer range 250-255 OR
                    2[0-4][0-9]|                                 # matches the integer range 200-249 OR
                    [01]?[0-9][0-9]?)                            # matches any other combination of 1-3 digits below 200
                    \.                                           # matches '.'
                    (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)       # repeat
                    \.                                           # matches '.'
                    (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)       # repeat
                    \.                                           # matches '.'
                    (25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)       # repeat
                    \b                                           # matches the end of the string
                    """, re.VERBOSE)

        if re.match(pattern, hostIp):
            logging.debug("Got a valid IP address")
            return 0
        else:
            logging.error("Unable to get a valid IP address")
            return 1

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        commonFns.cleanLogs()
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
