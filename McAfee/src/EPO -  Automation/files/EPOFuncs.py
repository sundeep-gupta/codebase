'''
EPOFuncs.py

Author:        Chris Tissell & Harish Krishnan
Description:   This is the ePO functions Helper module.
               This module provides most of the ePO functions that transparently work on 
               all versions (4.5.0 +) of ePO. 
'''

import string, time
import EPORemoteCommand

from HelperFuncs import *

g_strEPOVer = ""
epo = ""



ePOVer = None
epo = EPORemoteCommand.client(g_strEPOSvr, "8443", g_strEPOUser, g_strEPOPass, output="xml")
    
try:
    ePOVer = epo.epo.getVersion()
except EPORemoteCommand.CommandInvokerError:
    pass
    
if ePOVer and ePOVer.find("4.6") != -1:
    g_strEPOVer = "4.6"
else:
    g_strEPOVer = "4.5"

############################## Functions for ePO 4.6. ############################

if g_strEPOVer == "4.6":
    
    def EPOAgentWakeup(strNode, bCollectAllProps=False, iWait=None, bSuperAgent=False,
                       forceFullPolicyUpdate=False):
        '''Ask ePO to perform a wake up on the requested node
    
        Inputs:
            strNode - the node name of the client to wakeup
            bCollectAllProps      - whether or not to request all props
            iWait                 - if set, the function will wait this many
                                    seconds for the "Last Update" property to
                                    change in ePO.
            bSuperAgent           - SA WakeUpCall if set.
            forceFullPolicyUpdate - Force complete policy and task update
                             
        Returns: True for success, otherwise False
        '''
        oldTime = ""
        if iWait:
            props = EPOGetProps(strNode)
            if props and "LastUpdate" in props[None]:
                LogStr("Last update before wakeup: " + str(props[None]["LastUpdate"]))
                oldTime = props[None]["LastUpdate"]
        
        LogStr("Waking up " + strNode)
        success = True
        
        try:
            epo.system.wakeupAgent(names                = strNode,
                                   fullProps            = str(bCollectAllProps), 
                                   superAgent           = str(bSuperAgent),
                                   randomMinutes        = "0",
                                   forceFullPolicyUpdate= str(forceFullPolicyUpdate), 
                                   useAllHandlers       = "False",
                                   retryIntervalSeconds = "60",
                                   attempts             = "0",
                                   abortAfterMinutes    = "5",
                                   includeSubgroups     = "False"
                                   )
        except EPORemoteCommand.CommandInvokerError, e:
            LogError("Agent wakeup failed on " + strNode + ": " + str(e))
            success = False
        
        if iWait and success:
            success = False
            for i in range(iWait/4):
                time.sleep(4)
                props = EPOGetProps(strNode)            
                if props and "LastUpdate" in props[None]:
                    LogStr("Last update: " + str(props[None]["LastUpdate"]))
                    if oldTime != props[None]["LastUpdate"]:
                        success = True
                        break
        
        return success
    

    def GetPolicyIds(strPolicy, strProduct, strType):
        ''' Function to return the Object Policy id's (taskId, objectId...) of the 
        given Policy.
        
        Inputs:
            strPolicy - the policy name.
            strProduct- the Product ID.
            strType   - Type of the policy (Ex: For Agent it's General/Repository). 
            
        Returns: Dictionary of Policy objects if found, else False.
        '''
        data = epo.policy.find(strPolicy)

        dom = xml.dom.minidom.parseString(data)
        nodes = dom.getElementsByTagName("ObjectPolicy")

        if nodes:
            objectPolicyList = []
            for i in range(len(nodes)):
                nodeMembers = None
                nodeMembers = nodes[i].childNodes
                nodeDict = {}
                for j in range(len(nodeMembers)):
                    if nodeMembers[j].firstChild:
                        nodeDict[nodeMembers[j].tagName] = nodeMembers[j].firstChild.data
                objectPolicyList.append(nodeDict)

            found = False
            for k in range(len(objectPolicyList)):
                if objectPolicyList[k]["objectName"] == strPolicy and \
                   objectPolicyList[k]["productId"] == strProduct and \
                   objectPolicyList[k]["typeName"] == strType:
                    found = True
                    break
            
            if found:
                return objectPolicyList[k]
            else:
                LogError("Could'nt get Policy objects. \
                          Check whether correct Policy name, type & Product Id was given...")
                return False
        else:
            LogError("Policy Not Found!")
            LogError("Is Policy %s imported into ePO ?" % strPolicy)
            return False


    def EPOAssignPolicy(strNode, strPolicy, strProduct="EPOAGENTMETA", 
                                            strFeature="EPOAGENTMETA",
                                            strType="General",
                                            strCategory="General"):
        '''Ask ePO to assign the given policy to the given node.
           The named policy must already exist on the ePO server.
    
        Inputs:
            strNode - the node name to assign to.
            strPolicy - the name of the policy to assign.
            strProduct - The ePO Product ID that the policy is for.
            strFeature - The feature text, usually the same as the prodID.
            strType - i.e. "VSC700_BehaviorBlock_Policies". Look in the policy XML file.
            strCategory - Usually the same as the policy type. Look in the XML file.
        
        Returns: True for success, otherwise False
        '''
        LogStr("Assigning policy " + strPolicy + " for " + strProduct + " to " + strNode)
        
        policyId = GetPolicyIds(strPolicy, strProduct, strType)
        if not policyId:
            return False
        
        try:
            epo.policy.assignToSystem(names     = strNode,
                                      productId = strProduct,
                                      featureId = strFeature,
                                      typeId    = policyId["typeId"],
                                      objectId  = policyId["objectId"])
        except EPORemoteCommand.CommandInvokerError, e:
            LogError("Failed to assign " + strPolicy + " policy to " + \
                     strNode + ": " + str(e))
            return False
    
        return True


    def EPOPushAgent(strNode, strInstPath="<PROGRAM_FILES_DIR>\McAfee\Common Framework", \
                     bForce=False, strBranch="Current"):
        '''Ask ePO push the Agent to the given node
    
        Inputs:
            strNode - the node name of the client to push to.
            strInstPath - where to install to on the client.
            bForce - Whether or not to do a force install.
            strBranch - which software branch to push from.
        
        Returns: True for success, otherwise False
        '''
        LogStr("Pushing agent to " + strNode)

        try:
            epo.system.deployAgent(names                = strNode, 
                                   agentPackage         = strBranch + "/EPOAGENT3000/Install/0409", 
                                   skipIfInstalled      = "False",
                                   suppressUI           = "True",
                                   forceInstall         = str(bForce),
                                   username             = g_strDomainUser,
                                   password             = g_strDomainPass,
                                   installPath          = strInstPath,
                                   domain               = g_strDomain,
                                   useAllHandlers       = "False",
                                   primaryAgentHandler  = "1", # The id of the primary agent handler. (id 1 is for master repository)
                                   retryIntervalSeconds = "60",
                                   attempts             = "0",
                                   abortAfterMinutes    = "5")
                                   #includeSubgroups    = "False",
                                   #useSsh              = "False")
        except EPORemoteCommand.CommandInvokerError, e:
            LogError("Failed to perform push agent to " + strNode + ": " + str(e))
            return False
            
        return True


    def GetRepositoryId(repository):
        ''' Get the repository Id for the given repository name. Mostly this is for
        Super Agent (SA) Repository only.
        
        Inputs:
            repository - The repository name to get the id.
        
        Returns: The id of the given repository, else False.
        '''
        data = epo.repository.find(repository)

        dom = xml.dom.minidom.parseString(data)
        nodes = dom.getElementsByTagName("RepositoryVO")

        if nodes:
            nodeMembers = nodes[0].childNodes
            found = False
            for j in range(len(nodeMembers)):
                if nodeMembers[j].firstChild:
                    if nodeMembers[j].tagName == "repositoryId":
                        found = True
                        repositoryId = nodeMembers[j].firstChild.data
            
            if found:
                return repositoryId
            else:
                LogError("Could'nt read Repository Id")
                return False
        else:
            LogError("Repository Not Found!")
            return False


    def EPOReplicate(lstRepositoryList=["*"], bIncremental="False"):
        '''Ask ePO to replicate to the given repositories
    
        Inputs:
            strRepositoryList - List of distributed repository names to replicate to.
                                "*" means all repositories.
            bIncremental - whether or not to do an incremental replication
            
        Returns: True for success, otherwise False
        '''
        for repository in lstRepositoryList:
            if repository.startswith("ePOSA"):
                repository = GetRepositoryId(repository)
                if not repository:
                    LogError("Failed to get repository ID for %s" % repository)
                    return False
            
            LogStr("Replicating to repository : %s" % repository)
        
            try:
                epo.repository.replicate(repositoryList=repository, incremental=bIncremental)                
            except EPORemoteCommand.CommandInvokerError, e:
                LogError("Failed to perform replication to %s" % repository + ": " + str(e))
                return False
    
        return True

        
    def GetTaskIds(taskName, product):
        ''' Function to return the Object Policy id's (taskId, objectId...) of the 
        given Policy.
        
        Inputs:
            taskName - the name of the Task.
            product  - The productId of the task. 
            
        Returns: Dictionary of Policy objects if found, else False.
        '''
        data = epo.clienttask.find(taskName)

        dom = xml.dom.minidom.parseString(data)
        nodes = dom.getElementsByTagName("ObjectTask")

        if nodes:
            objectTaskList = []
            for i in range(len(nodes)):
                nodeMembers = None
                nodeMembers = nodes[i].childNodes
                nodeDict = {}
                for j in range(len(nodeMembers)):
                    if nodeMembers[j].firstChild:
                        nodeDict[nodeMembers[j].tagName] = nodeMembers[j].firstChild.data
                objectTaskList.append(nodeDict)

            found = False
            for k in range(len(objectTaskList)):
                if objectTaskList[k]["objectName"] == taskName and \
                   objectTaskList[k]["productId"] == product:
                    found = True
                    break
            
            if found:
                return objectTaskList[k]
            else:
                LogError("Could'nt get Task objects. \
                          Check whether correct Task name & Product Id was given...")
                return False
        else:
            LogError("Task Not Found!")
            LogError("Is Task %s created/imported into ePO ?" % taskName)
            return False
        
        
    def EPORunNowTask(strNode, taskName, strProduct="EPOAGENTMETA",
                      randomInterval="0", stopAfter="20" ):
        '''RunNow the task specified on the given strNode.
           The specified task must already exist on the ePO server. Also the default Product
           is Agent (EPOAGENTMETA). Other Product's Id need to be explicitly specified.
    
        Inputs:
            strNode        - the node name to Run the Task.
            taskName       - The name of the Task that need to be run.
            strProduct     - The ProductID the Task belongs to (By default it takes Agent's ProductId).
            randomInterval - The randomization Interval (Default is 0 minutes i.e. immediate).
            stopAfter      - Stop task after x minutes (Default is 20 minutes).   
        
        Returns: True for success, otherwise False
        '''
        LogStr("Executing RunNow on Task " + taskName + " for " + strProduct + " to " + strNode)
        
        clientTaskId = GetTaskIds(taskName, strProduct)
        if not clientTaskId:
            return False
        
        try:
            epo.clienttask.run(names     = strNode,
                               productId = strProduct,
                               typeId    = clientTaskId["typeId"],
                               taskId    = clientTaskId["objectId"],
                               randomizationInterval = randomInterval,
                               stopAfterMinutes      = stopAfter)
        except EPORemoteCommand.CommandInvokerError, e:
            LogError("RunNow failed for task " + taskName + ": " + str(e))
            return False
    
        return True

    
    def EPOImportTasks(taskFilePath):
        '''Imports the task from the given path into ePO.
        
        Inputs:
            taskFilePath    - The local path for task file to import into ePO.
        
        Returns: True for success, otherwise False
        '''
        from os import path
        
        LogStr("Importing task %s into ePO" % path.basename(taskFilePath))
        inputFile = "file:///" + taskFilePath
        
        try:
            epo.clienttask.importClientTask(uploadFile=inputFile)
            ''' If you want to specify the task file path which is on ePO machine itself, then use the below command.            
            epo.clienttask.importClientTask(importFileName=taskFilePath)
            '''
        except EPORemoteCommand.CommandInvokerError, e:
            LogError("Importing task " + path.basename(taskFilePath) + " failed: " + str(e))
            return False
        
        return True


    def EPOCreateAgentTask(strNode, objTask, objSchedule):
        '''Create an agent task for the given node.
        
        *** note: This is just a wrapper function for ePO 4.6 to support backward compatibility.
        This function internally calls other ePO 4.6 specific functions in this order :
             -    EPOCreateTaskInCatalog() to create the task in the ePO task catalog, then
             -    EPOAssignTask() to assign this created task to the specified strNode
        
        Inputs:
            strNode     - the node name to assign the task.
            objTask     - a task object such as AgentDeploymentTask.
            objSchedule - a EPOTaskSchedule object that defines the task's schedule. 
        
        Returns: True for success, otherwise False
        '''
    
        taskSettings = objTask.getIBTExtensionString()
        if not taskSettings:
            LogError("Invalid task object")
            return False
        
        if not EPOCreateTaskInCatalog(objTask.name, objTask.type, objTask.platforms, taskSettings):
            LogError("Failed to create task in ePO Task Catalog.")
            return False
        
        if not EPOAssignTask(strNode, objTask.type, objTask.name, objSchedule):
            LogError("Failed to Assign the task %s" % objTask.name)
            return False
    
        return True


    def EPOAssignTask(strNode, taskType, taskName, objSchedule, productId="EPOAGENTMETA"):
        '''Assigns the specified task to the given strNode.
        note: The task should already exist in ePO for Assignment.
        
        Inputs:
            strNode     - The node name of the client at ePO.
            taskType    - The type of the task. For Agent, its either - Update/Deployment/Wakeup/Mirror.
                          For other product task types, refer the table EPOTaskTypes in ePO DB.
            taskName    - The name of the Task.
            objSchedule - An EPOTaskSchedule object that defines the task's schedule.
            productId     - The product Id the Task belongs to.
        
        Returns: True for success, otherwise False
        '''
        LogStr("Assigning task %s to client node %s" % (taskName, strNode))
        
        scheduleSettings = objSchedule.getIBTExtensionString()
        if not scheduleSettings:
            LogError("Invalid task schedule object")
            return False
        
        try:
            epo.ma.assignTask(computer = strNode,
                               type     = taskType,
                               name     = taskName,
                               settings = scheduleSettings,
                               product  = productId)
        except EPORemoteCommand.CommandInvokerError, e:
            LogError("Assigning task " + taskName + " failed: " + str(e))
            return False
        
        return True


    def EPOCreateTaskInCatalog(taskName, taskType, plat, taskSettings, prodId = "EPOAGENTMETA", desc = "FVT Created Task"):
        '''Just creates a new task in ePO task catalog (ePO4.6 feature) without any Assignment.
        
        *** note: This API should not be called from the scripts directly to create a task.
        Instead, use EPOCreateAgentTask() function. 
        
        Inputs:
            taskName      - The task name.
            taskType      - The type of the task. For Agent, its either - Update/Deployment/Wakeup/Mirror.
                            For other product task types, refer the table EPOTaskTypes in ePO DB.
            plat          - The platforms list.
            taskSettings  - The task settings.
        
        Returns: True for success, otherwise False
        '''
        LogStr("Creating new task <%s> in ePO task catalog" % taskName)
        
        try:
            epo.ma.newCreateTask(name          = taskName,
                                  type          = taskType,
                                  description   = desc,
                                  settings      = taskSettings,
                                  product       = prodId,
                                  platforms     = plat)
        except EPORemoteCommand.CommandInvokerError, e:
            LogError("Creating task " + taskName + " failed: " + str(e))
            return False
        
        return True


    def EPODeleteAllTasks(strNode):
        '''Delete all effective client tasks from a given node

        *** note: This is just a wrapper function for ePO 4.6 to support backward compatibility.
        This function internally calls the following ePO 4.6 specific function:
             -    EPODeleteAllAssignments() to delete only the Assignments for the given node.
             All Tasks will still remain in ePO Task Catalog, they will not be deleted.
    
        Inputs:
            strNode - the node name to delete from.
        
        Returns: True if deletion was successful, otherwise false
        '''
        
        if not EPODeleteAllAssignments(strNode):
            return False
    
        return True


    def EPODeleteAllAssignments(strNode):
        '''Delete all effective client Task Assignments from a given node.
    
        Inputs:
            strNode - the node name to delete the Assignments from.
        
        Returns: True if deletion was successful, otherwise false
        '''
        LogStr("Deleting all Assignments on %s" % strNode)
        
        try:
            epo.ma.deleteAssignment(computer = strNode)
        except EPORemoteCommand.CommandInvokerError, e:
            LogError("Deleting Task Assignments on %s " + strNode + " failed: " + str(e))
            return False
        
        return True
                

