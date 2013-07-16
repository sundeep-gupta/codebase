#!/usr/bin/env python
 
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# Driver script for the updater.

# 1.5 - > any next version .. install the agent. and uninstall the previous agent
# 151 - > above its upgrade
#

# Manual upgrade
# Install 1.5 (linuxshiled)
# For 1.5.1 - install mfert, install mfecma, upgrade linuxshield (-u)
# For 1.6 - Upgrade agent, and product,
# For 1.7 - Same


# EPO  Upgrade .. posible only from 1.5.1
#
# 1. install ma 4.0 of 1.5.1 (mfert and mfecma)
# 2. Bring to managed mode and then create a deployment task of linuxshield 1.5.1
# 3. Now create a upgrade task of ma to 4.5 (for installing lsnxhld 1.6)
# 4. Now create product dploymenttask for .16
# 5. Now create a deployment task for .17.
# run the bvt driver script

import subprocess
import logging
import optparse
import os
import sys
testcaseDir=os.path.dirname(os.path.abspath(sys.argv[0]))

sys.path.append(testcaseDir + "/Common")
sys.path.append(testcaseDir + '/Antimalware')
import commonFns
import commonAntiMalwareFns
from commonAntiMalwareFns import VALID_VSEL_KEYS


def main() :
    usage_text = """
%prog  [options] START_VERSION [HOP_VERSION [HOP_VERSION ..]] STOP_VERSION

START_VERSION : Is one of  LYNXSHLD1500, LYNXSHLD1510 and LYNXSHLD1600. For Ubuntu it must be LYNXSHLD1600.
STOP_VERSION  : Version to which product has to be upgraded. This must be greater than START_VERSION.
HOP_VERSION   : Intermediate version to which product will be upgraded before being upgraded to STOP_VERSION.

"""
    parser = optparse.OptionParser(description="*** A driver script which will invoke all of bvt test scripts ***",
                    version="*** AUTHOR - Autobots ***"'\n'
                                         "%prog version-1.0",
                                    usage=usage_text)
    parser.add_option("--loglevel","-l",action="store", dest="log_value",default="info",
                      help = "Specify the level of logging needed. Default level is info")
    parser.add_option("--managed", "-m", action="store_true", default=False, dest="managed_mode",
                      help = "If provided, runs the upgrade from ePO.")
    (options, vsel_versions) = parser.parse_args()
    
    if os.getuid() != 0:
        print ("The script should be invoked as root")
        sys.exit(1)

    # Lets validate the arguments.
    if len(vsel_versions) < 2 :
        print "Invalid arguments. Use --help to find valid usage"
        sys.exit(1)

    if vsel_versions[0] not in VALID_VSEL_KEYS[0: len(VALID_VSEL_KEYS) 1] :
        print("Invalid value %s for START_VERSION\n" % vsel_versions[0])
        sys.exit(1)
    
    # Now whatever follows must be > its previous version.
    for i in xrange(1, len(vsel_versions) -1) :
        if VALID_VSEL_KEYS.index(vsel_versions[i]) <= VALID_VSEL_KEYS.index(vsel_versions[i - 1]) :
            print("Cannot upgrade from %s to %s" % (vsel_versions[i-1] , vsel_versions[i]))
            sys.exit(1)
    
    # For Managed mode upgrade, minimum version is LYNXSHLD1510
    if options.managed_mode and VALID_VSEL_KEYS.index(vsel_versions[0]) == 0 :
        print "Under managed mode the minimum start version is %s" % VALID_VSEL_KEYS[1]
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
    

    logging.info("Upgrade path is %s" % ' '.join(vsel_versions))
    logging.info("Managed mode is " + str(options.managed_mode))
    # All Parameter validations done. Now lets start upgrade process.
    if options.managed_mode :
        logging.debug("Starting the upgrade in the managed mode")
        retval = runManagedUpgrade(vsel_versions, options.log_value)
    else :
        logging.debug("Starting upgrade in unmanaged mode")
        retval = runManualUpgrade(vsel_versions, options.log_value)
    
    if retval != 0 :
        return retval
    
    logging.debug("Completed with upgrade, Running the BVT Now")
    try :
        cmd = ['python', 'BVTDriver.py', '--loglevel='+options.log_value]
        retval = subprocess.call(cmd)
    except :
        logging.error("Exception occured while running the BVT")
        return 1
    return retval

