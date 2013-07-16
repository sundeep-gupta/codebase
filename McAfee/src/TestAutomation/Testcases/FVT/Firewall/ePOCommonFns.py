#!/usr/bin/python

# Copyright (C) 2011, McAfee Inc., All Rights Reserved

import re
import time
import logging
import mimetools, mimetypes
import urllib
import urllib2
import os
import sys

# Import Tasks module into current namespace

common_path=os.path.dirname(os.path.abspath(sys.argv[0])) + "/3rdparty/"
sys.path.append(common_path)

from Tasks import *
from urllib import quote
from urllib2 import HTTPError, URLError, Request


class EPOCommandException(Exception):
    '''Exception thrown when any error occurs in running ePO commands'''
    def __init__(self, error):
        self.value = error
        return
    def __str__(self):
        return str(self.value)


##########################################################################
# We have to build the multi-part/file upload from scratch
# since python doesn't have it built in.
##########################################################################
_ENCODE_TEMPLATE= """--%(boundary)s
Content-Disposition: form-data; name="%(name)s"

%(value)s
""".replace('\n','\r\n')

_ENCODE_TEMPLATE_FILE = """--%(boundary)s
Content-Disposition: form-data; name="%(name)s"; filename="%(filename)s"
Content-Type: %(contenttype)s

%(value)s
""".replace('\n','\r\n')

