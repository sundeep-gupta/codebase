# Copyright (C) 2010 McAfee, Inc. All rights reserved
# -*- coding: utf-8 -*-
import urllib
import subprocess
import os.path
import sys
import time
import decimal

# Import CommonTest module into current namespace
common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/../"
sys.path.append(common_path + "/Common")


import commonFns
import re
import subprocess
import logging
# Constants used in getter / setter methods of preferences of appProt.
APPLE_SIGNED_BINARIES = "AllowAppleSignedBinaries"
APP_PROT_STATUS = 'EnableAppProtection'
PROMPT_TIMEOUT = 'PromptTimeout'
UNKNOWN_APP_ACTION = "UnknownAppAction"
APTT_PATH = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/aptt/appProtTestTool"
# App Protection error codes exactly as used by the product
APP_PROTECTION_ERROR_RANGE_START = 20000
SUCCESS                        = 20000 
SYSTEM_ERROR                   = 20001
TIMEOUT                        = 20002
INVALID_PARAM                  = 20003
KEXT_LOAD_ERROR                = 20004
KEXT_UNLOAD_ERROR              = 20005
KEXT_CONNECT_ERROR             = 20006
KEXT_HOOK_ERROR                = 20007
KEXT_UNHOOK_ERROR              = 20008
KEXT_PING_ERROR                = 20009
KEXT_EXCL_FLUSH_ERROR          = 20010
KEXT_EXCL_ADD_ERROR            = 20011
KEXT_TIMEOUT_ERROR             = 20012
PROC_NAME_NOT_FOUND            = 20013
DUPLICATE_ENTRY                = 20014 
ENTRY_NOT_FOUND                = 20015 
DISABLED_RULE                  = 20016
CONFLICTING_ENTRY              = 20017 
APP_MODIFIED                   = 20018
INCOMEPLETE_INITIALISATION     = 20019
FILE_NOT_FOUND                 = 20020
NOT_A_VALID_EXECUTABLE         = 20021 
PREFERENCES_ERROR              = 20022
PID_NOT_FOUND                  = 20023
UNLINCENSED                    = 20024
INVALID_ERROR                  = 20025 

# Regular Expressions used to search the logs
REGEX_DENIED_RULE = "Denied .+ because\s+of\s+profile\s+rule\s+match"
REGEX_DENIED_UNKNOWN_APP = "Denied .+ from\s+executing\s+because\s+unknown\s+applications\s+are\s+blocked\s+as\s+per\s+the\s+settings"
def setAppProtTimeout(sec):
    """Sets the AppProt Timout using QATT.
    @param sec - Integer representing the timout in seconds.
    @return: True if timeout is set successfully. False Otherwise.
             'None' if failed to run the command.
    NOTE: For validation failures also 'None' is returned.
    No validation for range of valid timeout is done.
    """
    # parameter must be integer
    if not isinstance(sec,int):
        return False

    # Run the QATT Command to set the timout.
    _preferences = _getAppProtPreferences()
    if _preferences is not None :
        _preferences[PROMPT_TIMEOUT] = sec
        return _setAppProtPreferences(_preferences)

    # Return False if we fail to get preferences.
    return False

def getAppProtTimeout():
    """Get the timeout period of appProt.

    @return timout value of appProt.
    """
    _preferences = _getAppProtPreferences()
    if (_preferences is not None and PROMPT_TIMEOUT in _preferences):
        return _preferences[PROMPT_TIMEOUT]

    return False

def isAppProtEnabled():
    """Check if Application protection is enabled or not.

    @return True if AppProtection is enabled, False if disabled, and None for
    if unable to determine.
    """
    _preferences = _getAppProtPreferences()
    if (_preferences is not None and APP_PROT_STATUS in _preferences) :
        if _preferences[APP_PROT_STATUS] == 1 :
            return True
    return False

