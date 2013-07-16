#!/usr/bin/python
# Copyright (C) 2010 McAfee Inc. All rights reserved.
import subprocess
import os
import sys
# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
import re
import logging
# TODO  fix the path below when fw gets automated.
FWTT_PATH = os.path.dirname(os.path.abspath(sys.argv[0])) + "/data/fwtt/FWTestTool"

def addFWRuleWithoutPorts(ruleName,action,direction,protocol,srcIp,destIp):
    """
    Fn to add a rule without ports"
    """ 
    # TODO add argument validation
    subprocess.call( [  FWTT_PATH, 
                        "23", 
                        ruleName, 
                        str(action),
                        str(direction),
                        str(protocol),
                        str(srcIp),
                        str(destIp) ], 
                        stdout=subprocess.PIPE)
    return True

def addFWRuleWithPorts(ruleName,action,direction,protocol,srcIp,srcPortStart,srcPortEnd,destIp,destPortStart,destPortEnd,interface):
    """
    Fn to add a rule with ports"
    """ 
    # TODO add argument validation
    try:
        retVal = subprocess.call( [  FWTT_PATH, 
                        "7", 
                        ruleName, 
                        str(action),
                        str(direction),
                        str(protocol),
                        str(srcIp),
                        str(srcPortStart)+"-"+str(srcPortEnd),
                        str(destIp),
                        str(destPortStart)+"-"+str(destPortEnd),
                        interface ], 
                        stdout=subprocess.PIPE)
        if retVal == 0:
            return True
        else:
            return False
    except:
        print "exception occured in addFWRuleWithPorts()"
        return False

def getRuleIdFromName(ruleName):
    """
    Fn returns rule id baesd on name
    """
    try:
        _p=subprocess.Popen( [ FWTT_PATH, "1" ],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        _p.wait()
        # Do not parse output if command failed.
        if _p.returncode != 0 :
            return False
    except:
        print "Exception occured in getting rule id from name"
        return False
    _out = _p.stdout.read().split("\n")
    # Scan each line and create a dict object containing all valid keys.
    # Once all keys are found, push into the array then move on to next record.
    for _line in _out :
        _line = _line.strip()
        regex="\[\s(\d+)\s("+ruleName+")\s"
        m=re.search(regex,_line)
        if m != None:
            return m.group(1)

    return None
    
def deleteFWRule(ruleName):
    """
    Fn to delete a rule given a rule name
    """ 
    # TODO add argument validation
    ruleId=getRuleIdFromName(ruleName)
    if ruleId == None:
        return False
    try:
        retVal = subprocess.call( [  FWTT_PATH, "4", ruleId ],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        if retVal == 0:
            print ruleId + " deleted successfully"
            return True
        else:
            return False
    except:
        print "exception caught in executing deleteFWRule()"
        return False

def installFirewallTestTool():
    """
    Fns to install fw test tool. 
    """

    # Install Firewall test tool
    logging.debug("Installing firewall testtool")
    if commonFns.installTestTool("fwtt", os.path.dirname(\
            os.path.abspath(sys.argv[0])) + "/data/fwtt") != True :
        logging.error("Failed to install fwtt")
        return False
    return True

def getTrustedGroups():
    """
    Fns to get trusted groups
    """
    try:
        _p=subprocess.Popen( [ FWTT_PATH, "8" ],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        _p.wait()
        # Do not parse output if command failed.
        if _p.returncode != 0 :
            return False
    except:
        print "Exception occured in getTrustedGroups()"
        return False
    _out = _p.stdout.read().split("\n")
    trustedGroups = []
    for _line in _out:
        _line=_line.strip()
        regex='\[\s(.*)\s\]\[\s\d+\s\d+\s\d+\s(.*)\]'
        m=re.search(regex,_line)
        if m != None:
            trustedGrp = dict()
            trustedGrp["GroupName"]=m.group(1)
            ips = []
            for ip in m.group(2).split(","):
                ips.append(ip)
            trustedGrp["Hosts"]=ips
            trustedGroups.append(trustedGrp)
    return trustedGroups

def enableCustomRules():
    """
    Fn which sets the FW preferences to allow us ot set custom rules. 
    Note - This function does not set any rules
    """
    try:
        retVal = subprocess.call( [ FWTT_PATH, str(5), str(0),str(0),str(0),str(4)],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
        if retVal == 0:
            return True
        else:
            return False
    except:
        print "Exception occured in enableCustomRules()"
        return False

def disableCustomRules():
    """
    Fn which sets the FW preferences to allow all
    Note - This function does not set any rules
    """
    subprocess.call( [ FWTT_PATH, str(5), str(0),str(0),str(0),str(0)],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    return True

def addTrustedList(tlist):
    """
    Fn Add trusted list entry 
    """
    ips=tlist["Hosts"]
    ip_str=""
    if len(ips) == 1:
       ip_str = ip_str + ips[0] 
    else:
        for ip in ips:
            ip_str = ip_str + ip +" "
    try:
        rc = subprocess.call( [ FWTT_PATH,
                       str(11),
                       tlist["GroupName"],
                       str(1),
                       str(1),
                       ip_str ],
                       stdout=subprocess.PIPE,
                       stderr=subprocess.PIPE )
        if rc == 0:   
            return True
        else:
            print "Unable to execute addTrustedList command"
            return False
    except:
        print "Exception occured in addTrustedList()"
        return False

def deleteTrustedList(groupname):
    """
    Fn to delete a given trusted list entry
    """
    try:
        retVal = subprocess.call( [FWTT_PATH,
                     str(12),
                     groupname ],
                     stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE )
        if retVal == 0:
            return True
        else:
            return False
    except:
        print "exception occured in deleteTrustedList()"
        return False

