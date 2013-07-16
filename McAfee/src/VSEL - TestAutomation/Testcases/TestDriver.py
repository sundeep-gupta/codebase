#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.

import logging
import sys
import os
import subprocess
import optparse
import re
if sys.version_info < (2, 5) :
    raise "Running scripts require Python 2.5 or greater"
# Add common folder into the sys path for module importing
testcaseDir = os.path.dirname(os.path.abspath(sys.argv[0]))
commonDir = testcaseDir + '../Common'
component = 'OAS'
componentDirPath = testcaseDir + '/' + component
sys.path.append(commonDir)

def _getSubCategories(arg, dirname, names):
    component_dir    = arg[0]
    component_prefix = arg[1]
    categories       = arg[2]
    regex            = component_prefix + "_" + "(.*)_\d+\.py$"
    if dirname != component_dir :
        return 0
    for testscript in names :
        match = re.search(regex, testscript)
        if match is None :
            continue
        sc = match.group(1)
        if sc not in categories :
            categories.append(sc)

def executeScriptsInSubCategory(componentDir, component_prefix, sc, log_value):
    """
    Fn. Executes the test cases of a particular subcategory 
    """
    if log_value == None:
        log_value = "debug"
    os.path.walk(testcaseDir,_execute, [{
            'component_dir' : componentDir,
            'category'  : sc,
            'log_value' : log_value,
            'component_prefix' : component_prefix
            }])

def _execute(arg, dirname, names):
    """
    Callback function called by os.path.walk
    Runs the testscripts under the given category.
    """
    component_dir     = arg[0]['component_dir']
    component_prefix  = arg[0]["component_prefix"]
    category          = arg[0]['category']
    log_value         = arg[0]['log_value']
    regex             = component_prefix + "_"+ category + "_(\d+)\.py"
    # Execute only for the given directory.
    # and ignore the subdirectories under it.
    if dirname != component_dir :
        return 0
    for testscript in names :
        match = re.search(regex, testscript)
        if  match == None :
            continue
        index = match.group(1)
        logging.info("Executing test script %s"% testscript)
        try:
            retval=subprocess.call( ["python", testscript, log_value ],
                    stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            if retval == 0:
                logging.info("%s script passed" % testscript)
            else:
                logging.info("%s script failed" % testscript)
        except:
            logging.info("%s script failed with exception" % testscript)

def main():
    parser = optparse.OptionParser(description="*** A driver script which will invoke all of App Protection test scripts ***",
                    version="*** AUTHOR - Autobots ***"'\n'
                                         "%prog version-1.0",
                                    usage='%prog  arguments')
    parser.add_option("--loglevel","-l",action="store", dest="log_value",default="info",
                      help = "Specify the level of logging needed. Default level is info")
    parser.add_option("--install","-i",action="store", dest="install_URL",
                      help = "Complete URL  or path of the MSM installer. If this option is not specified, installation and uninstallation will be skipped")
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
    logFileName=testcaseDir + "/Logs/"+sys.argv[0][:-2]+"log"

    # Set log file mode as write
    logFileMode='w'

    # Now, configure the logging
    logging.basicConfig(level=logLevel,
            format=logFormat,
            datefmt=logDateFmt,
            filename=logFileName,
            filemode=logFileMode) 

    print ("Consolidated log would be available in " + logFileName)


    # Lets switch to the common tc directory

    #install
    if options.install_URL != None:
        os.chdir(testcaseDir + "/Common")
        retval = subprocess.call([ "python", 'Install.py', options.log_value,options.install_URL])
        if retval != 0:
            logging.error("Installation failed, Aborting test run")
            sys.exit(1)
        logging.info("Installation succeeded")
        os.chdir(testcaseDir)
    else:
        logging.info("Skipping installation")
    suites = [{'dir' : 'Antimalware',
              'driver' : 'OASDriver.py'
              },
              {'dir' : 'Antimalware',
               'driver' : 'ODSDriver.py'
               }
    ]
    for suite in suites :
        os.chdir(suite['dir'])
        retval = subprocess.call(['python', suite['driver'], '--loglevel=' + options.log_value])
        os.chdir(testcaseDir)
    # Uninstall
    if options.install_URL != None:
        # Lets switch to the common tc directory
        os.chdir(testcaseDir + "/Common")
        subprocess.call( [ "python", "Uninstall.py", options.log_value ],\
                stdout=subprocess.PIPE,stderr=subprocess.PIPE)
            #Lets switch to the directory where we are invoked from
        os.chdir(testcaseDir)
    else:
        logging.info("Skipping uninstallation")
   


if __name__ == "__main__":
    main()