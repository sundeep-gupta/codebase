#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.

import logging
import sys
import os
import subprocess
import optparse
import re
# Add common folder into the sys path for module importing
currentDir=os.getcwd()
testcaseDir=os.path.dirname(os.path.abspath(sys.argv[0]))

sys.path.append(testcaseDir + "/Common")

def speakOut(str):
    """
    Fn to provide running commentary
    """
    global silent
    if silent != True:
        subprocess.call([ "say", str])

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
    speakOut("Starting execution of category " + sc)
    os.path.walk(testcaseDir,_execute, [{
            'component_dir' : componentDir,
            'category'  : sc,
            'log_value' : log_value,
            'component_prefix'    : component_prefix
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
        speakOut(" Running Test number " + str(index))
        try:
            retval=subprocess.call( ["python", testscript, log_value ],
                    stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            if retval == 0:
                logging.info("%s script passed" % testscript)
                speakOut("Test number " + str(index) + " passed")
            else:
                logging.info("%s script failed" % testscript)
                speakOut("Test number " + str(index) + " failed")
        except:
            speakOut("Test number " + str(index) + " failed with exception")
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
    parser.add_option("--component","-o", action="store", dest="component",
                      help = "Runs test for specific component. If not specified all components will be run")
    parser.add_option("--category","-c",action="store", dest="category",
                      help = "Runs test of a specified category under specified component. If this option is not specified, all scripts of all categories will be invoked")
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
    logFileName=testcaseDir + "/Logs/"+sys.argv[0][:-2]+"log"

    print ("Consolidated log would be available in " + logFileName)
    print ("Un-mute the speakers for a running commentary on the tests")
    # Set log file mode as write
    logFileMode='w'

    # Now, configure the logging
    logging.basicConfig(level=logLevel,
            format=logFormat,
            datefmt=logDateFmt,
            filename=logFileName,
            filemode=logFileMode) 



    # Lets switch to the common tc directory
    os.chdir(testcaseDir + "/Common")
    #install
    if options.install_URL != None:
        retval = subprocess.call([ "python", "Install.py", options.log_value,options.install_URL])
        if retval == 0:
            logging.info("Installation succeeded")
        else:
            logging.error("Installation failed, Aborting test run")
            sys.exit(1)
    else:
        logging.info("Skipping installation")
    
    
    global silent
    silent = options.silent
    # List of Components
    Components = {'AppProtection':"Appprot", 'OAS':"OAS"}
    
    components_to_run = Components.keys()
    if options.component is not None :
        if options.component not in Components.keys() :
            print ("Invalid component - %s" % options.component)
            sys.exit(1)
        else :
            components_to_run = [options.component]
    else :
        if options.category is not None :
            print ("--category must be specified only with --component")
            sys.exit(1)

    for component in components_to_run :
        speakOut("Running testscripts for component %s" % component)
        logging.info("Starting execution of component : %s" % component)

        # Get the actual component directory path...
        # For AppProtection, it will be TestAutomation/Testcases/AppProtection
        # For OAS, it will be TestAutomation/Testcases/AntiMalware/OAS
        componentDirPath = testcaseDir + "/" + component
        componentDirFound = False

        # Check whether top-level directory has component sub-directory
        if os.path.isdir(componentDirPath):
            os.chdir(componentDirPath)
            componentDirFound = True
        else:
            # Traverse one level down and check whether any of them has component sub-directory
            tcDirFiles = os.listdir(testcaseDir)

            for file in tcDirFiles:
                newFilePath = testcaseDir + "/" + file
                
                if os.path.isdir(newFilePath):
                    newDirPath = newFilePath + "/" + component

                    if os.path.isdir(newDirPath):
                        os.chdir(newDirPath)
                        componentDirFound = True

        # Get actual component directory path...
        if componentDirFound == True:
            componentDirPath = os.getcwd()
        else:
            print("Invalid component %s" % (component))
            sys.exit(1)
        
        subcategories = []
        component_dir = componentDirPath
        arg = [component_dir, Components[component], subcategories]
        os.path.walk(component_dir, _getSubCategories, arg )
        
        if options.category is not None :
            if options.category not in subcategories :
                print ("Invalid Subcategory - %s in component %s" % (options.category, component))
                sys.exit(1)
            else :
                subcategories = [options.category]

        for sc in subcategories :
            componentDir = componentDirPath
            executeScriptsInSubCategory(componentDir, Components[component], sc, options.log_value)
            
        os.chdir(testcaseDir)
    
    # Lets switch to the common tc directory
    os.chdir(testcaseDir + "/Common")
    #Uninstall
    if options.install_URL != None:
        subprocess.call( [ "python", "Uninstall.py", options.log_value ],\
                stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    else:
        logging.info("Skipping uninstallation")
   
    #Lets switch to the directory where we are invoked from
    os.chdir(currentDir)

if __name__ == "__main__":
    main()
