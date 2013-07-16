#Copyright (C) 2009 McAfee, Inc.  All rights reserved.

import logging
import datetime
import string
import sys
import urllib
import os
import time
import urllib2
import ConfigParser
from socket import gethostname
from stat import * 
from Tasks import *

sys.path.append('../Common')
sys.path.append('./Common')
import commonFns
from commonFns import CONFIG_FILE_NAME


# Lets load the variables when module is import-ed
section = 'EPO_AUTOMATION'
_config = ConfigParser.ConfigParser()
scriptPath = os.path.dirname(os.path.abspath(sys.argv[0]))
i = scriptPath.find('Testcases')
if i == -1 :
    raise "Invalid path of the script " + scriptPath
scriptPath = scriptPath[0:i]  + 'Testcases/Common/'

if scriptPath + CONFIG_FILE_NAME not in _config.read(scriptPath + CONFIG_FILE_NAME) :
    raise "Failed to read the configuration file. You will not be able to read configuration"

g_strMAInstaller = _config.get('VSEL_AUTOMATION', 'PAYLOAD_PATH') + '/upgrade/epoKeys'
os_details = commonFns.getOSDetails()
if os_details['os_name'] == 'Ubuntu' :
    g_strMAInstaller = g_strMAInstaller + '/installdeb.sh'
else :
    g_strMAInstaller = g_strMAInstaller + '/install.sh'

g_strEPOSvr      = _config.get(section, 'EPO_SERVER')
g_strEPOUser     = _config.get(section, 'EPO_USERNAME')
g_strEPOPass     = _config.get(section, 'EPO_PASSWORD')
g_strDomain      = _config.get(section, 'EPO_DOMAIN_NAME')
g_strDomainUser  = _config.get(section, 'EPO_DOMAIN_USER')
g_strDomainPass  = _config.get(section, 'EPO_DOMAIN_PASSWORD')

##############################################

class TestCaseFailedException(Exception):
    '''A custom exception indicating the test case failed'''
    
    def __init__(self, reason):
        self.value = reason
        return
    def __str__(self):
        return str(self.value)
    
class TestCaseErrorException(Exception):
    '''A custom exception indicating an error in the test case'''
    
    def __init__(self, reason):
        self.value = reason
        return
    def __str__(self):
        return str(self.value)
    
class RemoteEPOCmdError(Exception):
    
    def __init__(self, error):
        self.value = error
        return
    def __str__(self):
        return str(self.value)
    
def SendRemoteEPOCommand(strEPOHost, strEPOUsr, strEPOPwd, strCmd, dictParams):
    '''Attempt to remotely invoke the given command on the given ePO server
    
    Inputs:
        -strEPOHost is the machine name where the ePO server is running
        -strEPOUsr is an epo username with priveleges to run the given command
        -strEPOPwd is the password for the given user
        -strCmd is the command class name as it would be given to the
         ePO remote client. I.e. ComputerMgmt.AgentWakeup
        -dictParams is a dictionary of param:value pairs that the command will
         understand
    
    Return the response data as a string. 
    Otherwise raise RemoteEPOException with error text.
    '''     
    url = "https://" + strEPOHost + ":8443/remote/scheduler.runSingleCommandAsTask.do"
    
    commandURI = "schedule:" + strCmd + "?"
    for (k,v) in dictParams.iteritems():
        commandURI += str(k) + "=" + str(v) + "&"
        
    commandURI = commandURI[:-1] #strip the trailing '&'
    
    compiledParams = {"taskName":strCmd,
                      "taskDescription":"MA FVT Remote Task",
                      "waitForResults":True,
                      "commandURI":commandURI}
    
    # Create an OpenerDirector with support for Basic HTTP Authentication...
    auth_handler = urllib2.HTTPBasicAuthHandler()
    auth_handler.add_password("Orion remote command realm", url, strEPOUsr, strEPOPwd)
    logging.debug("Sending authentication details")
    opener = urllib2.build_opener(auth_handler)
    # ...and install it globally so it can be used with urlopen.
    urllib2.install_opener(opener)
    logging.debug("Encoding the parameters")
    data = urllib.urlencode(compiledParams)
    try:
        logging.debug("Sending the epo command to : " + url)
        result = urllib2.urlopen(url, data)
    except Exception, inst:
        raise RemoteEPOCmdError("There was an error contacting the ePO server: " + \
                                str(inst))
    logging.debug("Waiting for results from ePo")
    lines = result.read()
        
    if lines.lower().find("error:") != -1:
        logging.error("Error found in results.")
        raise RemoteEPOCmdError("ePO command " + strCmd + \
                                " returned an error: " + commandURI + ":" + lines)
    #strip off brackets
    result = lines[lines.find("[")+1 : lines.rfind("]")]
    logging.debug("Returning " + result)
    return result

