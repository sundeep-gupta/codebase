# Copyright (C) 2010 McAfee, Inc.  All rights reserved.

import logging
import sys
import os
import ConfigParser
# Add common folder into the sys path for module importing
sys.path.append("../Common")
sys.path.append("../Antimalware")
import commonFns
import commonAntiMalwareFns

CONFIG_FILE_NAME = 'VSELEnv.conf'
class BaseTest:
    """
    BaseTest is abstract base class for Testcase objects and each
    Testcase class must derive from this class.  If derived class
    do not define any of the functions, an exception of type
    NotImplementedException will be thrown
    """
    def __init__(self):
        pass

    def init(self):
        logging.debug("Checking if user is 'root'")
        if os.getuid() != 0 :
            logging.error("Script must be run as root %d" % os.getuid())
            return 1
        # Don't continue if product not installed.
        logging.debug("Checking if product is installed")
        if not commonAntiMalwareFns.isProductInstalled() :
            logging.error("Product is not installed.")
            return 1
        # Clean the logs so that we only have required data in logs.
        logging.debug("Cleaning the logs")
        commonFns.cleanLogs()
        return 0

    def execute(self):
        raise NotImplementedException("Must be implemented in subclass")

    def verify(self):
        raise NotImplementedException("Must be implemented in subclass")

    def cleanup(self):  
        raise NotImplementedException("Must be implemented in subclass")

    def __del__(self):
        pass

    def getConfig(self, key, section='VSEL_AUTOMATION') :
        # If not loaded then load... 
        logging.debug("Checking if config file is loaded or not")
        if not hasattr(self,'config') or self.config is None :
            scriptPath = os.path.dirname(os.path.abspath(sys.argv[0]))
            while not scriptPath.endswith('Testcases') :
                scriptPath = os.path.dirname(scriptPath)
            scriptPath = scriptPath + '/Common/'
            logging.debug("Reading config file %s " % scriptPath + CONFIG_FILE_NAME)
            self.config = ConfigParser.ConfigParser()
            if scriptPath + CONFIG_FILE_NAME not in self.config.read(scriptPath + CONFIG_FILE_NAME) :
                logging.warn("Failed to read the configuration file. You will not be able to read configuration")
                return None

        if section is None :
            section = 'VSEL_AUTOMATION'
        return self.config.get(section, key)

def setupTestcase(sys_argv):
    """
    Function to setup the testcase like setting up the logging
    with proper settings
    """

    # Check whether user provided debug command line parameter
    if(len(sys_argv) > 1):
        # Parameter provided, set the log level accordingl
        if(sys_argv[1] == "debug"):
            logLevel=logging.DEBUG
        elif(sys_argv[1] == "info"):
            logLevel=logging.INFO
        elif(sys_argv[1] == "warning"):
            logLevel=logging.WARNING
        elif(sys_argv[1] == "error"):
            logLevel=logging.ERROR
        elif(sys_argv[1] == "critical"):
            logLevel=logging.CRITICAL
        else:
            # Set default level
            logLevel=logging.INFO
    else:
        # Set default level
        logLevel=logging.INFO

    # Set log format with time/date, logLevel and message
    logFormat='[%(asctime)s] [%(levelname)s] [%(filename)s::%(funcName)s] %(message)s'

    # Set date format
    logDateFmt='%d %b %H:%M:%S'

    # Set log file name
    _inputDir = os.path.dirname(os.path.abspath(sys.argv[0]))
    
    # Recursively search the path for Logs folder...
    while True:
        _logDir = _inputDir + "/Logs"

        # Logs directory exist?
        if os.path.isdir(_logDir):
            break
        else:
            # Go to parent folder...
            _inputDir = os.path.dirname(_inputDir)

    logFileName = _logDir + "/" + sys.argv[0][:-2]+"log"

    # Set log file mode as write
    logFileMode='w'

    # Now, configure the logging
    logging.basicConfig(level=logLevel,
            format=logFormat,
            datefmt=logDateFmt,
            filename=logFileName,
            filemode=logFileMode) 


