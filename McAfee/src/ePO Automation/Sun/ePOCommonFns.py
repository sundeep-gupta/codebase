#!/usr/bin/python
import re
import time
import logging
from ePOCommandInvoker import *
from Tasks import *
# 
# We have to build the multi-part/file upload from scratch
# since python doesn't have it built in.
_ENCODE_TEMPLATE= """--%(boundary)s
Content-Disposition: form-data; name="%(name)s"

%(value)s
""".replace('\n','\r\n')

_ENCODE_TEMPLATE_FILE = """--%(boundary)s
Content-Disposition: form-data; name="%(name)s"; filename="%(filename)s"
Content-Type: %(contenttype)s

%(value)s
""".replace('\n','\r\n')

def _get_content_type(filename):
    return mimetypes.guess_type(filename)[0] or 'application/octet-stream'

def _encode_multipart_formdata(fields):
    BOUNDARY = '--' + mimetools.choose_boundary()

    body = ''

    for key, value in fields.iteritems():
        if isinstance(value, tuple):
            filename = value[0]
            content = value[1]
            body += _ENCODE_TEMPLATE_FILE % {
                        'boundary': BOUNDARY,
                        'name': str(key),
                        'value': str(content),
                        'filename': str(filename),
                        'contenttype': str(_get_content_type(filename))
                    }
        else:
            body += _ENCODE_TEMPLATE % {
                        'boundary': BOUNDARY,
                        'name': str(key),
                        'value': str(value)
                    }

    body += '--%s--\n\r' % BOUNDARY
    content_type = 'multipart/form-data; boundary=%s' % BOUNDARY

    return body, content_type