#########################################################################
# Some private functions. Maybe we can move them to commonFns if 
# we need the same in some other library.
#########################################################################
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
    '''Class for performing ePO related tasks.'''
    def __init__(self, server, user, password, port = 8443) :
        '''Initialization of the ePO object.
        @param server - IP of the ePO server
        @param user - user name of the ePO server
        @param password - password for the ePO user
        @param port - (optional) port number at which server is listening. Default is 8443
        '''
        self.server = server
        self.user = user
        self.password = password
        self.port = port
        self.baseurl = 'https://' + self.server + ':' + str(self.port)
        self.prefix = 'remote'
        

    def authenticate(self) :
        ''' This is private method used to add HTTP Basic authentication Handler for the requests.'''
        # Create an OpenerDirector with support for Basic HTTP Authentication...
        auth_handler = urllib2.HTTPBasicAuthHandler()
        auth_handler.add_password("Orion remote command realm", self.baseurl, self.user, self.password)
        self.opener = urllib2.build_opener(auth_handler)
        # ...and install it globally so it can be used with urlopen.
        urllib2.install_opener(self.opener)

    def run(self, *args, **kwargs):
        '''Internal method which is the core method to run any ePO command
        @param *args - list containing ePO command and the parameters. It must have atleast one element.
        @param **kwargs - dict containing the params to be passed along with ePO command. (optional)
        
        If params to ePO command are passed in *args, a dict is constructed out of it.
        
        '''
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
        return self._invoke(cmdName, argmap)

    def _invoke(self, command, args) :
        '''private method to send the request to ePO server and get back the response.
        
        It constructs the POST request based on the command and the arguments provided.
        if the args has a file uri, it fetches the content of the file and appends it
        in the post request.
        '''
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
                if not content : 
                    print "Returning false"
                    return False
                fileargs[key] = (filename, content)
                deletekeys.append(key)

        # File upload arguments need to be deleted from being build as part of query.
        for key in deletekeys:
            del argscopy[key]
	
        # Get the url and params appended to build the HTTP request string.
        commandURI = self.build_url_request(command, argscopy)
        if not commandURI :
            return None
        self.authenticate()
        sock = self.create_sock(commandURI, fileargs) 
        resultStr = sock.read()
        sock.close()
        # Now we have result of post request. We might want to check if the command was successful based 
        # on what we recieve. Currently we will return the complete socket result.
        return resultStr

    def build_url_request(self, command, args) :
        '''Builds the URL query string based on the arguments provided and returns the same.'''
        url = self.baseurl + '/' + command + '.do'
        if args is not None and len(args) > 0 :
            queryString = "&".join(["%s=%s" % (quote(str(k)), quote(v)) for k, v in args.items()])
            url += '?' + queryString
        return url


    def create_sock(self, url, args) :
        """Open the socket and return the connection"""

        # If no args it is simple request with no file upload operations.
        if( len(args) == 0):
            return self.opener.open(url)
        
        # if args, then we need to fetch the content and append it to data section
        body, content_type = _encode_multipart_formdata(args)
        data = 'Content-Type: ' + content_type + '\r\n'
        data += 'Content-Length: ' + str(len(body)) + '\r\n\r\n'
        data += body
        headers = {'Content-Type':content_type}
        req = Request(url, data, headers)
        return self.opener.open(req)

       
    def get_file_contents(self, filename):
        '''Returns the content of the given file.'''

        readmode = 'r'  #assume text file
        type = mimetypes.guess_type(filename)[0] or 'application/octet-stream'

        if(type[:3] != 'text'):
            readmode = 'rb'  #binary file
        try:
            f = open(filename, readmode)
            content = f.read()
            f.close()
            return content
        except IOError:
            logging.error("Not able to open the file")
            return False

    def installExtension(self, fileUrl, deleteIfExists=False) :
        '''Runs ext.install command on ePO to install the given extension.
        @param fileUrl - path of the file in URL format [ file:////Volumes/DATA/EEMAC.zip ]
        @param deleteIfExists - bool specifying if the extension has to be deleted if it already exist.
        '''
        if deleteIfExists :
            return self.run('ext.install', fileUrl, 'force')

        return self.run('ext.install', fileUrl)

    def agentWakeup(self, node, bCollectAllProps = False, bSuperAgent=False) :
        '''Perform the agent wakeup call by sending the 'ComputerMgmt.AgentWakeup' command to ePO.
        
        @param node - string containing hostname of the machine to which agent wakeup call has to be sent.
        @param bCollectAllProps - bool specifying if all properties needs to be collected or not.
        @param bSuperAgent - bool specifying if SuperAgent parameter has to be set.
        '''
        return self.run('ComputerMgmt.AgentWakeup', str(bCollectAllProps), str(bSuperAgent), '0', node, '0', '0', 'False', 'csv_comp_names')

    def addPolicy(self, policy_file) :
        '''creates a new policy based on the policy file provided.

        It runs the PolicyMgmt.importPolicies command to add the given policy.
        @param policy_file - path of file in url format.
        '''
        return self.run('PolicyMgmt.importPolicies', policy_file)

    def uninstallExtension(self, extension, force=True) :
        '''Uninstalls the given extension from ePO. 
        
        @param extension - name of the extension to be deleted from ePO.
        @param force - whether the extension has to be removed forcibly or not. Default is True.
        '''
        if force :
            return self.run('ext.uninstall', extension, 'force')
        return self.run('ext.uninstall', extension)


    def installProduct(self, host, product, version, platform, lang=AgentDeploymentTask.LANG_ENGLISH) :
        '''Installs the given product on the given machine.

        @param host - hostname of the machine in which product has to be installed.
        @param product - Product to be installed. It must be product Id.
        @param version - Version of the product to install.
        @param platform - Platform where the product to be installed MAC/LINUX.
        
        TODO : Currently only McAfee Agent product is getting added. 
               Tried with EEMac, EEADMIN, MSM and could not able to create deployment task
               successfully. The problem is task is getting created but product is not
               getting selected.
        '''
        deploymentTask = AgentDeploymentTask('TestDeployment of ' + product)
        deploymentTask.setPlatforms(platform)
        deploymentTask.addProduct(product, version, strLang=lang)
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
    
        @param strNode - the node name to assign the task to
        @param objTask - a task object such as AgentDeploymentTask
        @param objSchedule - An EPOTaskSchedule object that defines
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

    def assignPolicy(node, policyDetails):
        '''
        Assigns a policy to the node. 
        @param node - The hostname of the machine to which policy needs to be assigned.
        @param policyDetails - A dict object with following keys :
                type - Type of the policy
                name - Name of the policy
                product - The product to which this policy belongs
                feature - Feature of the product [ usually the product name itself, but check in policy xml file]
                category - Category to which policy belongs [ can be found from policy's xml file ]
        '''
        if node is None :
            logging.error('Node value must be specified')
            return False
        if policyDetails is None or ['type', 'name', 'feature', 'category', 'product'] not in policyDetails.keys() :
            logging.error('Missing the required policyDetails')
            return False
        return self.run('ibt.assignPolicy', node, policyDetails['name'], policyDetails['product'], policyDetails['feature'], 
                policyDetails['type'], policyDetails['category'])


    def checkExtensionExists(self, extension) :
        '''Checks if the given extension exists in the epo.
        @param - extension : name of the extension to verify.
        '''
        extns = self._getInstalledExtensions()
        for extn in extns :
            if extn['name'] == extension :
                return True
        return False


    def _getInstalledExtensions(self) :
        output = self.run('ext.list')
        output = output.split('\n')
        extns = []
        for line in output  :
            m = re.search('^(.+)\s+([\d\.]+)\s+(\w+)\s+(\w+)\s+(.*)$', line) 
            if m is not None :
                extn = {'name' : m.group(1), 'version' : m.group(2), 'state' : m.group(3), 'user' : m.group(4), 'timestamp' : m.group(5)}
                extns.append(extn)
        return extns

    def isProductCheckedIn(self, prod_name) :
        ''' To be implemented by pavan using ruby-watir'''
        return True

    def getAgentInstaller(self) :
        ''' To be implemented by pavan using ruby-watir'''
        return 'data/install.sh'



    def getSystemProperties(self, node) :
        '''
        Gets the system properties of the node from the epo and constructs a dictionary of key/value
        pair and returns the same. 

        @param node - Node for which the properties need to be collected
        @return dict containing the key/value pair. None in case no properties collected.
        '''
        props = self.run('ibt.getProperties', node)
        props = props.split('\n')
        filter_props = [ line.strip() for line in props if len(line.strip()) > 0]
        if len(filter_props) <= 1 :
            return None
        dict_props = dict()
        for p in filter_props :
            words = p.split('\t')
            if len(words) ==  2 :
                dict_props[words[0]] = words[1]
            elif len(words[:-2]) >= 2 :
                tmp_dict = dict_props
                for k in words[:-2] :
                    if not tmp_dict.has_key(k) :
                        tmp_dict[k] = dict()
                    tmp_dict = tmp_dict[k]
                tmp_dict[words[-2]] = words[-1] 
        return dict_props

# Following is an example on how to use this class and methods.
if __name__ == '__main__' :
    ePO = ePolicyOrchestrator('172.16.193.75', 'admin', 'nai123')
    # print ePO.getSystemProperties('Halcyon')
    # ePO.authenticate()
    # ePO.authenticate()
    # ePO.EPOAgentWakeup('Give-a-unique-name.local')
    # ePO.addPolicy('file:////Volumes/Soulful/DefaultPolicy.xml')
    # ePO.installExtension('file:////Volumes/Soulful/EEMAC.zip')
    # ePO.uninstallExtension('EEMAC')

    # Product ID and Version is the problem here...
    prod = 'EEADMIN_1000MACX'
    ver = '1.0.0141'
    #prod = 'EPOAGENT3700MACX'
    #ver = '4.6.01331'
    #prod = 'EEMAC:1.0.0141'
    #ver = '1.0.0141'
    platform = 'MAC'
    print ePO.installProduct('Halcyon', prod , ver, platform, AgentDeploymentTask.LANG_NEUTRAL)