def disableAppProt():
    """Disables the application protection."""
    # Get current preferences, Modify the UnknonAppAction and set preferences.
    _preferences = _getAppProtPreferences()
    if _preferences is not None :
        _preferences[APP_PROT_STATUS] = 0
        return _setAppProtPreferences(_preferences)

    # Return False if we fail to get preferences.
    return False

def enableAppProt():
    """Enables the application protection."""
    # Get current preferences, Modify the UnknonAppAction and set preferences.
    _preferences = _getAppProtPreferences()
    if _preferences is not None :
        _preferences[APP_PROT_STATUS] = 1
        return _setAppProtPreferences(_preferences)

    # Return False if we fail to get preferences.
    return False

def getUnknownAppAction():
    """Returns the UnknonAppAction.

    @return The value for Unknonw App Action (1, 2 or 3). Returns 'None' if
    failed to determine the action.
    """

    _preferences = _getAppProtPreferences()
    if _preferences is not None and UNKNOWN_APP_ACTION in _preferences :
        return _preferences[UNKNOWN_APP_ACTION]
    return False

def setUnknownAppAction(action):
    """Sets unknown applications action for application protection.

    @param action - integer representing the action to be set.
                    Valid values are 1, 2, 3
    @return True if action is succesfully set. False otherwise.
    """
    if not isinstance(action, int) or action < 1 or action > 3:
        logging.error("Invalid parameters passed to setUnknownAppAction")
        return False

    # Get current preferences, Modify the UnknonAppAction and set preferences.
    _preferences = _getAppProtPreferences()
    if _preferences is not None :
        _preferences[UNKNOWN_APP_ACTION] = action
        return _setAppProtPreferences(_preferences)

    # Return False if we fail to get preferences.
    return False
def allowAppleSignedBinaries(allow = True):
    """Allow AppleSigned binaries to run.

    @param - True if apple signed binaries are to be enabled
             False for not allowing apple signed binaries.

    @return 'True' if successful 'False' otherwise
    """
    _preferences = _getAppProtPreferences()
    if _preferences is not None :
        _preferences[APPLE_SIGNED_BINARIES] = (0,1)[allow]
        return _setAppProtPreferences(_preferences)

    # Return false if we fail to get preferences.
    return False
#Fn Check whether Apple signed binaried are allowed or not.
def isAppleSignedBinariesAllowed():
    """Returns the status for apple signed binaries.

    @return True if enabled, False otherwise.
    """
    _preferences = _getAppProtPreferences()
    if (_preferences is not None and APPLE_SIGNED_BINARIES in _preferences) :
        if _preferences[APPLE_SIGNED_BINARIES] == 1 :
            return True
    return False


#Fn Clear all Application Protection Exclusions.
def clearAppProExclusions():
    try:
        _cmd = APTT_PATH + " 20007"
        retVal = subprocess.call(["/bin/sh", "-c", _cmd],stdout=subprocess.PIPE,stderr=subprocess.PIPE)

        if retVal != 0:
            return False

        return True
    except IOError:
        return False

#Fn Set Application Protection Exclusions. It expects a 'list' as parameter.
def setAppProExclusions(exclusionList):
    """"@param exclusionList - 'list' of 'Applications/Folders' to put in
            exclusion list.
        @return True if exclusion list is set.
            'None' for failure to add the list."""
    try:
        if(not isinstance(exclusionList, list)):
            return False

        _exclusionSet = ""
        for excItem in exclusionList:
            _exclusionSet += excItem
            _exclusionSet += " "

        _cmd = APTT_PATH + " 20007 " + _exclusionSet
        retVal = subprocess.call(["/bin/sh", "-c", _cmd],stdout=subprocess.PIPE,stderr=subprocess.PIPE)

        if retVal != 0:
            return False
        return True
    except IOError:
        return False