def installProduct(prod_id, version) :
    logging.debug("Creating the product deployment task on %s, Version %s" % (prod_id, version))
    taskSched = EPOTaskSchedule
    deployTask = AgentDeploymentTask("Deploy Product on " + gethostname())
    deployTask.addProduct(prod_id, version, "Install", "Current", AgentDeploymentTask.LANG_ENGLISH)
    taskSchedule = EPOTaskSchedule(EPOTaskSchedule.SCHED_TYPE_RUN_IMMEDIATELY)
    logging.debug("Sending agent task to epo now")
    if not EPOCreateAgentTask(gethostname(), deployTask, taskSchedule):
        FailTestCase("Failed to create Deployment Task")
        return 1

    logging.info("Deployment Task Created")
    if not EPOAgentWakeup(gethostname(), False):
        logging.error("Not able to send the agent wake up call")
        return 1
    logging.info("Agent wake up call sent successfully")
    return 0
        

def EPOAgentWakeup(strNode, bCollectAllProps=False, iWait=None, bSuperAgent=False):
    '''Ask ePO to performa a wakeup on the requested node
    
    Inputs:
        strNode - the node name of the client to wakeup
        bCollectAllProps - whether or not to request all props
        iWait - if set, the function will wait this many
                       seconds fo the "Last Update" property to
                       change in ePO.
                             
    Returns: True for success, otherwise False
    '''
    oldTime = ""
    if iWait:
        props = EPOGetProps(strNode)
        if props and "LastUpdate" in props[None]:
            print ("Last update before wakeup: " + str(props[None]["LastUpdate"]))
            oldTime = props[None]["LastUpdate"]
    
    success = True
    
    #pack epo wakeup params
    params = {"param1" : bCollectAllProps, #full props
              "param2" : bSuperAgent,      #super agent
              "param3" : 0,                #randomize
              "param4" : strNode,          #csv comp names
              "param5" : 0,                #unique ID
              "param6" : 0,                #group ID
              "param7" : False,            #all children
              "param8" : "csv_comp_names"} #input type for CSV fields
        
    try:
        logging.debug("Requesting epo to wakeup host : " + strNode)
        SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                   "ComputerMgmt.AgentWakeup", params)
    except RemoteEPOCmdError, inst:
        logging.error("Agent wakeup failed on " + strNode + ": " + str(inst))
        success = False
    
    if iWait and success:
        success = False
        for i in range(iWait/4):
            time.sleep(4)
            props = EPOGetProps(strNode)            
            if props and "LastUpdate" in props[None]:
                logging.debug("Last update: " + str(props[None]["LastUpdate"]))
                if oldTime != props[None]["LastUpdate"]:
                    success = True
                    break
    
    return success


def EPOGetProps(strNode):
    '''Get the ePO props fro the given node
    
    Inputs:
        strNode - the node name get props for
        
    Returns: A dictionary of dictionaries representing
             property values for each product like so:
             
             -SoftwareID
                 -Property=Value
                 -Property=Value
                     
            So to access the agent install dir you would type:
                
                props["EPOAGENT3000"]["szInstallDir"]
                
            EPO properties that apply to a node have no softwareID.
            For instance "Last Update" for a node is accessed like:
            
                props[None]["Last Update"] 
            
    '''
    logging.debug("Getting props for " + strNode)
    params = {"param1" : strNode}
    
    try:
        data = SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                          "ibt.getProperties", params)
    except RemoteEPOCmdError, inst:
        LogError("Failed to get props for " + strNode + ": " + str(inst))
        return None

    lines = data.splitlines()
    
    props = {}
    for line in lines:
        if len(line.split('\t')) == 4:
            (softwareID, section, propName, propVal) = line.split('\t', 3)
            if softwareID == "":
                softwareID = None                
            if not props.has_key(softwareID):
                props[softwareID] = {}                
            if propVal.strip() == "null":
                props[softwareID][propName.strip(string.whitespace + "[]")] = None
            else:
                props[softwareID][propName.strip(string.whitespace + "[]")] = propVal.strip()
        else:
            print("Wrong number of fields. Ignoring prop line:" + line)
    
    print (str(props))    
    return props