elif g_strEPOVer == "4.5":####################### Functions for ePO 4.5. ###############################
    
    import Utils
    from Tasks import *

    
    def EPOAgentWakeup(strNode, bCollectAllProps=False, iWait=None, bSuperAgent=False):
        '''Ask ePO to performa a wakeup on the requested node
    
        Inputs:
            strNode - the node name of the client to wakeup
            bCollectAllProps - whether or not to request all props
            iWait - if set, the function will wait this many
                           seconds for the "Last Update" property to
                           change in ePO.
                             
        Returns: True for success, otherwise False
        '''
        oldTime = ""
        if iWait:
            props = EPOGetProps(strNode)
            if props and "LastUpdate" in props[None]:
                LogStr("Last update before wakeup: " + str(props[None]["LastUpdate"]))
                oldTime = props[None]["LastUpdate"]
    
        LogStr("Waking up " + strNode)
    
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
            Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                       "ComputerMgmt.AgentWakeup", params)
        except Utils.RemoteEPOCmdError, inst:
            LogError("Agent wakeup failed on " + strNode + ": " + str(inst))
            success = False
    
        if iWait and success:
            success = False
            for i in range(iWait/4):
                time.sleep(4)
                props = EPOGetProps(strNode)            
                if props and "LastUpdate" in props[None]:
                    LogStr("Last update: " + str(props[None]["LastUpdate"]))
                    if oldTime != props[None]["LastUpdate"]:
                        success = True
                        break
    
        return success


    def EPOAssignAgentPolicy(strNode, strPolicy):
        '''Ask ePO to assign the given agent policy to the given node
    
        This is a deprecated API. Instead use EPOAssignPolicy with
        default args.
        '''
        LogStr("Assigning agent policy " + strPolicy + " to " + strNode)
        return EPOAssignPolicy(strNode, strPolicy)
    
    
    def EPOAssignPolicy(strNode, strPolicy, strProduct="EPOAGENTMETA", 
                                            strFeature="EPOAGENTMETA",
                                            strType="General",
                                            strCategory="General"):
        '''Ask ePO to assign the given agent policy to the given node
    
        The named policy must already exist on the ePO server and
        the custom IBT extension must be installed
    
        Inputs:
            strNode - the node name to assign to
            strPolicy - the name of the policy to assign
            strProduct - The ePO Product ID that the policy is for
            strFeature - The feature text, usually the same as the prodID
            strType - i.e. "VSC700_BehaviorBlock_Policies". Look in the policy XML file.
            strCategory - Usually the same as the policy type. Look in the XML file.
        
        Returns: True for success, otherwise False
        '''
        LogStr("Assigning policy " + strPolicy + " for " + strProduct + " to " + strNode)
        #pack epo policy params
        params = {"param1" : strNode,        #computer
                  "param2" : strPolicy,      #policy
                  "param3" : strProduct,     #product
                  "param4" : strFeature,     #feature
                  "param5" : strType,        #type
                  "param6" : strCategory}    #category
        
        try:
            Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                       "ma.assignPolicy", params)
        except Utils.RemoteEPOCmdError, inst:
            LogError("Failed to assign " + strPolicy + " policy to " + \
                     strNode + ": " + str(inst))
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
        LogStr("Creating " + objTask.type + " task for " + strNode)
    
        taskSettings = objSchedule.getIBTExtensionString()
        if not taskSettings:
            LogError("Invalid task schedule object")
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
            Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                       "ma.createTask", params)
        except Utils.RemoteEPOCmdError, inst:
            LogError("Failed to create deployment task at " + strNode + ": " + str(inst))
            return False
    
        return True

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
        LogStr("Pushing agent to " + strNode)
        
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
            Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                       "ComputerMgmt.PushAgent", params)
        except Utils.RemoteEPOCmdError, inst:
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
                result =  Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                                      "RepositoryMgmt.RepoNameToIdCmd", {"param1":repository})
                strRepositories += result.strip() + ","
            except Utils.RemoteEPOCmdError, inst:
                LogError("Failed to get repository ID for " + repository + ": " + str(inst))
                return False
    
        #strip the trailing comma
        if strRepositories[-1] == ",":
            strRepositories = strRepositories[:-1]
    
        LogStr("Replicating to repository list: " + strRepositories)
        #pack epo wakeup params
        params = {"param1" : strRepositories, #repo list
                  "param2" : False}           #incremental
        
        try:
            Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                       "RepositoryMgmt.ReplicateCmd", params)
        except Utils.RemoteEPOCmdError, inst:
            LogError("Failed to perform replication to " + strRepositories + ": " + str(inst))
            return False
    
        return True

    def EPODeleteAllTasks(strNode):
        '''Delete all effective client tasks from a given node
    
        Inputs:
            strNode - the node name to delete from
        
        Returns: True if deletion was successful, otherwise false
        '''
        LogStr("Deleting tasks on " + strNode)
        params = {"param1" : strNode}
    
        try:
            Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                       "ma.deleteTasks", params)
        except Utils.RemoteEPOCmdError, inst:
            LogError("Failed to delete tasks on " + strNode + ": " + str(inst))
            return False
    
        return True