def runManagedUpgrade(vsel_versions, loglevel) :
    """
    Function to upgrade the product in managed mode. 
    The first version specified will be installed and switch to managed mode. 
    Then call the EPO-Upgrade.py on each upgrade version specified. The validation
    of if the upgrade occured or not is completely taken care by EPO-Upgrade.py
    """
    # 1. Install the product of first version
    install_build_path = commonAntiMalwareFns.getBuildFileName('/opt/VSEL/DATA_VSEL/upgrade/' + vsel_versions[0], vsel_versions[0])
    if not install_build_path :
        logging.error("Could not find the build file for %s" % vsel_versions[0])
        return 1 
    os.chdir(testcaseDir + '/Common')
    logging.info("Starting installation of %s " % vsel_versions[0])
    logging.debug("Build file is at : " + install_build_path)
    retval = subprocess.call(['python', 'Install.py', loglevel, install_build_path, vsel_versions[0]])
    if retval == 0:
        logging.debug("Installation successful")
    else :
        logging.error("Installation failed with status : %s" % retval)
        os.chdir(testcaseDir)
        return 1


    # 2. Now shift into managed mode
    # TODO : Change the hard coded path 
    # TODO : Confirm if the machine has got added by getting the system properties.
    path_to_config = '/opt/VSEL/DATA_VSEL/upgrade/epoKeys'
    logging.debug("Turning on the managed mode after successful installation with keys at : " + path_to_config)
    if not commonAntiMalwareFns.setManagedModeOn(path_to_config) :
        logging.error("Could not switch to managed mode with path %s" % path_to_config)
        os.chdir(testcaseDir)
        return 1
    
    # 3. Run the EPO Upgrade script on each Upgrade version specified.
    # NOTE : We simply run the upgrade script. Validation of whether the
    # Upgrade occured correctly or not is part of the EPO-Upgrade.py
    os.chdir(testcaseDir + '/EPO')
    for version in vsel_versions[1:] :
        try :
            logging.debug("Running Upgrade for %s" % version)
            cmd = ['python','EPO-Upgrade.py', loglevel, version]
            retval = subprocess.call(cmd)
            if retval != 0 :
                logging.error("Upgrade failed with status %s" % retval)
                os.chdir(testcaseDir)
                return 1
        except :
            logging.error("Exception occured running the EPO-Upgrade")
            os.chdir(testcaseDir)
            return 1
    os.chdir(testcaseDir)
    return 0   
    
def runManualUpgrade(vsel_versions, loglevel) :
    """
    Function to run the manual upgrade. 
    We will first install the initial version specified. The other versions will
    then be upgraded to.
    NOTE : The validation of if the upgrade occured or not is completely taken care
    by the 'Upgrade.py' script.
    """
    # Install the product of first version.
    install_build_path = commonAntiMalwareFns.getBuildFileName('/opt/VSEL/DATA_VSEL/upgrade/' + vsel_versions[0], vsel_versions[0])
    if not install_build_path :
        logging.error("Could not find the build file for %s" % vsel_versions[0])
        return 1
       
    #install
    os.chdir(testcaseDir + "/Common")
    logging.info("Starting installation")
    retval = subprocess.call([ "python", "Install.py", loglevel, install_build_path, vsel_versions[0]])
    if retval == 0:
        logging.info( "Test Install passed")
    else:
        logging.info("Installation Failed")
        os.chdir(testcaseDir)
        return 1
   
    # Now start the upgrade.
    for version in vsel_versions[1:] :
        try :
            cmd = ['python', 'Upgrade.py', loglevel, version]
            logging.debug("Running the upgrade script for %s" % version)
            retval = subprocess.call(cmd)
            if retval != 0 :
                logging.error("Upgrade to %s returned exit status %s" % (version, retval))
                os.chdir(testcaseDir)
                return 1
        except :
            logging.error("Failed to upgrade to version %s " % version)
            os.chdir(testcaseDir)
            return 1
    os.chdir(testcaseDir)
    return 0


if __name__ == '__main__' :
    retval = main()
    sys.exit(retval)