def EPOPushAgent(strNode, strInstPath="<PROGRAM_FILES_DIR>\McAfee\Common Framework", \
                 bForce=False, strBranch="Current"):
    '''Ask ePO push and agent to the given node
    
    Inputs:
        strNode - the node name of the client to push to
        strInstPath - where to install to on the client
        bForce - Wether or not to do a force install
        strBranch - which software branch to push from
        
    Returns: True for success, otherwise False
    '''
    logging.debug("Pushing agent to " + strNode)
    #pack epo wakeup params
    params = {"param1" : strBranch + "/EPOAGENT3000/Install/0409",  #branch selection
              "param2" : False,            #skip in installed already
              "param3" : False,            #supress GUI
              "param4" : bForce,           #Force
              "param5" : g_strDomainUser,    #username
              "param6" : g_strDomainPass,    #password
              "param7" : strNode,          #node to push to
              "param8" : strInstPath,      #install path
              "param9" : 0,                #uniqueID
              "param10": g_strDomain,        #domain
              "param11": "bogusgroup",     #group
              "param12": False,            #all children
              "param13": "csv_comp_names"} #input type for CSV fields
        
    try:
        SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                   "ComputerMgmt.PushAgent", params)
    except RemoteEPOCmdError, inst:
        LogError("Failed to perform push agent to " + strNode + ": " + str(inst))
        return False
    
    return True

def EPOReplicate(lstRepositoryList=["*"], bIncremental="False"):
    '''Ask ePO to replicate to the given repositories
    
    Inputs:
        strRepositoryList - a list of strings which are the distributed 
                            repository names to replicate to
                            to. "*" means all repositories.
        bIncremental - wether or not to do an incremental replication
        
    Returns: True for success, otherwise False
    '''
    strRepositories = ""
    for repository in lstRepositoryList:
        if repository == "*":
            strRepositories = "*"
            break
        
        try:
            result =  SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                       "RepositoryMgmt.RepoNameToIdCmd", {"param1":repository})
            strRepositories += result.strip() + ","
        except RemoteEPOCmdError, inst:
            LogError("Failed to get repository ID for " + repository + ": " + str(inst))
            return False
    
    #strip the trailing comma
    if strRepositories[-1] == ",":
        strRepositories = strRepositories[:-1]
    
    print("Replicating to repository list: " + strRepositories)
    #pack epo wakeup params
    params = {"param1" : strRepositories, #repo list
              "param2" : False}           #incremental
        
    try:
        SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                   "RepositoryMgmt.ReplicateCmd", params)
    except RemoteEPOCmdError, inst:
        LogError("Failed to perform replication to " + strRepositories + ": " + str(inst))
        return False
    
    return True


def EPODeleteAllTasks(strNode):
    '''Delete all effective client tasks from a given node
    
    Inputs:
        strNode - the node name to delete from
        
    Returns: True if deletion was successful, otherwise false
    '''
    logging.debug("Requesting EPO to delete all taks of node : " + strNode)
    params = {"param1" : strNode}
    
    try:
        SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                   "ibt.deleteTasks", params)
    except RemoteEPOCmdError, inst:
        print("Failed to delete tasks on " + strNode + ": " + str(inst))
        return False
    
    return True

def EPOCreateAgentTask(strNode, objTask, objSchedule):
    '''Create an agent task for the given node 
    
    Inputs:
        strNode - the node name to assign the task to
        objTask - a task object such as AgentDeploymentTask
        objSchedule - An EPOTaskSchedule object that defines
                      the task's schedule 
        
    Returns: True for success, otherwise False
    '''
    logging.debug("Creating " + objTask.type + " task for " + strNode)
    taskSettings = objSchedule.getIBTExtensionString()
    if not taskSettings:
        logging.error("Invalid task schedule object")
        return False
    
    taskSettings += objTask.getIBTExtensionString()
    #pack epo wakeup params
    params = {"param1" : strNode,                    #computer
              "param2" : objTask.type,               #task type (from ePO DB)
              "param3" : objTask.name,               #task name
              "param4" : "FVT created task",         #task description
              "param5" : "EPOAGENTMETA",             #task product ID
              "param6" : objTask.platforms,          #platforms
              "param7" : taskSettings}               #settings
        
    try:
        SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                   "ibt.createTask", params)
    except RemoteEPOCmdError, inst:
        logging.error("Failed to create deployment task at " + strNode + ": " + str(inst))
        return False
    
    return True