#Fn Get Application Protection Exclusions.
def getAppProExclusions():
    """Get the application exclusions

    @return  a list of exclusions.
    """
    _p = subprocess.Popen([APTT_PATH, "20006"], stdout=subprocess.PIPE)
    _p.wait()
    # Do not parse output if command failed.
    if _p.returncode != 0 :
        return False

    _out = _p.stdout.read().split("\n")
    _exclusions = []

    # Scan each line and create a dict object containing all exclusions.
    for _line in _out :
        _line = _line.strip()
        _regex = "^/"
        _match = re.search(_regex, _line)
        if _match is not None :
             _exclusions.append(_line)        
    
    return _exclusions

def _validateAppProSingleRule(rule):
    """
    Fn   Validate a single app pro rule
    """
    if "AppPath" not in rule \
        or "ExecAllowed" not in rule or "Enabled" not in rule \
        or "NwAction" not in rule :
        logging.debug("_validateAppProSingleRule : Required keys are not found")
        return False
    if not isinstance(rule["AppPath"], str)\
        or rule["ExecAllowed"] not in ('0','1')\
        or rule["NwAction"] not in ('1','2','3')\
        or rule["Enabled"] not in ('0','1'):
        logging.debug("_validateAppProSingleRule : Parameter validation failed")
        return False
    return True

def _validateAppProRule(rule):
    """
    Fn to validate the App Pro rule
    """
    # Validating values of dictionary keys
    # NOTE: We do not check existence of file in AppPath
    if type(rule) == dict:
        return _validateAppProSingleRule(rule)
    else:
        for eachrule in rule:
            if _validateAppProSingleRule(eachrule) == False:
                logging.debug("_validateAppProRule : Parameter validation failed")
                return False
        return True
            

def addAppProtRule(rule):
    """Adds the rule for application protection

    @param rule - a dict  or a list of dict objects with keys 'AppPath', 'ExecAllowed',
                'Enabled' and 'NwAction' (case sensitive)
                Valid values :
                'AppPath' = string containing path of application
                'ExecAllowed' = '0' for deny and '1' for allow
                'Enabled' = '0' for disable and '1' for enable
                'NwAction' = '1' for network allow, '2' for block
                            and '3' for custom
                'CustomRules' - a array of dict for custom rules.
                            Considered only when 'NwAction' is '3'
            Dictionary for CustomRules has following keys :
                'IP' - 'IP Address/ subnet', 'ANY_IP' for any ip
                'Port' - Port range (<num>-<num>) format 'ANY_PORT' for any port
                'Protocol' - '1' for TCP, '2' for UDP and '3' for BOTH
                'Direction' - '1' for Incoming, '2' for Outgoing and '3' for both
                'Action' - '1' for allow and '2' for Block

    @return the return code of the aptt command run. False on failure
    """
    # Validating values of dictionary keys
    if _validateAppProRule(rule) == False:
        return False

    # Construct & run the command
    _cmd = _getAppProtRuleCommand(rule)
    if _cmd == False :
        return SYSTEM_ERROR

    _cmd.insert(0,APTT_PATH)
    _cmd.insert(1,"20000")
    logging.debug(_cmd)
    _p = subprocess.Popen(_cmd,stdout=subprocess.PIPE)
    _p.wait()
    # Add the base error since aptt subtracts and returns code
    _retval = _p.returncode + APP_PROTECTION_ERROR_RANGE_START

    logging.debug("addAppProtRule returing %d" % _retval)
    return _retval

def deleteAppProtRule(rule):
    """Delete the rule for application protection

    @param rule - a dict object. See 'addAppProtRule' documentation for details
                on rule key/values. It can also be a list of dicts for deleting multiple rules
                in one go.
    @return aptt return code if command is run. False otherwise
    """
    # Process the rules if only one is specified.
    if _validateAppProRule(rule) == False:
        return False
    # Construct & run the command
    _cmd = _getAppProtRuleCommand(rule)
    if _cmd == False :
        return  SYSTEM_ERROR

    _cmd.insert(0,APTT_PATH)
    _cmd.insert(1,"20001")
    _p = subprocess.Popen(_cmd,stdout=subprocess.PIPE)
    _p.wait()
    # Add the base error since aptt subtracts and returns code
    _retval = _p.returncode + APP_PROTECTION_ERROR_RANGE_START
    logging.debug("deleteAppProtRule returning %d" % _retval)
    return _retval
    


