# Copyright (C) 2009 McAfee, Inc.  All Rights Reserved.
import sys
import urllib, urllib2
import json
import mimetools, mimetypes
from urllib2 import HTTPError, URLError, Request

from urllib import quote

#debug is a global setting, that is all instances of
#client will have debugging turned on or off
debug = 0

def print_debug(msg):
    if debug == 1:
        print msg

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
    """
    Given a dictionary field parameters, returns the HTTP request body and the
    content_type (which includes the boundary string), to be used with an
    httplib-like call.

    Normal key/value items are treated as regular parameters, but key/tuple
    items are treated as files, where a value tuple is a (filename, data) tuple.

    For example:

    fields = {
        'foo': 'bar',
        'foofile': ('foofile.txt', 'contents of foofile'),
    }

    body, content_type = _encode_multipart_formdata(fields)
    """

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

"""
We create our own exception and override __str__ so we can use a unicode string
Python 2.6 can't handle unicode strings in Exceptions

See http://bugs.python.org/issue2517
"""
class CommandInvokerError(Exception):
    def __str__(self):
        return repr(self.args[0])
    
class _CommandInvoker:
    """Handles processing of a remote command request.
    This class is only intended for use inside this script (private)
    """
    
    def __init__(self, host, port, username, password, protocol, output):
        """Initializes the invoker by setting up basic authentication
            with given parameters.
        
        @param host - the servers name (string)
        @param port - the port to connect to on host (string)
        @param username - the username (string)
        @param password - the username's password (string)
        @param protocol - (optional) the protocol to use ('http','https')
        @param output - (optional) the requested output type from the server: one of ('terse','verbose','json','xml')
        the default is 'json'.  terse and verbose outputs are in a human readable form.
        """
        #The following should be tuples not lists, because they
        #are constants, however jython does not have an index method
        #on a tuple (python does), hence they are lists to be compatible
        #with both
        self.outputs = ['terse', 'verbose', 'json', 'xml']
        self.protocols = ['https', 'http']
        self.host = host
        self.port = str(port)

        #sanity checks
        try:
            self.protocols.index(protocol)
            self.protocol = protocol
        except:
            raise CommandInvokerError('Unsupported protocol: ' + protocol)

        try:
            self.outputs.index(output)
            self.output = output
        except:
            raise CommandInvokerError('Unsupported output: ' + output)
        
        self.baseurl = protocol + '://' + self.host + ':' + self.port + '/remote'

        #Setup a handler to pass credentials for BASIC auth
        passmgr = urllib2.HTTPPasswordMgrWithDefaultRealm()
        passmgr.add_password(None, self.baseurl, username.encode("utf-8"), password.encode("utf-8"))
        authhandler = urllib2.HTTPBasicAuthHandler(passmgr)
        self.opener = urllib2.build_opener(authhandler, urllib2.HTTPCookieProcessor())

    def test_conn(self, output):
        """Verifies connectivity and credentials by running a sample command 
        against the server. Throws on error.
        The given argument output is the original output type
        requested by the user.  We need this so we can reset the output type
        on the command invoker after we change it here for the test.
        @param output - the user's requested output
        """
        self.output = 'json'  #request json so the output is not printed on console
        url = self.build_url_request('core.getSecurityToken', {})
        resultStr = ''
        try:
            sock = self.create_socket(url, {})
            resultStr = sock.read()
            self.token = resultStr[3:].strip()
            sock.close()
            print_debug('Response:\n' + resultStr)
        except HTTPError, e:
            err = 'The server ' + self.host + ':' + self.port + ' couldn\'t fulfill the request. '
            raise CommandInvokerError(err + str(e))
        except URLError, e:
            err = 'Failed to reach the server ' + self.host + ':' + self.port + '. Error/Reason: ' 
            raise CommandInvokerError(err + ' ' + str(e.reason))
        #reset the output type back to user's request
        self.output = output

    def invoke(self, command, args={}):
        """Submits the requested command to the server, returning the results
        of the command's invocation according to the output type specified on 
        class creation, however, the output type can be overridden for this 
        invocation by passing in the argument ':output'.  It must be one of the
        supported protocols: terse, verbose, xml, or json.
        
        @param command - the name of the command (i.e., prefix.commandName.do)
        @param args - a dictionary of named arguments
        @returns the results of invoking the command as a json object
        @throws CommandInvokerException on error
        """
        argscopy = args
        output = None  # the output type for this invocation
        try:
            argscopy[':output'] = args[':output']
        except KeyError, e:
            #no overriding output type was specified so we use the default
            argscopy[':output'] = self.output
        output = argscopy[':output']
        self.test_conn(output)

        #Extract the file upload arguments, put them in data
        fileargs = {}
        deletekeys = []
        for key in argscopy:
            if argscopy[key][:8] == 'file:///':
                filename = argscopy[key][8:]
                content = self.get_file_contents(filename)
                fileargs[key] = (filename, content)
                deletekeys.append(key)
        for key in deletekeys:
            del argscopy[key]

        argscopy["orion.user.security.token"] = self.token
        url = self.build_url_request(command, argscopy)
        resultStr = ''
        try:
            sock = self.create_socket(url, fileargs)
            resultStr = sock.read()
            sock.close()
            print_debug('Response:\n' + resultStr)
        except HTTPError, e:
            err = 'The server ' + self.host + ':' + self.port + ' couldn\'t fulfill the request. '
            raise CommandInvokerError(err + str(e))
        except URLError, e:
            err = 'Failed to reach the server ' + self.host + ':' + self.port + '. Error/Reason: ' 
            raise CommandInvokerError(err + ' ' + str(e.reason))
        d = self.parse_result(resultStr)
        if d["status"] == 'OK':
            pass 
        elif d["status"] == 'Error':
            raise CommandInvokerError(d["result"].decode('utf-8'))
        else:
            raise CommandInvokerError('Unknown error occurred.  Status: (' + d["status"] + ') Result: ' + d["result"])

        if output == 'json':
            try:
                return json.loads(d["result"])
            except ValueError, e:
                err = 'Error parsing JSON result (double quotes should be escaped): ' + str(e)
                raise CommandInvokerError(err)
        elif output == 'xml':
             return d["result"]
        elif output == 'terse' or output == 'verbose':
             print d["result"].decode('utf-8')
    
    def parse_result(self, s):
        """ Parses the result returned from a remote command invocation
            
        @returns dictionary containing two keys
            status - the status of the command, one of (OK, Error)
            data - the data returned from the command
        """
        d = {}
        try:
            status = s[:s.index(':')]
            result = s[s.index(':')+1:].strip()
            d = {'status':status, 'result':result}
        except: #for thoroughness, in case there's no colon in the output
            d = {'status':'Error', 'result':'An unexpected error occurred'}
        return d    
    
    def build_url_request(self, command, args):
        """Helper function to construct the url that will be requested from the server
        
        @param command - the command name (i.e., prefix.commandName)
        @param args - dictionary of the arguments to pass (i.e., {"arg":"value"})
        @returns the url to fetch (i.e, http://servername:8080/remote/prefix.commandName.do?arg=value)
        """
        queryString = "&".join(["%s=%s" % (quote(str(k)), quote(v)) for k, v in args.items()])
        url = self.baseurl + '/' + command + '.do'
        url += '?' + queryString
        return url

    def create_socket(self, url, args):
        """Helper function to encapsulate getting a socket
            
            @param url - the url to fetch (query string already appended)
            @param args - the file arguments as a tuple (filename, contents)
        """
        print_debug('Request: ' + url)
        if( len(args) == 0):
            return self.opener.open(url)
        else:
            body, content_type = _encode_multipart_formdata(args)
            data = 'Content-Type: ' + content_type + '\r\n'
            data += 'Content-Length: ' + str(len(body)) + '\r\n\r\n'
            data += body
            print_debug('postdata:\r\n' + data)
            headers = {'Content-Type':content_type}
            req = Request(url, data, headers)
            return self.opener.open(req)
        
    def get_file_contents(self, filename):
        readmode = 'r'  #assume text file
        type = _get_content_type(filename)
        if(type[:3] != 'text'):
            readmode = 'rb'  #binary file
        f = open(filename, readmode)
        content = f.read()
        f.close()
        return content
           
        

