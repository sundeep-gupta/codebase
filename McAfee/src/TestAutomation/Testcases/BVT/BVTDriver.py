#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.

import logging
import time
import sys
import os
import subprocess
import optparse
import re
# Add common folder into the sys path for module importing
currentDir=os.getcwd()
testcaseDir=os.path.dirname(os.path.abspath(sys.argv[0]))

sys.path.append(testcaseDir + "../Common")

def speakOut(str):
    """
    Fn to provide running commentary
    """
    global silent
    if silent != True:
        subprocess.call([ "say", str])

def main():
    parser = optparse.OptionParser(description="*** A driver script which will invoke all of bvt test scripts ***",
                    version="*** AUTHOR - Autobots ***"'\n'
                                         "%prog version-1.0",
                                    usage='%prog  arguments')
    parser.add_option("--loglevel","-l",action="store", dest="log_value",default="info",
                      help = "Specify the level of logging needed. Default level is info")
    parser.add_option("--install","-i",action="store", dest="install_URL",
                      help = "Complete URL or path of the MSM installer. If this option is not specified, installation and uninstallation will be skipped")
    parser.add_option("--av_only","-a",action="store_true", dest="av_only",default=False,
                      help = "If this option is specified, BVT for Anti-Malware alone wold be run.")
    parser.add_option("--silent","-s",action="store_true", dest="silent" ,
                      help = "Runs the tests without commentary")
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
    logFileName=testcaseDir + "/../Logs/"+sys.argv[0][:-2]+"log"

    print ("Consolidated log would be available in " + logFileName)
    print ("Un-mute the speakers for a running commentary on the tests")
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
    os.chdir(testcaseDir + "/../Common")
    #install
    if options.install_URL != None:
        logging.info("Starting installation")
        retval = subprocess.call([ "python", "Install.py", options.log_value,options.install_URL])
        if retval == 0:
            print "Test Install passed"
            logging.info("===RESULT:Installation:PASS")
        else:
            print "Test Install passed"
            logging.info("===RESULT:Installation:FAIL")
            sys.exit(1)
    else:
        logging.info("Skipping installation")
   
    # Lets switch back
    os.chdir(testcaseDir)
    
    global silent
    silent = options.silent
    # List of testcases
    testcases_to_be_run = [
                            { "Name":"CommonProductServicesLaunch.py",
                              "Path":testcaseDir+"/../Common",
                              "Desc":"Check for Common Product services are running",
                              "Type":"AV"
                            },
                            { "Name":"ConsoleAppLaunch.py",
                              "Path":testcaseDir+"/../Common",
                              "Desc":"Check for Console McAfee Security is running",
                              "Type":"AV"
                            },
                            { "Name":"MenuletLaunch.py",
                              "Path":testcaseDir+"/../Common",
                              "Desc":"Check for Menulet service is running",
                              "Type":"AV"
                            },
                            { "Name":"OtherProductServicesLaunch.py",
                              "Path":testcaseDir+"/../Common",
                              "Desc":"Check for Other Product services are running",
                              "Type":"Full"
                            },
                            { "Name":"OAS_Scan_Action_9.py",
                              "Path":testcaseDir+"/../AntiMalware/OAS",
                              "Desc":"OAS detects infection",
                              "Type":"AV"
                            },
                            { "Name":"OAS_Scan_Action_9.py",
                              "Path":testcaseDir+"/../AntiMalware/OAS",
                              "Desc":"Quarantine Succeeds for OAS",
                              "Type":"AV"
                            },
                            { "Name":"OAS_BVT_1.py",
                              "Path":testcaseDir+"/../AntiMalware/OAS",
                              "Desc":"OAS EXclusions",
                              "Type":"AV"
                            },
                            { "Name":"ODS_BVT_1.py",
                              "Path":testcaseDir+"/../AntiMalware/ODS",
                              "Desc":"ODS detects infections",
                              "Type":"AV"
                            },
                            { "Name":"ODS_BVT_2.py",
                              "Path":testcaseDir+"/../AntiMalware/ODS",
                              "Desc":"Quarantine succeeds for ODS",
                              "Type":"AV"
                            },
                            { "Name":"ODS_BVT_3.py",
                              "Path":testcaseDir+"/../AntiMalware/ODS",
                              "Desc":"ODS  exclusions",
                              "Type":"AV"
                            },
                            { "Name":"Eupdate_BVT_1.py",
                              "Path":testcaseDir+"/../AntiMalware/eUpdate",
                              "Desc":"Update succeeds",
                              "Type":"AV"
                            },
                            { "Name":"Appprot_BVT_1.py",
                              "Path":testcaseDir+"/../AppProtection",
                              "Desc":"This TC to verify default rules set for App Protection",
                              "Type":"Full"
                            },
                            { "Name":"Appprot_BVT_2.py",
                              "Path":testcaseDir+"/../AppProtection",
                              "Desc":"AppProtection Exclusions",
                              "Type":"Full"
                            },
                            { "Name":"Appprot_Application_Types_3.py",
                              "Path":testcaseDir+"/../AppProtection",
                              "Desc":"AppProtection rule without network access",
                              "Type":"Full"
                            },
                            { "Name":"Appprot_Application_Types_14.py",
                              "Path":testcaseDir+"/../AppProtection",
                              "Desc":"AppProtection rule deny  execution",
                              "Type":"Full"
                            },
                            { "Name":"Firewall_BVT_1.py",
                              "Path":testcaseDir+"/../Firewall",
                              "Desc":"This TC to verify default rules set for firewall",
                              "Type":"Full"
                            },
                            { "Name":"Firewall_BVT_2.py",
                              "Path":testcaseDir+"/../Firewall",
                              "Desc":"To verify that firewall rule can be added to allow ping packets",
                              "Type":"Full"
                            },
                            { "Name":"Firewall_BVT_3.py",
                              "Path":testcaseDir+"/../Firewall",
                              "Desc":"This TC is to verify whether deny telnet rule can be added",
                              "Type":"Full"
                            },
                            { "Name":"Firewall_BVT_4.py",
                              "Path":testcaseDir+"/../Firewall",
                              "Desc":"This TC is to verify whether entries can be added to trusted list of firewall",
                              "Type":"Full"
                            }
                          ]
    overallStatus=0
    scan_actions_result=-1
    # Execute test cases
    for tc in testcases_to_be_run :
        if ( options.av_only == True and
             tc["Type"] == "Full" ):
            continue
        time.sleep(2)
        print("Running testscript for %s" % tc["Name"])
        sys.stdout.flush()
        speakOut("Running testscript for  %s" % tc["Name"])
        logging.info("Starting execution of  %s" % tc["Name"])
        # Lets switch to the common tc directory
        os.chdir(tc["Path"])
        
        # Execute the test case
        try:
            if tc["Name"] == "OAS_Scan_Action_9.py" and scan_actions_result != -1:
                if scan_actions_result == 0:
                    print "Test %s passed" % tc["Name"]
                    logging.info("===RESULT:%s:PASS" % tc["Desc"])
                else:
                    overallStatus=1
                    print "Test %s failed" % tc["Name"]
                    logging.info("===RESULT:%s:FAIL" % tc["Desc"])
                continue
            sys.stdout.flush()
            rc = subprocess.call( [ "python", 
                           tc["Name"],
                           options.log_value])
            if tc["Name"] == "OAS_Scan_Action_9.py":
                scan_actions_result=rc

            if rc == 0:
                print "Test %s passed" % tc["Name"]
                logging.info("===RESULT:%s:PASS" % tc["Desc"])
            else:
                overallStatus=1
                print "Test %s failed" % tc["Name"]
                logging.info("===RESULT:%s:FAIL" % tc["Desc"])
                
        except:
            logging.error("Unable to execute %s" % tc["Name"])
        
        os.chdir(testcaseDir)

    #Uninstall
    if options.install_URL != None:
        os.chdir(testcaseDir + "/../Common")
        rc = subprocess.call( [ "python", "Uninstall.py", options.log_value ],\
                stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        if rc == 0:
            print "Test Uninstall passed"
            logging.info("===RESULT:Un-Installation:PASS")
        else:
            print "Test Uninstall failed"
            logging.info("===RESULT:Un-Installation:FAIL")
    else:
        logging.info("Skipping uninstallation")
   
    #Lets switch to the directory where we are invoked from
    os.chdir(currentDir)
    sys.exit(overallStatus)

if __name__ == "__main__":
    main()