def modifyAppProtRule(rule):
    """Modify the application protection rule

    @param rule - a dict object. See 'addAppProtRule' documentation for details
                on rule key/values
    @return aptt return code if comand is run, False otherwise
    """
    # Validating values of dictionary keys
    if _validateAppProRule(rule) == False:
        return False

    # Construct & run the command
    _cmd = _getAppProtRuleCommand(rule)
    if _cmd == False :
        return SYSTEM_ERROR

    _cmd.insert(0,APTT_PATH)
    _cmd.insert(1,"20002")
    _p = subprocess.Popen(_cmd,stdout=subprocess.PIPE)
    _p.wait()
    # Add the base error since aptt subtracts and returns code
    _retval = _p.returncode + APP_PROTECTION_ERROR_RANGE_START
    logging.debug("modifyAppProtRule returning : %s" % _retval)
    return _retval

def getAppProtRules():
    """Get the application protection rule

    @return  a list of dict containing rules. The dict (rule) has same keys as
            for addAppProtRules
    """
    _p = subprocess.Popen([APTT_PATH, "20003"], stdout=subprocess.PIPE)
    _p.wait()
    # Do not parse output if command failed.
    if _p.returncode != 0 :
        return False

    _out = _p.stdout.read().split("\n")
    _rules = []
    _rule = dict()

    # Scan each line and create a dict object containing all valid keys.
    # Once all keys are found, push into the array then move on to next record.
    for _line in _out :
        _line = _line.strip()
        _regex = "^AppGroup\s+=\s+(.*)$"
        _match = re.search(_regex, _line)
        if _match is not None :
            if "AppPath" in _rule :
                _rules.append(_rule)
            _rule = dict()
            _rule["AppPath"] = _match.group(1)
            continue

        _regex = "^ExecAllowed\s+=\s+(yes|no)\s+Enabled\s+=\s+(yes|no)\s+"\
                + "NwAction\s+=\s+(.*)$"
        _match = re.search(_regex, _line)
        if _match is not None :
            _rule["ExecAllowed"] = ('0','1')[_match.group(1) != "no"]
            _rule["Enabled"] = ('0','1')[_match.group(2) != "no"]
            _rule["NwAction"] = _match.group(3)

        _regex = "^AppModified\s+=\s+(True|False)$"
        _match = re.search(_regex, _line)
        if _match is not None :
            _rule["AppModified"] = ('0','1')[_match.group(1) != "False"]

        _regex = "IP Address Range\s+:(.*)IP Address\s*:(.*)SubnetMask\s*:(.*)"\
               + "PortRangeStart\s*:(.*)PortRangeEnd\s*:(.*)NWProtocol\s*:(.*)"\
               + "Direction\s*:(.*)Action\s*:(.*)"
        _match = re.search(_regex, _line)
        if _match is not None :
            if "CustomRules" not in _rule :
                _rule["CustomRules"] = []
            _cr = dict()
            _cr["IP"] = _match.group(1).strip()
            _cr["Subnet"] = _match.group(3).strip()
            _cr["Port"] = _match.group(4).strip() + "-" + _match.group(5).strip()
            _cr["Protocol"] = _match.group(6).strip()
            _cr["Direction"] = _match.group(7).strip()
            _cr["Action"] = _match.group(8).strip()

            if _cr["Protocol"] == "TCP" :
                _cr["Protocol"] = '1'
            elif _cr["Protocol"] == "UDP" :
                _cr["Protocol"] = '2'
            elif _cr["Protocol"] == "BOTH" :
                _cr["Protocol"] = '3'

            if _cr["Direction"] == "BOTH" :
                _cr["Direction"] = '3'
            elif _cr["Direction"] == "INCOMING" :
                _cr["Direction"] = '1'
            elif _cr["Direction"] == "OUTGOING" :
                _cr["Direction"] = '2'

            if _cr["Action"] == "ALLOW" :
                _cr["Action"] = '1'
            else :
                _cr["Action"] = '2'

            _rule['CustomRules'].append(_cr)

    if "AppPath" in _rule :
        _rules.append(_rule)
    return _rules

