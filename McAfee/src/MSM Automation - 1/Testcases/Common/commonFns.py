# Copyright (C) 2010 McAfee, Inc. All rights reserved

import urllib2
import os
import re
import shutil
import subprocess
import logging
import types
import urllib
import sys
import hashlib
import xml.dom.minidom
import sqlite3
import time

TestTools = {
    'aptt': {
        'dir': '/usr/local/McAfee/AppProtection',
        'tool': 'appProtTestTool'
    },

    'qatt': {
        'dir': '/usr/local/McAfee/AntiMalware',
        'tool': 'QATestTool'
    },

    'fwtt': {
        'dir': '/usr/local/McAfee/Firewall',
        'tool': 'FWTestTool'
    },

}

# Location where the crash logs are found.
CRASH_DIRS = ('/Library/Logs/CrashReporter',
               os.environ['HOME'] + '/Library/Logs/CrashReporter')

# The list of logs to delete.
LOGS = ('/var/log/McAfeeSecurity.log',
        '/var/log/McAfeeSecurityDebug.log',
        '/var/log/install.log',
        '/var/log/system.log',
        '/var/log/kernel.log',
        '/usr/local/McAfee/AppProtection/var/appProt.trace')

def getMD5ForFile(fileName):
    fileH = open(fileName, 'r')
    md5 = hashlib.md5()

    while True:
        data = fileH.readline()
        if not data:
            break
        md5.update(data)

    fileH.close()
    return md5.hexdigest()


# Fn to download a file from a given URL to a destination on the local disk
def downloadFile(url, destination):
    """
    Fn Downloads a given file from url to destination.
    RETURN : True if the download is successful
             False if the download fails
    """

    try:
        _fileOnWeb = urllib2.urlopen(url)
        _output = open(destination, 'wb')
        _output.write(_fileOnWeb.read())
        _output.close()
        return True

    except IOError:
        return False

    except:
        return False

#Fn to mount a dmgFile at the specified mount point.
def mountDMG(dmgFile, mountPt):
    """
    Fn Mounts a dmg at a given mount point
    RETURN : True if the mount is successful
             False if the mount fails
    """
    
    _retval = subprocess.call( [ "hdiutil",
                          "attach",
                           dmgFile,
                           "-mountpoint",
                           mountPt ],
                           stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE)

    if _retval == 0:
        return True
    else:
        return False

#Fn check the specific service is running
def isProcessRunning(process):
    try:
        _cmd = "ps -axc -w -w -o \"command\" | grep -i \"" + process + "\" | grep -v grep > /dev/null; echo $?"
        _p = subprocess.Popen(["/bin/sh", "-c", _cmd], stdout=subprocess.PIPE)
        _result = int(urllib.unquote(_p.stdout.read()))

        if (_result == 0):
            return True
        else:
            return False
    except (ValueError, OSError):
        print 'exception caught in function "isProcessRunning"'
        return False


#Fn is all the Services running 
def areAllServicesRunning(productType="Suite"):
    SuiteServices = ('VShieldScanManager', 'fmpd', 'appProtd', 'FWService', 'cma', 'McAfee Rep', \
                     'VShieldService', 'Menulet', 'VShieldScanner')

    AntimalwareServices = ('VShieldScanManager', 'fmpd', 'cma', 'McAfee Rep', \
                           'VShieldService', 'Menulet', 'VShieldScanner')
    
    if productType == "Antimalware":
        for value in AntimalwareServices:
            if(isProcessRunning(value) == False):
                logging.error(value + " is not running")
                return False
    else:
        for value in SuiteServices:
            if(isProcessRunning(value) == False):
                logging.error(value + " is not running")
                return False
    return True