def _get_command_names(invoker, feature=None):
    """Get a list of command names using core.help
    This will only return the name of the command after
    the feature name...so if you call _get_command_names
    """
    #We only want json output here
    if feature == None:
        result = invoker.invoke('core.help', {':output':'json'})
    else:
        result = invoker.invoke('core.help', {'prefix':feature,':output':'json'})
        
    cmds = []
    for help in result:
        #need to use str() to convert fullName from unicode to ascii
        #otherwise it wont get appended to __members__
        fullName = str(help[:help.index(' ')])
        if feature != None:
            #get only the name of the command minus the prefix
            fullName = fullName[fullName.index('.')+1:] 
        cmds.append(fullName)
    return cmds

def _get_command_prefixes(invoker):
    """Returns a list of all the defined command prefixes"""
    cmds={} 
    #cmds will be something like
    # {
    #  "core":["help","listUsers"],
    #  "tasklog":["listMessages","anotherCommand"]
    # }
    for fullName in _get_command_names(invoker):
        prefix = fullName[:fullName.index('.')]
        try:
            cmds[prefix].append('') #value appended is unimportant
        except:
            cmds[prefix] = []
    return cmds.keys()

class _PyCommand:
    """Represents an instance of a Python remote command"""

    def __init__(self, invoker, prefix, name):
        self.invoker = invoker
        self.prefix = prefix
        self.name = name
        
    def __call__(self, *args, **kwargs):
        argmap = {}
        if len(list(args)) != 0:
            for index, value in enumerate(args):
                argmap['param' + str(index+1)] = value
        if len(list(kwargs)) != 0:
            for key in kwargs.keys():
                argmap[key] = kwargs[key]
        try:
            return self.invoker.invoke(self.prefix + '.' + self.name, argmap)
        except CommandInvokerError, e:
            if str(e).find('No such command') != -1:
                msg = "'" + self.prefix + "' has no attribute '" + self.name + "' (make sure the command exists and that mcafee.client(...) was called prior to invoking the command)"
                raise AttributeError(msg)
            else:
                raise e