def _getAppProRuleCommandForOneRule(rule):
    """ 
    Fn To return thecommand for a single app"
    """
    # Construct the command
    _cmd = [rule["AppPath"], rule["ExecAllowed"], rule["Enabled"], rule["NwAction"]]

    # If 'NwAction' is '3' Then honor custom rules also.
    if rule["NwAction"] == '3' and "CustomRules" in rule :
        _custom_rules = rule["CustomRules"]
        _cmd.append(str(len(_custom_rules)))
        for _cr in _custom_rules :
            # If any key is missing - return False
            if "IP" not in _cr or "Port" not in _cr\
                or "Protocol" not in _cr or "Action" not in _cr\
                or "Direction" not in _cr :
                logging.debug("_getAppProtRuleCommand : Parameter validation failed")
                return False
            _cmd.append(_cr["IP"])
            _cmd.append(_cr["Port"])
            _cmd.append(_cr["Protocol"])
            _cmd.append(_cr['Direction'])
            _cmd.append(_cr["Action"])
    logging.debug("_getAppProRuleCommandForOneRule returning %s"%_cmd)
    return _cmd

def _getAppProtRuleCommand(rule):
    if type(rule) == dict:
        return _getAppProRuleCommandForOneRule(rule)
    else:
        _multicmd =[]
        for eachrule in rule:
            _multicmd = _multicmd + _getAppProRuleCommandForOneRule(eachrule) 
        return _multicmd

def _getAppProtPreferences():
    """Returns the preferences of appProt as a dict() object."""
    try:
        _cmd_id = "20004"
        _p = subprocess.Popen([APTT_PATH, _cmd_id], stdout=subprocess.PIPE)
        _p.wait()
        # We return if command did not complete successfully
        if _p.returncode != 0 :
            return False

        # Read console output in a list [ split by \n to save one line in each element]
        _out = _p.stdout.read().split("\n")
        _preferences = dict()
        for line in _out:
            list = line.split(":",2)
            if len(list) == 2:
                _preferences[list[0].strip()] = list[1].strip()
        # We convert 'Yes' to 1 and any other to '0' such that it will
        # be easy when we call _setAppProtPreferences which require integer
        # This is the reason we use 0 / 1 and not 'True' / 'False'
        if APPLE_SIGNED_BINARIES in _preferences :
            if _preferences[APPLE_SIGNED_BINARIES] == "Yes" :
                _preferences[APPLE_SIGNED_BINARIES] = 1
            else:
                _preferences[APPLE_SIGNED_BINARIES] = 0

        if APP_PROT_STATUS in _preferences :
            if _preferences[APP_PROT_STATUS] == "Yes" :
                _preferences[APP_PROT_STATUS] = 1
            else:
                _preferences[APP_PROT_STATUS] = 0

        return _preferences
    except IOError:
        return False

