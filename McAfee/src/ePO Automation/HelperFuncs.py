

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
            LogStr("Last update: " + str(props[None]["LastUpdate"]))
            if props and "LastUpdate" in props[None] and \
            oldTime != props[None]["LastUpdate"]:
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
                                   "ibt.assignPolicy", params)
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
                                   "ibt.createTask", params)
    except Utils.RemoteEPOCmdError, inst:
        LogError("Failed to create deployment task at " + strNode + ": " + str(inst))
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
                                   "ibt.deleteTasks", params)
    except Utils.RemoteEPOCmdError, inst:
        LogError("Failed to delete tasks on " + strNode + ": " + str(inst))
        return False
    
    return True

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
                                          "ibt.getProperties", params)
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



