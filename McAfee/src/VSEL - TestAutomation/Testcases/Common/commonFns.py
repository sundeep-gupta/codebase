# Copyright (C) 2010 McAfee, Inc. All rights reserved

import urllib2
import os
import re
import subprocess
import logging
import types
import urllib
import sys
import hashlib
import xml.dom.minidom
import time
import shutil
import tarfile

CRASH_DIRS   = ['/var/opt/NAI/LinuxShield/log']
SYSTEM_LOG   = '/var/log/syslog'
MESSAGES_LOG = '/var/log/messages'
LOGS         =  [ MESSAGES_LOG, SYSTEM_LOG ]
CONFIG_FILE_NAME = 'VSELEnv.conf'
def getAllFileSystemPartitions():
    """ Function returns a dictionary of 'type':'partition' elements
    
    It parses the mount command output and generates the hash where 
    key is the 'file sytem type' and value is the partition. This 
    makes sure that if there are multiple partition with same file system
    we test only on one.
    """
    try :
        _p = subprocess.Popen(['mount'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if not _p :
            logging.error("mount failed to create process")
            return None
        _p.wait()
        _lines = _p.stdout.readlines()
        _fs = dict()
        for _l in _lines :
            _m = re.search('^/dev/\S+\s+on\s+(.*)\s+type\s+(.*?)\s+\(rw', _l)
            if _m :
                _partition = _m.group(1)
                _type = _m.group(2)
                _fs[_type] = _partition
        return _fs
    except :
        logging.error("mount failed with exception")
        return None

def getUserInfo(userName):
    """
    Function to return the dict of user Information
    NOTE: For now function runs the 'id' command and 
    returns the dict of key/value like in 'uid=0 gid=0' the keys will be uid and gid
    and values are 0 and 0 respectively (All values are str)
    """
    if userName is None or not isinstance(userName, str) :
        logging.error("Invalid argument for userName")
        return None
    try :
        logging.debug("Running the id command")
        _p = subprocess.Popen(['id', userName], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        _p.wait()
        _stdout = _p.stdout.readlines()
        if len(_stdout) != 1 :
            logging.error("Could not get the id result")
            return None
        _id = _stdout[0]
        _info = _id.split(' ')
        _dict = {}
        for _i in _info :
            k, v = _i.split('=', 2)
            m = re.search('^(\d+)', v)
            if m :
                _dict[k] = m.group(1)
        return _dict
    except :
        logging.error("Error Running the 'id' command")
        return 1
def createUser(userName, groupId='0') :
    """
    Function to create user
    """
    try :
        _retval = subprocess.call([ 'useradd', userName, '-g' , groupId], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if _retval != 0 :
            logging.error("Failed to create user")
            return False
    except :
        logging.error("Failed to create user")
        return False
    return True

def deleteUser(userName) :
    """
    Function to delete user
    """
    try :
        _retval = subprocess.call(['userdel', userName], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if _retval != 0 :
            logging.error("Failed to create user")
            return False
    except :
        logging.error("Failed to create user")
        return False
    return True

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
        syslog = 'syslogd'
        if getOSDetails()['os_name'] == 'Ubuntu' :
            syslog = 'rsyslogd'
        _retval = subprocess.call("killall -1 "  + syslog , shell=True)

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
def copyLogs() :
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

    _dir = _logDir + "/" + sys.argv[0][:-3]
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

def getMD5ForFile(fileName):
    """
    Fn to calculate the md5 value of the given file.
    @param : filename - name of the file for which md5 is to be calculated.
    @return md5 value of the file
    """
    if fileName is None or not os.path.exists(fileName) or not os.path.isfile(fileName) :
        logging.debug("getMD5ForFile : Invalid argument provided")
        return None
    fileH = open(fileName, 'r')
    md5 = hashlib.md5()

    while True:
        data = fileH.readline()
        if not data:
            break
        md5.update(data)

    fileH.close()
    return md5.hexdigest()


def downloadFile(url, destination):
    """
    Fn Downloads a given file from url to destination.
    RETURN : True if the download is successful
             False if the download fails
    """

    try:
        _fileOnWeb = urllib2.urlopen(url)
        _output = open(destination, 'wb')
        while True :
            _block_size = 1024 * 1024
            _block = _fileOnWeb.read(_block_size)
            if _block and len(_block) > 0 :
                _output.write(_block)
            else :
                break
        return True

    except IOError, e:
        logging.error(str(e))
        return False
    except:
        return False
    finally :
        _output.close()


def isProcessRunning(process):
    """
    Fn check the specific service is running
    @param process - name of the process to check for
    @return True if process is running. False otherwise.
    """
    try:
        _cmd = ['/bin/sh', '-c', 'ps -axc -w -w -o "command"']
        _p = subprocess.Popen(_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if _p is None :
            logging.error("Failed to run 'ps'")
            return False
        _p.wait()
        _stdout = _p.stdout.readlines()
        _result = 0
        for _line in _stdout :
            _line = _line.rstrip("\n")
            if _line == process :
                _result = _result + 1
        if (_result == 0):
            return False
        else:
            return True
    except (ValueError, OSError):
        logging.error('exception caught in function "isProcessRunning"')
        return False


def searchSystemLog(regex):
    """Search given regex in system log"""
    time.sleep(10)
    return parseFile(SYSTEM_LOG, regex) or parseFile(MESSAGES_LOG, regex)

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
        logging.error("Invalid argument passed to parseFile")
        return False

    try:
        logging.debug("opening file : %s " % file_name)
        fh = open(file_name, "r")
        if fh is None :
            logging.error("Failed to open file ")
            return False
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

def getOSDetails():
    """
    Fn to find the os name
    NOTE: Implemented as per VSEL/pkg/setup.sh::getOsVer() function
    """
    _os_details = {'os_name':'unknown', 'os_version' : os.uname()[3], 'kernel_version' : os.uname()[2] , 'bits' : '32'}
    bits = os.uname()[4]
    if bits.endswith('64') :
        _os_details['bits'] = '64'
    # For Mandrake
    if os.path.exists('/etc/mandrake-release') :
        _os_details['name'] = 'Mandrake'
        _lines = _readFile('/etc/mandrake-release')
        if _lines is None:
            return None
        for _line in _lines :
            _m = re.search('^Mandrake', _line)
            if _m is not None :
                _tokens = _m.group(1).split(' ')
                if len(_tokens) >= 4 :
                    _os_details['os_version'] = _tokens[3]
                    break
    elif os.path.exists('/etc/fedora-release') :
        _os_details['os_name'] = 'Fedora'
        _lines = _readFile('/etc/fedora-release')
        if _lines is None :
            return None

        for _line in _lines :
            _m = re.search('^Fedora release', _line)
            if _m is not None :
                _tokens = _m.group(0).split(' ')
                _os_details['os_version'] = _tokens[ len(_tokens) - 2 ]
    
    elif os.path.exists('/etc/redhat-release') :
        _os_details['os_name'] = 'Redhat'
        _lines = _readFile('/etc/redhat-release') 
        if _lines is None :
            return None

        for _line in _lines :
            _tokens = _line.split(' ')
            if re.search('^Red Hat Linux Advanced Server', _line) is not None :
                _os_details['os_version'] = _tokens[ len(_tokens) - 2 ]
            elif re.search('^Red Hat Enterprise Linux', _line) is not None and len(_tokens) >= 5:
                _os_details['os_version'] = _tokens[ len(_tokens) - 2 ] + _tokens[4]
            elif re.search('^Enterprise Linux Enterprise Linux', _line) is not None and len(_tokens) >= 5 :
                _os_details['os_version'] = _tokens[ len(_tokens) - 2 ] + _tokens[4]
            elif re.search('^CentOS', _line) is not None and len(_tokens) >= 5 :
                _os_details['os_version'] = _tokens[ len(_tokens) - 2 ] + _tokens[4]
            elif re.search('^Red Hat', _line) is not None and len(_tokens) >= 5 :
                _os_details['os_version'] = _tokens[ len(_tokens) - 2 ] 
    elif os.path.exists('/etc/SuSE-release') :
        _os_details['os_name'] = 'SuSE'
        _lines = _readFile('/etc/SuSE-release')
        if _lines is None :
            return None

        for _line in _lines :
            _tokens = _line.split(' ')
            if re.search('^SuSE SLES-', _line) is not None :
                _os_details['os_version'] = _tokens[1][6:]
            elif re.search('^SuSE', _line) is not None :
                _os_details['os_version'] = _tokens[2]
            elif re.search('^SUSE LINUX Enterprise Server', _line) is not None :
                _os_details['os_version'] = _tokens[4]
            elif re.search('^SUSE Linux Enterprise Server', _line) is not None :
                _os_details['os_version'] = _tokens[4]
            elif re.search('^Novell Linux Desktop', _line) is not None :
                _os_details['os_version'] = _tokens[3]
    elif os.path.exists('/etc/lsb-release') :
        _os_details['os_name'] = 'Ubuntu'
        _lines = _readFile('/etc/lsb-release')
        if _lines is None :
            return None
        for _line in _lines :
            _m = re.search('^DISTRIB_RELEASE=(.*)$', _line)
            if _m is not None :
                _os_details['os_version'] = _m.group(1)
                break
    return _os_details

def getKernelVersion() :
    """
    Get the kernel version of linux os.
    """
    return os.uname()[2]

def umount(mountpt) :
    """
    Fn to unmount the given mountpoint.
    @return True if the successfully able to unmount.
    False otherwise.
    """
    if mountpt is None or not isinstance(mountpt,str) :
        logging.error("commonFns.unmount : Invalid argument for unmount")
        return False
    if not os.path.ismount(mountpt) :
        logging.error("commonFns.unmount : %s is not a mountpoint " % mountpt)
        return False
    try :
        _retval = subprocess.call(['umount', mountpt], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if _retval != 0 :
            logging.error("commonFns.unmount : umount failed with return code %s " % _retval)
            return False
        return True
    except :
        logging.error("commonFns.unmount : umount failed with exception")
        return False

def mount(params) :
    """
    Fn to mount the source to given mountpoint with specified file system type.
    @params : params - dict containing options and arguments for 'mount' command.
              keys for the dict are :
              o 'type' - for type of file system
              o 'source' - source which is getting mounted
              o 'mountpt' - mount point where the resource will get mounted.
              o 'username' - username for authentication (optional, must for smbfs/cifs)
              o 'password - password (optional, must for smbfs/cifs)
    @return : True if successfully mounted. False otherwise.
    """
    if params is None or not isinstance(params, dict):
        logging.error("commonFns.mount : Invalid argument. params must be a dict")
        return False
    if not params.has_key('type') or not isinstance(params['type'], str) or len(params['type']) == 0 :
        logging.error("commonFns.mount : params must have a key 'type' which must specify the type of file system")
        return False

    if not params.has_key('source') or not isinstance(params['source'], str) or len(params['source']) == 0 :
        logging.error("commonFns.mount : params must have a key 'source' which must specify the source of device")
        return False

    if not params.has_key('mountpt') or not isinstance(params['mountpt'], str) or len(params['mountpt']) == 0 :
        logging.error("commonFns.mount : params must have a key 'mountpt' which must specify the mount point")
        return False
    option = ''
    if params['type'] in ['smbfs', 'cifs'] : 
        if not os.path.exists('/sbin/mount.smbfs') and not os.path.exists('/sbin/mount.cifs') :
            logging.error("Could not find /sbin/mount.smbfs or /sbin/mount.cifs. Returning without mount")
            return False
        if not os.path.exists('/sbin/mount.smbfs') and params['type'] == 'smbfs':
            logging.debug("/sbin/mount.smbfs not found. replacing smbfs with cifs")
            params['type'] = 'cifs'
        if not params.has_key('username') or not isinstance(params['username'], str) or len(params['username']) == 0 :
            logging.error("commonFns.mount : 'username' not provided")
            return False
        if not params.has_key('password') or not isinstance(params['password'], str) or len(params['password']) == 0 :
            logging.error("commonFns.mount : 'password' not provided")
            return False
        option = 'username=' + params['username'] + ',password=' + params['password']
        _cmd = ['mount', '-t', params['type'], "//" + params['source'] + "/" + params['share'], params['mountpt'], '-o', option]
    elif params['type'] in ['nfs'] :
        _cmd = ['mount', '-t', params['type'], params['source'] + ":/" + params['share'], params['mountpt']]

    try :
        if not os.path.isdir(params['mountpt']) :
            os.mkdir(params['mountpt'])
        logging.debug("commonFns.mount : Running mount command" + ' '.join(_cmd))
        _retval = subprocess.call(_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if _retval != 0 :
            logging.error("commonFns.mount : mount command failed with error code %s " % _retval)
            return False
        return True
    except :
        logging.error("commonFns.mount : mount command failed with exception")
        return False

def _readFile(filename) :
    """
    Fn to read the file and return the content as list.
    """
    _fh = open(filename, 'r')
    if _fh is None :
        logging.error('Failed to open release file to find OS details')
        return None
    _lines = _fh.readlines()
    _fh.close()
    return _lines


def UnInstall(packagename) :
    """Fn to Uninstall the packages
    """
    try:
        _value = getOSDetails()
        _cmd = ['rpm', '-e', packagename]
        if _value['os_name']  is 'Ubuntu' :
            _cmd = ['dpkg', '-r', packagename]
        
        _retval = subprocess.call(_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if _retval != 0:
            logging.error('uninstallation failed')
            return False
        return True

    except :
        logging.error("UnInstallation failed with exception")
        return False


def install(packagename) :
    """Fn to install the packages
    """
    try:
        _value = getOSDetails()
        _cmd = ['rpm', '-ivh', packagename]
        if _value['os_name']  is 'Ubuntu' :
            _cmd = ['dpkg', '-i', packagename]
        _retval = subprocess.call(_cmd) # , stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if _retval != 0:
            logging.error('Installation failed')
            return False
        return True

    except :
        logging.error("Installation failed with exception")
        return False


#To chcek if it is required            
def extractArchive(archive, destination):
    """
    Extarct the build in the destination
    """
    if archive is None or not isinstance(archive, str) :
        logging.error("archive must be an existing tar.gz compressed file")
        return False
    if destination is None or not isinstance(destination, str) :
        logging.error("Invalid argument for destination")
        return False

    if not os.path.exists(archive) :
        logging.error("Archive %s does not exist" % archive)
        return False

    if not os.path.isdir(destination) :
        logging.error("%s must be a directory")
        return False
    try :
        logging.debug("Unarchiving the file %s to %s" % (archive, destination))
        tar = tarfile.open(archive, 'r:gz')
        tar.extractall(path=destination)
    except :
        logging.error("Exception occured unarchiving the file")
        return False
    return True

def upgradeTo(package_file):
    """
    Upgrades the LinuxShield to the given buildpath
    """
    if not package_file or not os.path.exists(package_file) :
        logging.error("Invalid path provided for upgrade")
        return False
    cmd = ['rpm', '--upgrade', package_file]
    if package_file.endswith('.deb') :
        cmd = ['dpkg', '-i', package_file]
    try :
        p = subprocess.Popen(cmd) #, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        p.wait()
    except :
        logging.error("Unable to run the command")
        return False
    return True


def getBuildFileName(build_loc, version) :
    """
    Function to return the build file from the location, according to version specified and
    architecture of the machine.
    
    """
    if not os.path.isdir(build_loc) :
        logging.error("%s must be a directory containing the build" % build_loc)
        return None
    regex = '^McAfeeVSEForLinux-\d\.\d\.\d-\d+-release\.noarch\.tar\.gz$'

    # For 1.5 and 1.5.1 we need to take builds as per the architecture 32 bit / 64 bit
    if VALID_VSEL_KEYS.index(version) < 2 :
        regex = '^LinuxShield-\d\.\d\.\d-\d+-release\.i386\.gz$'
        if re.search('64', os.uname()[4]) :
            regex = '^LinuxShield-\d\.\d\.\d-\d+-release\.x86_64\.gz$'
    logging.debug("Checking for file matching the regular expression %s in directory %s" % (regex, build_loc))        
    entries = os.listdir(build_loc)
    for entry in entries :
        logging.debug("Checking %s" % entry)
        if re.search(regex, entry) :
             return build_loc + '/' + entry
    return None