def _setAppProtPreferences(preferences):
    """Set the application protection preferences

    @return True if command is successfully completed and 'False' otherwise.
    """

    if(not isinstance(preferences, dict)):
        return False
    _cmd_id = "20005"

    _args = str(preferences[APPLE_SIGNED_BINARIES])\
          + " " + str(preferences[UNKNOWN_APP_ACTION])\
          + " " + str(preferences[PROMPT_TIMEOUT])\
          + " " + str(preferences[APP_PROT_STATUS])

    _cmd =  APTT_PATH + " " + _cmd_id + " " + _args
    logging.debug("Command is " + _cmd)
    try:
        _p = subprocess.Popen( ["/bin/sh" , "-c", _cmd], stdout=subprocess.PIPE)
        _p.wait()

        # Check exit status to identifiy if command succeeded or not
        if _p.returncode != 0:
            return False
        return True;
    except IOError:
        return False

def alertAllowWithNetworkAlways(userName,passwd):
    """
    Fns to select allow always option on McAfee Alert, given a Username and passwd
    """
    try:
        appleScript = """ 
        osascript <<-EOF
        activate application "McAfee Reporter"
        tell application "System Events" to tell process "McAfee Reporter"
            click button "Always" of group 1 of window "McAfee® Alert"
            if window 1 of process "SecurityAgent" of application "System Events" exists then
                tell application "System Events"
                    tell process "SecurityAgent"
                        tell window 1
                            tell scroll area 1 of group 1
                                set value of text field 1 to "%s"
                                set value of text field 2 to "%s" 
                            end tell
                            click button "OK" of group 2
                        end tell
                    end tell
                end tell
            end if
        end tell
EOF"""
        retval = subprocess.call([appleScript %(userName,passwd)], shell=True)
        if(retval != 0):
            logging.error("Error occured in alertAllowWithNetworkAlways applescript")
            return False
        return True
    except :
        logging.error("Exception occured in alertAllowWithNetworkAlways")
        return False

def alertAllowWithNetworkOnce():
    """
    Fns to select Allow only Once option on McAfee Alert
    """
    try:
        appleScript = """
        osascript <<-EOF
        activate application "McAfee Reporter"
        tell application "System Events" to tell process "McAfee Reporter"
            click button "Once" of group 1 of window "McAfee® Alert"
        end tell
EOF"""
        retval = subprocess.call(appleScript, shell=True)
        if(retval!= 0):
            logging.error("Error occured in alertAllowWithNoNetWorkAccess applescript")
            return False
        return True
    except:
        logging.error("Exception occured in alertAllowOnce")
        return False

def alertAllowWithNoNetWorkAlways(userName,passwd):
    """
    Fns to select Allow with no NetWork access option on McAfee Alert
    """
    try:
        appleScript = """
        osascript <<-EOF
        activate application "McAfee Reporter"
        tell application "System Events" to tell process "McAfee Reporter"
            click radio button "Allow execution with no network access" of radio group 1 of group 1 of window "McAfee® Alert"
            click button "Always" of group 1 of window "McAfee® Alert"
            if window 1 of process "SecurityAgent" of application "System Events" exists then
                tell application "System Events"
                    tell process "SecurityAgent"
                        tell window 1
                            tell scroll area 1 of group 1
                                set value of text field 1 to "%s"
                                set value of text field 2 to "%s"
                            end tell
                            click button "OK" of group 2
                        end tell
                    end tell
                end tell
            end if
        end tell
EOF"""
        retval = subprocess.call([appleScript %(userName,passwd)], shell=True)
        if(retval != 0):
            logging.error("Error occured in alertAllowWithNoNetWorkAccess applescript")
            return False
        return True
    except:
        logging.error("Exception occured in alertAllowWithNoNetWorkAccess ")
        return False

def alertAllowWithNoNetWorkOnce():
    """
    Fns to select Allow only Once option with no NetWork access on McAfee Alert
    """
    try:
        appleScript = """
        osascript <<-EOF
        activate application "McAfee Reporter"
        tell application "System Events" to tell process "McAfee Reporter"
            click radio button "Allow execution with no network access" of radio group 1 of group 1 of window "McAfee® Alert"
            click button "Once" of group 1 of window "McAfee® Alert"
        end tell
EOF"""
        retval = subprocess.call(appleScript, shell=True)
        if(retval!= 0):
            logging.error("Error occured in alertAllowOnceWithNoNetWorkAccess applescript")
            return False
        return True
    except:
        logging.error("Exception occured in alertAllowOnceWithNoNetWorkAccess ")
        return False