############################ Common ePO Functions ######################################

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
    LogStr("Getting props for " + strNode)
    params = {"param1" : strNode}
    
    try:
        data = Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                          "ma.getProperties", params)
    except Utils.RemoteEPOCmdError, inst:
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
            LogStr("Wrong number of fields. Ignoring prop line:" + line)
    
    LogVerbose(str(props))    
    return props


def EPOExecuteQuery (strQuery):
    '''Gets the results of a SQL query against the ePO server.
    
    Inputs:
        strQuery - The SQL query to execute in ePO. 
        Must be url-friendly. For example, replace "%" with "%25".
        
    Returns: SQL query output.
            
    '''
    params = {"query" : strQuery}
    
    try:
        data = Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                          "ma.executeQuery", params)
    except Utils.RemoteEPOCmdError, inst:
        LogError("Failed to execute query for " + strQuery + ": " + str(inst))
        return None

    LogVerbose(str(data))    
    return data


def EPOGetUTCDate():
    '''Gets the current UTC DateTime of the ePO server.

    Returns: Current UTC DateTime of the ePO server.

    '''
    LogStr("Getting current DateTime from ePO server...")
    params = {}
    try:
        data = Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                          "ma.getUTCDate", params)
    except Utils.RemoteEPOCmdError, inst:
        LogError("Failed to get current ePO UTC DateTime: " + str(inst))
        return None

    LogVerbose(str(data))
    return data