#Fn do a fast user switching
def addLoginItem(userName, path_to_common, Command):
    """
    Fn to add a login item, given userName and path to TOPS/trunk
    """
    path_to_command = path_to_common + Command
    try:
        Cmd="su -l "+ userName + " -c \"defaults write /Users/" + userName  \
            + "/Library/Preferences/loginwindow AutoLaunchedApplicationDictionary" \
            + " -array-add '<dict><key>Hide</key><false/><key>Path</key><string>" \
            + path_to_command + "</string></dict>'\""
        retVal=subprocess.call(Cmd,shell=True)
        if(retVal != 0):
            logging.error("Error occured while adding a Login item")
            return False
        return True            
    except:
        logging.error("exception caught in function add login item")
        return False

def removeLoginItem():
    """
    Fn to remove already added Login Item
    """
    try:
        applescript = """
        osascript <<-EOF
        activate application "System Preferences"
        tell application "System Events"
            tell process "System Preferences"
            click button "Accounts" of scroll area 1 of window "System Preferences"
            click button "Click the lock to make changes." of window "Accounts"
            tell application "System Events"
                tell process "SecurityAgent"
                    tell window 1
                        tell scroll area 1 of group 1
                            set value of text field 1 to "taf"
                            set value of text field 2 to "test"
                        end tell    
                        click button "OK" of group 2
                    end tell
                 end tell
            end tell     
            click radio button "Login Items" of tab group 1 of window "Accounts"
            select row 1 of table 1 of scroll area 1 of tab group 1 of window "Accounts"
            click button 2 of tab group 1 of window "Accounts"
            end tell
        end tell    
EOF"""
        retval = subprocess.call(applescript, shell=True)
        if retval != 0:
            logging.error("Error occured in removeLoginItem applescript")
            return False
        return True    
    except:
        logging.error("Exception occured in removeLoginItem applescript")
        return False

def fastUserSwitching(userName,passwd) :
    """
    Fn to do fast user switching, given userName and password.
    """
    try:
        process=subprocess.Popen('/usr/bin/id -u "%s"'%userName,shell=True, stdout=subprocess.PIPE)
        _result=process.communicate()
        if(_result[0] == ''):
            os.system("sleep 5")
            logging.error("Could not get user's id")
            return False
        switchCmd = '/System/Library/CoreServices/Menu\\ Extras/User.menu/Contents/Resources/CGSession -switchToUserID "%s" '
        process1=subprocess.Popen([switchCmd %_result[0]], shell=True, stdout=subprocess.PIPE)
        _result1=process1.communicate()
        if(_result1[0] != ''):
            return False
        appleScript = """
        osascript <<-EOF
        set thePassword to "%s"
        delay 3
        tell application "System Events"
        tell process "SecurityAgent" to set value of text field 1 of group 1 of window 1 to thePassword
        click button 2 of window 1 of application process "SecurityAgent"
        end tell
EOF"""
        retval = subprocess.call([appleScript %(passwd)], shell=True)
        if(retval != 0):
            logging.error("Error occured in fast user Switching applescript")
            return False
        return True
    except:
        logging.error("Exception occured in fast user Switching")
        return False

def logOut():
    """
    Fn to logout user	
    """
    logoutAppPath = os.path.dirname(os.path.abspath(sys.argv[0]))\
                    + "/../AppProtection/data/SampleCocoaCarbonApps/logout.app"
    Cmd = "open " + logoutAppPath  
    retval = subprocess.call(Cmd,shell=True)
    if(retval != 0):
        logging.error("Error occured in log Out applescript")
        return False
    return True

def getUniqueId():
    for id in range(501,1000):
        process = subprocess.Popen( ["dscl", 
                                     ".", 
                                     "-search", 
                                     "/Users", 
                                     "uid",
                                     str(id) ], 
                                     stdout=subprocess.PIPE,
                                     stderr=subprocess.PIPE)
        result= process.communicate()
        retval=re.search(str(id),result[0])
        if retval == None:
            return id
    return None
def userExists(username):
    process = subprocess.Popen ( [ "dscl",
                                   ".",
                                   "-search",
                                   "/Users",
                                   "name",
                                   username],
                                   stdout=subprocess.PIPE,
                                   stderr=subprocess.PIPE)
    result= process.communicate()
    retval=re.search(username,result[0])
    if retval == None:
        return False
    return True

