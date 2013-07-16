'''
Utils.py

Author:        Chris Tissell
Description:   This is London Bridge's Util function module.
               It contains functions and classes that are used
               by London Bridge, but aren't strictly part of the
               HelperFuncs module
'''

import urllib2, urllib, time, random
    
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
    opener = urllib2.build_opener(auth_handler)
    # ...and install it globally so it can be used with urlopen.
    urllib2.install_opener(opener)
        
    data = urllib.urlencode(compiledParams)
    
    try:
        result = urllib2.urlopen(url, data)
    except Exception, inst:
        raise RemoteEPOCmdError("There was an error contacting the ePO server: " + \
                                str(inst))
        
    lines = result.read()
        
    if lines.lower().find("error:") != -1:
        raise RemoteEPOCmdError("ePO command " + strCmd + \
                                " returned an error: " + commandURI + ":" + lines)
    #strip off brackets
    return lines[lines.find("[")+1 : lines.rfind("]")]