def EPOFileExists(strFilePath):
    '''Determines whether a file exists on the ePO server.
    
    Inputs: 
        strFilePath - path and file name
         
    Returns: True if the file exists, otherwise False.
    
    '''
    params = { "file" : strFilePath }
    try:
        data = Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                          "ma.fileExists", params)
    except Utils.RemoteEPOCmdError, inst:
        LogError("Failed to determine whether file exists on ePO server: " + str(inst))
        return None
    
    LogVerbose(str(data))
    if (data == "true"):
        return True
    else:
        return False
  
    
def EPOGetFileMD5(strFilePath):
    '''Gets the MD5 of a file on the ePO server.
    
    Inputs: 
        strFilePath - path and file name
         
    Returns: MD5 hash if file exists, otherwise None.
    
    '''
    params = { "file" : strFilePath }
    try:
        data = Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                          "ma.getFileMD5", params)
    except Utils.RemoteEPOCmdError, inst:
        LogError("Failed to execute command: " + str(inst))
        return None
    
    LogVerbose(str(data))
    return data

def EPOSendDCMessage(strComputer, strMessageName, strMessage, strOriginName, strCorrelationID):
    '''Issues a remote command for ePO to send a Data Channel message.
    
    Inputs:
        strComputer: Target computer
        strMessageName: Message name
        strMessage: The message text
        strOriginName: Message origin
        strCorrelationID: Correlation ID
    
    Returns: ePO remote command output
     
    '''
    params = { "param1" : strComputer,
               "param2" : strMessageName,
               "param3" : strMessage,
               "param4" : strOriginName,
               "param5" : strCorrelationID }
    try:
        data = Utils.SendRemoteEPOCommand(g_strEPOSvr, g_strEPOUser, g_strEPOPass, \
                                          "ma.sendDataChannelMsg", params)
    except Utils.RemoteEPOCmdError, inst:
        LogError("Failed to issue Data Channel message request: " + str(inst))
        return None
    
    LogVerbose(str(data))
    return data
    



