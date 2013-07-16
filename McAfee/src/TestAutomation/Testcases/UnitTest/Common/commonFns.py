# Copyright (C) 2010 McAfee, Inc. All rights reserved

import urllib2
import os
import re
import shutil
import subprocess
import logging
import types
import sys
import stat

# Location where the crash logs are found.
# Checking of the env 'HOME' key in Dictionary is done here since STAF 
# process is launched by launchd and env HOME will not be set causing 
# this script to fail.
# Assign this dir initially for CRASH_DIRS
CRASH_DIRS = ['/Library/Logs/CrashReporter']
home_key = os.environ
if home_key.has_key('HOME'):
   Users_Home = os.environ['HOME'] 
   CRASH_DIRS = ['/Library/Logs/CrashReporter',
                 Users_Home + '/Library/Logs/CrashReporter']
else:
   if os.path.isdir('/Users/taf'):
      Users_Home = '/Users/taf/'
      CRASH_DIRS = ['/Library/Logs/CrashReporter',
                    Users_Home + '/Library/Logs/CrashReporter']

# The list of logs to delete.
LOGS = ('/var/log/McAfeeSecurity.log',
        '/var/log/McAfeeSecurityDebug.log',
        '/var/log/install.log',
        '/var/log/system.log',
        '/var/log/kernel.log',
        '/usr/local/McAfee/AppProtection/var/appProt.trace')


# Fn to download a file from a given URL to a destination on the local disk
def downloadFile(url, destination):
    """
    Fn Downloads a given file from url to destination.
    RETURN : True if the download is successful
             False if the download fails
    """

    try:
        logging.info(url)
	_fileOnWeb = urllib2.urlopen(url)
        _output = open(destination, 'wb')
        _output.write(_fileOnWeb.read())
        _output.close()
        return True
    except IOError:
        return False

    except:
        return False


def installUTFiles(zipFileName, targetDirectory):
    """
    Fn Installs the given zip file to given target directory.
    RETURN : True if unzip is successful
             False if unzip fails
    """

    # Validation for input parameters.
    if (zipFileName == None or type(zipFileName) != types.StringType or not os.path.isfile(zipFileName)
        or targetDirectory == None or type(targetDirectory) != types.StringType or not os.path.isdir(targetDirectory)):
       return False

    _retVal = True
    try:
        _cmd = "tar -zxvf " + zipFileName + " -C " + targetDirectory
        _retVal = subprocess.call(_cmd, shell=True)
    except:
        _retVal = False

    return _retVal


def setupUT(zipFileURL):
    """
    Fn Setup the UT given the http zip URL path.
    RETURN : True if successful
             False if fails
    """
   
    _regexURL = "http://"
    _localDir = os.path.dirname(os.path.abspath(sys.argv[0]))
    _coverageEnvFile="/private/etc/BullseyeCoverageEnv.txt"
    _logDir = _localDir + "/../../Logs/"

    # Check whether given input is URL...
    if re.search(_regexURL, zipFileURL) != None :
        logging.debug("testZipPath is a 'url'")
    else:
        logging.error("Expected url zip path but not found...")
        return 1

    # Split the URL into parent and leaf name...
    _i = zipFileURL.rfind("/")
    _utZipFileName = zipFileURL[_i+1:]
    _zipFileURLPath = zipFileURL[:_i]
        
    logging.debug("File name is " + _utZipFileName)
    logging.debug("File path is " + _zipFileURLPath)

    # If zip file already exists, it means the zip file is already downloaded for other test binaries...
    if os.path.exists(_localDir + '/' + _utZipFileName):
        logging.info("UT zip file already exists")
    else:
        # Zip file not found locally, download the file...
        if downloadFile(zipFileURL, _localDir + '/' + _utZipFileName) == False:
            logging.info("Downloading from " + zipFileURL + " failed")
            return 1
        logging.debug("Downloading the zipFileURL succeeded")

    # Check for existence of cov file for instrumented coverage processing...
    _j = _utZipFileName.rfind("-")
    _k = _utZipFileName[:_j-1].rfind("-")
    _covFileName  = _utZipFileName[:_k] + _utZipFileName[_j:]
    _covFileName = _covFileName.replace(".tar.gz", ".cov")

    _covFileURLPath = zipFileURL.replace(_utZipFileName, _covFileName)
    logging.debug("Coverage file URL to be tested is " + _covFileURLPath)

    _covFilePath = os.path.abspath(_logDir + _covFileName)

    if os.path.exists(_covFilePath):
        logging.info("Cov file already exists")
    else:
        # Now, download the cov URL into the local machine...
        # The logs directory was chosen so that after the entire UT is run, the code coverage
        # measurements will be stored in the logs directory and it will be automatically picked
        # by the TAF server...
        if downloadFile(_covFileURLPath, _covFilePath) == False :
            logging.info("Downloading from " + _covFileURLPath + " Failed")

        else:        
            logging.debug("Downloading the cov file Succeeded")

            os.chmod(_covFilePath, stat.S_IRWXU | stat.S_IRWXG | stat.S_IRWXO)
          
            # Dump the local cov path into the BullseyeCoverageEnv.txt file so that
            # code coverage measurement will start...
            fd = open(_coverageEnvFile, "w")

            # Write COVFILE=<local-cov-file-path> into the file...
            fd.write("COVFILE=" + _covFilePath)
            fd.close()

            # Give full permissions to the file...
            os.chmod(_coverageEnvFile, stat.S_IRWXU | stat.S_IRWXG | stat.S_IRWXO)

    # Install the UT binaries locally...
    logging.info("Installing the UT binaries locally...")
    _retVal = installUTFiles(_localDir + '/' + _utZipFileName, "/")

    if _retVal != 0 :
        logging.error("Failed to install UT files...")
        return 1

    logging.info("Successfully copied UT files locally...")
    return 0