def createUser(username,password):
    """
    Fn Creates a user with username and password
    """
    if userExists(username) == True:
        logging.debug("Username already exists")
        return False
    # Create the user
    subprocess.call ( [ "dscl",
                        ".",
                        "-create", 
                        "/Users/"+username ] )
    
    # Set the realname
    subprocess.call ( [ "dscl",
                        ".",
                        "-append", 
                        "/Users/"+username, 
                        "RealName",
                        username ])
    # Set the home directory
    subprocess.call ( [ "dscl",
                        ".",
                        "-append", 
                        "/Users/"+username, 
                        "NFSHomeDirectory",
                         "/Users/"+username ])
    # Set the  user shell
    subprocess.call ( [ "dscl",
                        ".",
                        "-append", 
                        "/Users/"+username, 
                        "UserShell",
                         "/bin/bash"])
    uniqueId=getUniqueId()
    # Set the UID to uniqueId
    subprocess.call ( [ "dscl",
                        ".",
                        "-append", 
                        "/Users/"+username, 
                        "UniqueID",
                        str(uniqueId) ] ) 

    # Set the primary group id to 20 (staff)
    subprocess.call ( [ "dscl",
                        ".",
                        "-append", 
                        "/Users/"+username, 
                        "PrimaryGroupID",
                        "20" ])

    subprocess.call ( [ "dscl",
                        ".",
                        "-append",
                        "/Groups/staff",
                        "GroupMembership",
                        username ])
    # Set the password
    subprocess.call ( [ "dscl",
                        ".",
                        "-passwd", 
                        "/Users/"+username, 
                        password ] )
    subprocess.call( [ "/usr/sbin/createhomedir",
                       "-l",
                       "-u",
                       username ] )

    logging.debug("Creation of user " + username + " successful")
    return True

def createAdminUser(username,password):
    """
    Fn creates an admin user
    """
    if createUser(username,password) == False:
        return False

    subprocess.call ( [ "dscl",
                        ".",
                        "-append",
                        "/Groups/admin",
                        "GroupMembership",
                        username ])
def deleteUser(username):
    """
    Fn Deletes a user with username 
    """
    subprocess.call ( [ "dscl",
                        ".",
                        "-append",
                        "/Groups/staff",
                        "GroupMembership",
                        username ])
    subprocess.call ( [ "dscl",
                        ".",
                        "-append",
                        "/Groups/admin",
                        "GroupMembership",
                        username ])
    subprocess.call ( [ "dscl",
                        "localhost",
                        "-delete", 
                        "/Local/Default/Users/"+username ])
    try:
        shutil.rmtree( "/Users/"+username)
    except:
        logging.error("Deletion of user home folder failed")
    
    return True 
    

def isProductInstalled():
    """
    Fn Checks for presense of product specific files and directories
    RETURN : True if the product is installed
             False if the product is not installed
    """
    _productPaths = ('/usr/local/McAfee',
                     '/Library/Application Support/McAfee',
                     '/Library/Preferences/com.mcafee.ssm.antimalware.plist',
                     '/Library/McAfee/cma')
    
    for _path in _productPaths:
        if (os.path.exists(_path) == False):
            logging.error(_path + " is not present")
            return False  
    return True


def searchProductLog(regex):
    """Search given regex in product log"""
    time.sleep(10)
    return parseFile('/var/log/McAfeeSecurity.log', regex)

def searchProductDebugLog(regex):
    """Search given regex in product's debug log"""
    time.sleep(10)
    return parseFile('/var/log/McAfeeSecurityDebug.log', regex)

def searchInstallLog(regex):
    """Search given regex in install log"""
    time.sleep(10)
    return parseFile('/var/log/install.log', regex)

def searchSystemLog(regex):
    """Search given regex in system log"""
    time.sleep(10)
    return parseFile('/var/log/system.log', regex)

