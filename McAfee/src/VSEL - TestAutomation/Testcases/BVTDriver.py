#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.

import logging
import time
import sys
import os
import subprocess
import optparse
import re

if sys.version_info < (2, 5) :
    raise "Running scripts require Python 2.5 or greater"
# Add common folder into the sys path for module importing
currentDir=os.getcwd()
testcaseDir=os.path.dirname(os.path.abspath(sys.argv[0]))

sys.path.append(testcaseDir + "../Common")

def main():
    parser = optparse.OptionParser(description="*** A driver script which will invoke all of bvt test scripts ***",
                    version="*** AUTHOR - Autobots ***"'\n'
                                         "%prog version-1.0",
                                    usage='%prog  arguments')
    parser.add_option("--loglevel","-l",action="store", dest="log_value",default="info",
                      help = "Specify the level of logging needed. Default level is info")
    parser.add_option("--install","-i",action="store", dest="install_URL",
                      help = "Complete URL or path of the VSEL installer. If this option is not specified, installation and uninstallation will be skipped")
    options, arguments = parser.parse_args()
    
    if os.getuid() != 0:
        print ("The script should be invoked as root")
        sys.exit(1)

    logLevel = logging.DEBUG
    # Parameter provided, set the log level accordingly
    if(options.log_value == "debug"):
        logLevel=logging.DEBUG
    elif(options.log_value == "info"):
        logLevel=logging.INFO
    elif(options.log_value == "warning"):
        logLevel=logging.WARNING
    elif(options.log_value == "error"):
        logLevel=logging.ERROR
    elif(options.log_value == "critical"):
        logLevel=logging.CRITICAL

    # Set log format with time/date, logLevel and message
    logFormat='%(asctime)s %(levelname)-8s %(message)s'

    # Set date format
    logDateFmt='%d %b %H:%M:%S'

    # Set log file name
    logFileName=testcaseDir + "/Logs/" + os.path.basename(sys.argv[0])[:-2]+"log"

    print ("Consolidated log would be available in " + logFileName)
    sys.stdout.flush()
    # Set log file mode as write
    logFileMode='w'

    # Now, configure the logging
    logging.basicConfig(level=logLevel,
            format=logFormat,
            datefmt=logDateFmt,
            filename=logFileName,
            filemode=logFileMode) 

    
    # Lets switch to the common tc directory
    #install
    if options.install_URL :
        if os.path.exists(options.install_URL) :
            options.install_URL = os.path.abspath(options.install_URL)
        logging.debug("Buildpath is " + options.install_URL)
        os.chdir(testcaseDir + "/Common")
            
        logging.info("Starting installation")
        retval = subprocess.call([ "python", "Install.py", options.log_value,options.install_URL])
        if retval == 0:
            print "Test Install passed"
            logging.info("===RESULT:Installation:PASS")
        else:
            print "Test Install failed"
            logging.info("===RESULT:Installation:FAIL")
            sys.exit(1)
        # Lets switch back
        os.chdir(testcaseDir)
    else:
        logging.info("Skipping installation")
   
    
    # List of testcases
    testcases_to_be_run = [
                            { "Name": "VSEL_Stop_Start.py",
                              "Path": testcaseDir + "/Common",
                              "Desc": "Start/Stop/Restart of VSEL daemon"
                            },
                            { "Name": "AllServicesRunning.py",
                              "Path": testcaseDir + "/Common",
                              "Desc": "Linuxshield services come up properly after VSEL is installed"
                            },
                            { "Name": "KernelHookCheck.py",
                              "Path": testcaseDir + "/Common",
                              "Desc": "Check kernel hooking modules", 
                            },
                            { "Name": "VselProductCheck.py",
                              "Path": testcaseDir + "/Common",
                              "Desc": "Testcase to verify the installed version of VirusScan Enterprise for Linux"
                            },  
                            { "Name": "OAS_BVT_1.py",
                              "Path": testcaseDir + "/Antimalware/OAS",
                              "Desc": "Trigger eicar file / install check on smbfs",
                            },
                            { "Name": "OAS_BVT_2.py",
                              "Path": testcaseDir + "/Antimalware/OAS",
                              "Desc": "Primary clean and secondary delete on eicar file"
                            },
                            { "Name": "OAS_BVT_3.py",
                              "Path": testcaseDir + "/Antimalware/OAS",
                              "Desc": "Read/Access eicar test virus filr from NFS read/write volume"
                            },
                            { "Name": "OAS_BVT_5.py",
                              "Path": testcaseDir + "/Antimalware/OAS",
                              "Desc": "Check OAS running properly after installation",
                            },
                            { "Name": "OAS_BVT_6.py",
                              "Path": testcaseDir + "/Antimalware/OAS",
                              "Desc": "Test the installation using EICAR.com test virus"
                            },
                            { "Name": "ODS_BVT_1.py",
                              "Path": testcaseDir + "/Antimalware/ODS",
                              "Desc": "Scan task for ODS for a specific folder"
                            },
                            { "Name": "ODS_BVT_2.py",
                              "Path": testcaseDir + "/Antimalware/ODS",
                              "Desc": "Running a scheduled task"
                            },
                            { "Name": "OAS_BVT_4.py",
                              "Path": testcaseDir + "/Antimalware/OAS",
                              "Desc": "Relaod nails after dat update ",
                            },
                            { "Name": "VSEL_Update.py",
                              "Path": testcaseDir + "/Common",
                              "Desc": "dat update after product installation", 
                            },
                          ]
    overallStatus = 0
    # Execute test cases
    for tc in testcases_to_be_run :
        time.sleep(2)
        print("Running testscript for %s" % tc["Name"])
        sys.stdout.flush()
        logging.info("Starting execution of  %s" % tc["Name"])

        # Lets switch to the common tc directory
        os.chdir(tc["Path"])
        
        # Execute the test case
        try:
            rc = subprocess.call( [ "python", 
                           tc["Name"],
                           options.log_value])

            if rc == 0:
                print "Test %s passed" % tc["Name"]
                logging.info("===RESULT:%s:PASS" % tc["Desc"])
            else:
                overallStatus = 1
                print "Test %s failed" % tc["Name"]
                logging.info("===RESULT:%s:FAIL" % tc["Desc"])
        except:
            logging.error("Unable to execute %s" % tc["Name"])
        
        os.chdir(testcaseDir)

    #Uninstall
    if options.install_URL != None:
        os.chdir(testcaseDir + "/Common")
        rc = subprocess.call( [ "python", "Uninstall.py", options.log_value ],\
                stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        if rc == 0:
            print "Test Uninstall passed"
            logging.info("===RESULT:Un-Installation:PASS")
        else:
            print "Test Uninstall failed"
            logging.info("===RESULT:Un-Installation:FAIL")
        # Lets switch to the directory where we are invoked from
        os.chdir(currentDir)
    else:
        logging.info("Skipping uninstallation")
    return overallStatus

if __name__ == "__main__":
    sys.exit(main())