def alertDenyAlways(userName,passwd):
    """
    Fns to select Deny execution Always option on McAfee Alert
    """
    try:
        appleScript = """
        osascript <<-EOF
        activate application "McAfee Reporter"
        tell application "System Events" to tell process "McAfee Reporter"
            click radio button "Deny execution" of radio group 1 of group 1 of window "McAfee® Alert" 
            click button "Always" of group 1 of window "McAfee® Alert"
            if window 1 of process "SecurityAgent" of application "System Events" exists then
                tell application "System Events"
                    tell process "SecurityAgent"
                        tell window 1
                            tell scroll area 1 of group 1
                                set value of text field 1 to "%s"
                                set value of text field 2 to "%s"
                            end tell
                            click button "OK" of group 2
                        end tell
                    end tell
                end tell
            end if
        end tell
EOF"""
        retval = subprocess.call([appleScript %(userName,passwd)], shell=True)
        if(retval != 0):
            logging.error("Error occured in  alertDenyExecutionAlways applescript")
            return False
        return True
    except:
        logging.error("Exception occured in alertDenyExecutionAlways")
        return False
        
def alertDenyOnce():
    """
    Fns to select Deny execution Once option on McAfee Alert
    """
    try:
        appleScript = """
        osascript <<-EOF
        activate application "McAfee Reporter"
        tell application "System Events" to tell process "McAfee Reporter"
            click radio button "Deny execution" of radio group 1 of group 1 of window "McAfee® Alert"
            click button "Once" of group 1 of window "McAfee® Alert"
        end tell
EOF"""
        retval = subprocess.call(appleScript, shell=True)
        if(retval != 0):
            logging.error("Error occured in alertDenyExecutionOnce applescript")
            return False
        return True
    except:
        logging.error("Exception occured in alertDenyExecutionOnce ")
        return False