def searchKernelLog(regex):
    """Search given regex in kernel log"""
    time.sleep(10)
    return parseFile('/var/log/kernel.log', regex)

def searchAllLogs(regex):
    """Search all logs for regex """
    time.sleep(10)
    for log in LOGS :
        if parseFile(log, regex) == True :
            return True
    return False

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

def installTestTool(tool_name, src_dir):
    """Install the Test tool.

    Checks if the given 'tool_name' is configured in 'TestTools' dictionary. If
    configured, copies the 'FMConfig.xml' of tool to fmp config directory and
    copies test tool to the directory configured in 'TestTools' dictionary.

    @param tool_name - string representing the tool to be installed
    @param src_dir - string representing the directory where the tool is available
    @return True if success. None if failed.
    NOTE: for any parameter validation failure, the return is "None"
    If the test-tool is already installed, nothing is done.
    """
    # Validate the parameter.
    if (not isinstance(tool_name, str) or tool_name not in TestTools):
        logging.error("Invalid parameters passed to installTestTool")
        return None
    if (not isinstance(src_dir, str) or not os.path.isdir(src_dir)):
        logging.error("Invalid parameters passed to installTestTool, dir does not exist")
        return None
    # If already installed, return.
    if os.path.isfile('/usr/local/McAfee/fmp/config/' + tool_name + '/FMConfig.xml'):
        logging.debug(tool_name + " Already installed")
        return True
    
    try:
        if os.path.isdir('/usr/local/McAfee/fmp/config/'+tool_name) == False :
            os.mkdir('/usr/local/McAfee/fmp/config/' + tool_name, 0755)

        # Copy the FMConfig.xml file and change permissions
        _src_file = src_dir  + '/FMConfig.xml'
        _dst_file = '/usr/local/McAfee/fmp/config/' + tool_name + '/FMConfig.xml'
        if (not os.path.isfile(_src_file)):
            return None
        shutil.copy(_src_file, _dst_file)
        os.chmod(_dst_file, 0700)

        # Now reload the fmp
        _p = subprocess.Popen(["/usr/local/McAfee/fmp/bin/fmp", "reload"], stdout=subprocess.PIPE)
        _p.wait()
        if _p.returncode == 0:
            return True
    except OSError:
        logging.error("Received OS Error")
        return None
    except IOError:
        logging.error("Received IO Error")
        return None
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

def setXMLValueinFile(traceFile, tagname, traceVal):
    """ Fn to set the xml value of a given tag in the xml file """
    if os.path.isfile(traceFile):
        _DOMTree = xml.dom.minidom.parse(traceFile)
        _node1 = _DOMTree.getElementsByTagName(tagname)[0]
        _node1.firstChild.data = traceVal
        logging.debug("Changed the value of %s to %s in %s" %(tagname,str(traceVal),traceFile))
    else:
        logging.error("File not found: %s" % traceFile)
        return False
    try:
        fileH = open(traceFile, 'w')
        _DOMTree.writexml(fileH)
        fileH.close()
        return True
    except:
        return False

def getRecentEvents():
    """
        Fetches & returns rows from recentEvents table of FMP database
        @return - array of list where each list element represents a row in the
                  table.
                  None if there is any exception in fetchng the rows.
    """
    try :
        conn = sqlite3.connect("/usr/local/McAfee/fmp/var/FMP.db")
        c = conn.cursor()
        c.execute("select * from recentEvents")
        return c.fetchall()
    except:
        logging.error("Exception occured while retrieving the rows")
        return None

def getHistory():
    """
        Fetches & returns rows from reports table of FMP database
        @return - array of list where each list element represents a row in the
                  table.
                  None if there is any exception in fetchng the rows.
    """
    try :
        conn = sqlite3.connect("/usr/local/McAfee/fmp/var/FMP.db")
        c = conn.cursor()
        c.execute("select * from reports")
        return c.fetchall()
    except:
        logging.error("Exception occured while retrieving the rows")
        return None