class _PyFeature:
    """_PyFeatureGroup represents an object in the 'client' class scope
    corresponding to the feature group in a remote command (e.g., core, tasklog)
    
    @param name - the name of the command
    """

    def __init__(self, invoker, name):
        self._module = name
        self._invoker = invoker
        
    def __getattr__(self, attr):
        """When the caller requests attributes that are not available, assume
        the caller wants to create a _PyCommand.  Also catch calls that dir()
        makes so we can return a list of commands"""
        cmd = attr # for clarity...this is the command name, ie, listUsers
        
        #We must catch accessing __members__,__repr__, and __str__ attributes
        #otherwise it will attempt to create a PyCommand and hence hit the server
        #which we don't want.
        if cmd == '__members__': 
            return # there are no members of a PyClient, only methods
        if cmd == '__methods__':
            return _get_command_names(self._invoker, self._module)
        if cmd == '__repr__': 
            return # should anything be returned here?
        if cmd == '__str__': 
            return # should anything be returned here?
        print_debug('instantiate _PyCommand(' + self._module + "." + cmd + ', ...)')
        pc = _PyCommand(self._invoker, self._module, cmd)
        return pc

class client(object):
    """Allows accessing an unknown, undefined attribute 'attr'
    in this object.  Instantiating an instance of this class will provide
    access to mcafee commands.
    
    @param host - the host name
    @param port - the port name
    @param username - the username
    @param password - the password
    @param protocol - the protocol to use for the connection (default='https')
    @param output - the requested format from the server (default='json')
    
    Example:
    
    >>> import mcafee
    >>> mc = mcafee.client('host','port','usr','pwd')
    >>> mc.core.commandName()
    
    """
    
    def __init__(self, host, port, username, password, protocol='https', output='json'):
        self._invoker = _CommandInvoker(host, port, username, password, protocol, output)
        #hit the server so we can verify server and credentials will throw on error
        self._invoker.test_conn(output)
        
    def __getattr__(self, attr):
        """When the caller requests attributes that are not available, assume
        the caller wants to create a _PyFeature, otherwise return the attribute"""
        feature = attr #for clarity
        #The following is to overcome http://bugs.python.org/issue5370
        #If we use getattr(self, attr) we get infinite recursion
        if 'attrs' in self.__dict__ and name in self.attrs:
            return self.attrs[name]
        else:
            if attr == '__members__': 
                return _get_command_prefixes(self._invoker)
            print_debug('instantiate _PyFeature(' + feature + ')')
            return _PyFeature(self._invoker, feature)

    def help(self, command=None):
        """Prints help for all commands or a specified command
        Use this command to get help on mcafee commands rather than python's
        built-in help().
        
        @param command - the command name
        
        Example:
        
        >>> import mcafee
        >>> mc = mcafee.client('host','port','usr','pwd')
        >>> mc.help('core.help')
        
        """
        #Override the default output type so the output is human readable
        if (command != None):
            self._invoker.invoke("core.help", {'command':command,':output':'terse'})
        else:
            self._invoker.invoke("core.help", {':output':'terse'})

    def run(self, *args, **kwargs):
        """Runs an arbitrary command with positional and/or named arguments
        Expects the first positional argument to be the command name
        
        For example,
            >>> import mcafee
            >>> c = mcafee.client(host,port,usr,pwd)
            >>> c.run('core.addUser','testUser','testUser')
            True
            >>>
        """
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
            return self._invoker.invoke(cmdName, argmap)
        except CommandInvokerError, e:
            if str(e).find('No such command') != -1:
                msg = "'" + self.prefix + "' has no attribute '" + self.name + "' (make sure the command exists and that mcafee.client(...) was called prior to invoking the command)"
                raise AttributeError(msg)
            else:
                raise e

            
    def _run(self, command, args={}):
        """Runs an arbitrary commmand
        
        @param command - the command name
        @param args - dictionary of arguments to the command
        
        """
            
        return self._invoker.invoke(command, args)                