class ePolicyOrchestrator :
    def __init__(self, server, user, password) :
        self.server = server
        self.user = user
        self.password = password
        self.port = 8443
        self.baseurl = 'https://' + self.server + ':' + str(self.port)
        self.prefix = 'remote'
        
        # self._invoker = ePOCommandInvoker(self.server, self.port, self.user, self.password)

    def authenticate(self) :
        # Create an OpenerDirector with support for Basic HTTP Authentication...
        auth_handler = urllib2.HTTPBasicAuthHandler()
        auth_handler.add_password("Orion remote command realm", self.baseurl, self.user, self.password)
        self.opener = urllib2.build_opener(auth_handler)
        # ...and install it globally so it can be used with urlopen.
        urllib2.install_opener(self.opener)

    def run(self, *args, **kwargs):
        argmap = {}
        cmdName = None
        if (len(list(args)) < 1):
            raise Exception('run requires at least one positional argument and it must be the command name')
        if len(list(args)) != 0:
            for index, value in enumerate(args):
                if(index == 0):
                    cmdName = value
                else:
                    argmap['param' + str(index)] = value
        if len(list(kwargs)) != 0:
            for key in kwargs.keys():
                argmap[key] = kwargs[key]
        try:
            # return self._invoker.invoke(cmdName, argmap)
            return self._invoke(cmdName, argmap)
        except CommandInvokerError, e:
            if str(e).find('No such command') != -1:
                msg = "'" + self.prefix + "' has no attribute '" + self.name + "' (make sure the command exists and that mcafee.client(...) was called prior to invoking the command)"
                raise AttributeError(msg)
            else:
                raise e

    def _invoke(self, command, args) :
        argscopy = args
        # Extract the file upload arguments, put them in data
        fileargs = {}
        deletekeys = []
        # If command does not have prefix, add default one.
        if re.search('/', command) is None :
            command = self.prefix + '/' + command

        for key in argscopy:
            if argscopy[key][:8] == 'file:///':
                filename = argscopy[key][8:]
                content = self.get_file_contents(filename)
                fileargs[key] = (filename, content)
                deletekeys.append(key)

        # File upload arguments need to be deleted from being build as part of query.
        for key in deletekeys:
            del argscopy[key]
	
        # Get the url and params appended to build the HTTP request string.
        commandURI = self.build_url_request(command, argscopy)

 	self.authenticate()
        sock = self.create_sock(commandURI, fileargs) 
        resultStr = sock.read()
        sock.close()
        print resultStr

    def build_url_request(self, command, args) :
        queryString = "&".join(["%s=%s" % (quote(str(k)), quote(v)) for k, v in args.items()])
        url = self.baseurl + '/' + command + '.do'
        url += '?' + queryString
        return url


    def create_sock(self, url, args) :
        """Open the socket and return the connection"""

        # If no args it is simple request with no file upload operations.
        if( len(args) == 0):
            return self.opener.open(url)
        else:
            """ if args, then we need to fetch the content and append it to data section """
            body, content_type = _encode_multipart_formdata(args)
            data = 'Content-Type: ' + content_type + '\r\n'
            data += 'Content-Length: ' + str(len(body)) + '\r\n\r\n'
            data += body
            headers = {'Content-Type':content_type}
            req = Request(url, data, headers)
            return self.opener.open(req)

       
    def get_file_contents(self, filename):
        readmode = 'r'  #assume text file
        type = mimetypes.guess_type(filename)[0] or 'application/octet-stream'

        if(type[:3] != 'text'):
            readmode = 'rb'  #binary file
        f = open(filename, readmode)
        content = f.read()
        f.close()
        return content

    def installExtension(self, fileUrl, deleteIfExists=False) :
        return self.run('ext.install', fileUrl, 'force')

    def agentWakeup(self, node, bCollectAllProps = False, bSuperAgent=False) :
        return self.run('ComputerMgmt.AgentWakeup', str(bCollectAllProps), str(bSuperAgent), '0', node, '0', '0', str(False), 'csv_comp_names')

    def addPolicy(self, policy_file) :
	return self.run('PolicyMgmt.importPolicies', policy_file)

    def uninstallExtension(self, extension, force=True) :
        return self.run('ext.uninstall', extension, 'force')
    
    def installProduct(self, host, product, version) :
        deploymentTask = AgentDeploymentTask('TestDeployment of EEMac')
        deploymentTask.setPlatforms('MAC')
        print "Calling deploymentTask.addProduct"
        deploymentTask.addProduct(product, version)
        deploymentTask.setRunAtEveryPolicyEnforcement(False)
        taskSchedule = EPOTaskSchedule(EPOTaskSchedule.SCHED_TYPE_RUN_IMMEDIATELY)
        if not self.createAgentTask(host, deploymentTask, taskSchedule):
            raise 'Failed to create Agent task'
        logging.info("Deployment Task Created")
        return 0
        if not self.agentWakeup(host, False):
            logging.error("Not able to send the agent wake up call")
            return 1
        logging.info("Agent wake up call sent successfully")
        return 0
    
    def createAgentTask(self, strNode, objTask, objSchedule):
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
    
        self.run('ibt.createTask', strNode, objTask.type, objTask.name, 'FVT created Task',
                'EPOAGENTMETA', objTask.platforms, taskSettings)
        return True
if __name__ == '__main__' :
    ePO = ePolicyOrchestrator('172.16.193.75', 'admin', 'nai123')
    # ePO.authenticate()
    # ePO.authenticate()
    # ePO.EPOAgentWakeup('Give-a-unique-name.local')
    # ePO.addPolicy('file:////Volumes/Soulful/DefaultPolicy.xml')
    # ePO.installExtension('file:////Volumes/Soulful/EEMAC.zip')
    # ePO.uninstallExtension('EEMAC')

    # Product ID and Version is the problem here...
    # prod = 'EEADMIN_1000MACX'
    # ver = '1.0.0141'
    #prod = 'EPOAGENT3700MACX'
    #ver = '4.6.01331'
    prod = 'EEMAC:1.0.0141'
    ver = '1.0.0141'
    print ePO.installProduct('Nimish-MacbookAir.local', prod , '')