def enableApproTrace(tracevalue):
    """
    Fns to Enable AppPro trace for tracevalue
    """
    try:
        _fd=os.open("/usr/local/McAfee/AppProtection/var/appProt.trace",os.O_TRUNC)
        os.close(_fd)
    except:
        logging.error("os error")
        return False
    # Step 1 Set the reportMgrFlow trace to level 5 in AppPro trace value file
    commonFns.setXMLValueinFile("/usr/local/McAfee/AppProtection/var/traceValues.xml",
                                    tracevalue,
                                    5)
    # Step 2 reload Appro
    subprocess.call(["/usr/local/McAfee/AppProtection/bin/AppProtControl","reload"],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    return True

def disableApproTrace(tracevalue):
    """
    Fns to Disable AppPro trace for tracevalue
    """
    # Step 0 Set the trace value back.
    commonFns.setXMLValueinFile("/usr/local/McAfee/AppProtection/var/traceValues.xml",
                                tracevalue,
                                    0)
    # Step 2 reload Appro
    subprocess.call(["/usr/local/McAfee/AppProtection/bin/AppProtControl","reload"],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    return True

def resetAppProtToDefaults():
    """
    Fns to bring app pro rules and prefs to initial state
    """
    # Set Unknonw app action to ALLOW 
    setUnknownAppAction(1)
    # Remove all exclusions
    setAppProExclusions([])
    #Enable App Pro
    enableAppProt()
    #Set Timeout 
    setAppProtTimeout(60)
    #Set apple signed binaries to allow
    allowAppleSignedBinaries(True)
    #Delete all the rules
    _rules = []
    _rules = getAppProtRules()
    deleteAppProtRule(_rules)

def checkAppProtUsable():
    _maxTimeLimit = 0
    cpuUsage = 100
    # Making sure the 'cpu usage' of appProtd is below 2%.    
    while cpuUsage > 2 and _maxTimeLimit < 120:
        _cmd = "top -F -R -l 2 | grep appProtd | awk 'BEGIN {print $2, $3} {s+=$3} END {if (NR>0) {print s/NR} else {print \"100\"}}'"
        _p = subprocess.Popen(['/bin/sh', '-c', _cmd], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    
        # Wait for process to complete
        _p.wait()

        # Read the output and parse it.
        _out = _p.stdout.read().split("\n")
        _linNum = 1
        for _line in _out :
            if _linNum == 2:
                cpuUsage = decimal.Decimal(_line.strip())
            _linNum += 1
        
        if cpuUsage <= 2:
            return True

        time.sleep(5)
        _maxTimeLimit += 5

    if _maxTimeLimit < 120:
        # Additional sleep to take care of any rare scenarios...
        time.sleep(5)
        return True
    else:
        return False

def installAppProtTestTool():
    """
    Fns to install appt test tool.  This fn will also wait for appProtd process to come up
    """

    # Install AppProt test tool
    logging.debug("Installing appProtTestTool")
    if commonFns.installTestTool("aptt", os.path.dirname(\
            os.path.abspath(sys.argv[0])) + "/data/aptt") != True :
        logging.error("Failed to install appProtTestTool")
        return 1

    # Copy the files required for proper testcase execution...
    _AppProDir = os.path.dirname(os.path.abspath(sys.argv[0]))

    _CocoaDownloaderApp = _AppProDir + "/data/SampleCocoaCarbonApps/Downloader.app"
    _CarbonDownloaderApp = _AppProDir + "/data/SampleCocoaCarbonApps/CarbonDownloader.app"
    _PPCDownloaderApp = _AppProDir + "/data/SampleCocoaCarbonApps/PPCDownloader.app"
    _3rdPartyApp = _AppProDir + "/data/SampleCocoaCarbonApps/80mac_eval_en.app"
    _mnacDmgPath = _AppProDir + "/data/SampleApplications/mnac.dmg"

    if not os.path.isdir(_CocoaDownloaderApp):
        os.chdir(_AppProDir + "/data/SampleCocoaCarbonApps/")
        subprocess.call( [ "tar", "-zxvf" , "CocoaDownloader.tar.gz" ],
                stdout=subprocess.PIPE,stderr=subprocess.PIPE)

    if not os.path.isdir(_CarbonDownloaderApp):
        os.chdir(_AppProDir + "/data/SampleCocoaCarbonApps/")
        subprocess.call( [ "tar", "-zxvf" , "CarbonDownloader.tar.gz" ],
                stdout=subprocess.PIPE,stderr=subprocess.PIPE)

    if not os.path.isdir(_PPCDownloaderApp):
        os.chdir(_AppProDir + "/data/SampleCocoaCarbonApps/")
        subprocess.call( [ "tar", "-zxvf" , "PPCDownloader.tar.gz" ],
                stdout=subprocess.PIPE,stderr=subprocess.PIPE)

    if not os.path.isdir(_3rdPartyApp):
        os.chdir(_AppProDir + "/data/SampleCocoaCarbonApps/")
        subprocess.call( [ "tar", "-zxvf" , "3rdPartyInstaller.tar.gz" ],
                stdout=subprocess.PIPE,stderr=subprocess.PIPE)

    if not os.path.isfile(_mnacDmgPath):
        os.chdir(_AppProDir + "/data/SampleApplications/")
        subprocess.call( [ "tar", "-zxvf" , "MNac.tar.gz" ],
                stdout=subprocess.PIPE,stderr=subprocess.PIPE)

    os.chdir(_AppProDir)
    # chmod the data directory to 755
    subprocess.call(["chmod", "-R", "755", "./data"])
    _retVal = checkAppProtUsable();
    return _retVal    