def cleanupUT():
    """
    Fn Removes all the UT files after the unit test is done.
    RETURN : True if cleanup is successful
             False if cleanup fails
    """
    _utPaths = ('/usr/local/McAfee',
                '/Library/Frameworks/ScanBooster.framework',
                '/Library/Frameworks/VirusScanPreferences.framework')

    _retVal = False

    try:
        for _path in _utPaths:
            if (os.path.exists(_path) == True):
                shutil.rmtree(_path)
                logging.info("UT folder : " + _path + " removed successfully")
    except:
       _retVal = False

    return _retVal


def parseFile(file_name, regex):
    """
    Fn scans the file to check if the string that matches the regular expression
    provided exist or not.
    RETURN : True if the pattern is matched.
             False if there is no match
                or if the arguments are incorrect.
    """

    # Validation for input parameters.
    if (file_name == None or type(file_name) != types.StringType
        or not os.path.isfile(file_name)
        or regex == None or type(regex) != types.StringType or regex == ''):
        return False

    try:
        fh = open(file_name, "r")

        # Read line by line and check if line matches
        # with the regex. Return true for first match
        for line in fh:
            if (re.search(regex, line) != None):
                return True
    except:
        return False
    finally:
        fh.close()

    return False


def cleanLogs():
    """
    Method to truncate the logs.
    RETURN : True if truncating is successful.
             False if any of the file truncation failed.
    """
    _retval = True
    for log in LOGS:
        try:
            f = open(log, "w")
            f.close()
        except:
            # Just move on to next file if one fails.
            _retval = False
    # Give HUP to syslogd
    _retval = subprocess.call("killall -1 syslogd", shell=True)
    
    # Walk through the directory and copy crash and logs
    for _crash_dir in CRASH_DIRS:
        os.path.walk(_crash_dir, _cleanLog, [])

    return _retval


def _cleanLog(arg, dirname, fnames):
    """Callback function called by os.path.walk for truncating crash logs.
    Files which ends with .crash | .log | .panic are moved.
    """
    for file in fnames:
        filepath = dirname + "/" + file
        if os.path.isfile(filepath) and \
            re.search("\.(crash|log|panic)$", file) is not None:
            try:
                if os.path.islink(filepath):
                    filepath = os.path.realpath(filepath)
                    # delete symlink also
                    os.remove(dirname + "/" + file)

                # Delete the Crash
                os.remove(filepath)

            except:
                # Ignore the exception and continue with next file
                pass


def copyLogs():
    """Copies logs to the directory specified.

    Copies the product and system related logs to the ../logs/<TC_NAME> directory.
    If the log is a 'crash' it will be deleted from original location, other
    files are truncated.

    @return True if logs are copied successfully. None otherwise.
    """
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
        
                
    _dir = _logDir + "/" + os.path.basename(sys.argv[0])[:-3]

    if not os.path.isdir(_dir) :
        os.mkdir(_dir)

    for log in LOGS:
        try:
            shutil.copy(log, _dir)
        except:
            pass
    # Walk through the directory and copy crash and logs
    retval = 0
    arg = [_dir, retval]
    for _crash_dir in CRASH_DIRS:
        os.path.walk(_crash_dir, _copyLog, arg)
    return arg[1]


def _copyLog(arg, dirname, fnames):
    """Callback function called by os.path.walk for copying crash logs.
    Files which ends with .crash | .log | .panic are moved.
    """
    for file in fnames:
        filepath = dirname + "/" + file
        if os.path.isfile(filepath) and \
            re.search("\.(crash|log|panic)$", file) is not None:
            try:
                if os.path.islink(filepath):
                    filepath = os.path.realpath(filepath)

                shutil.copy(filepath, arg[0] + "/" + file)
                # If file is a crash or panic file, set retval to '1'
                if re.search('\.(crash|panic)$', file) is not None:
                    arg[1] = 1
            except:
                # Ignore the exception and continue with next file
                pass


def enableDebugLog():

    try:
        _src_file="/etc/syslog.conf"
        _dst_file=_src_file+"_old"

        shutil.copy(_src_file,_dst_file)
        _output=open(_src_file,"a")
        _output.write("local7.*                        "+"/var/log/McAfeeSecurityDebug.log")
        _output.close()
        logging.debug("SysLog is edited with Debug option")
        return True

    except IOError:
        return False

    except:
        return False


def disableDebugLog():
    try:
        _src_file="/etc/syslog.conf"
        _dst_file=_src_file+"_old"
        shutil.move(_dst_file,_src_file)
        logging.debug("SysLog is reverted to original")
        return True
    except IOError:
            return False

    except:
            return False

