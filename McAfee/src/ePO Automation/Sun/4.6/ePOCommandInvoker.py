import urllib2
import urllib

# For 4.6
from urllib2 import HTTPError, URLError, Request
from urllib import quote
"""
We create our own exception and override __str__ so we can use a unicode string
Python 2.6 can't handle unicode strings in Exceptions

See http://bugs.python.org/issue2517
"""
class CommandInvokerError(Exception):
    def __str__(self):
        return repr(self.args[0])

class RemoteEPOCmdError(Exception):
    
    def __init__(self, error):
        self.value = error
        return
    def __str__(self):
        return str(self.value)
class ePOCommandInvoker:
    """Handles processing of a remote command request.
    This class is only intended for use inside this script (private)
    """
    
    def __init__(self, host, port, username, password)
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
        self.host = host
        self.port = str(port)
        self.username = username
        self.password = password
        # self.baseurl = protocol + '://' + self.host + ':' + self.port + '/remote' # For 4.6 - New
        self.baseurl = self.protocol + '://' + self.host + ':' + self.port + '/remote/scheduler.runSingleCommandAsTask.do' # For 4.5

        #Setup a handler to pass credentials for BASIC auth --- for 4.6
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
            print ('Response:\n' + resultStr)
        except HTTPError, e:
            err = 'The server ' + self.host + ':' + self.port + ' couldn\'t fulfill the request. '
            raise CommandInvokerError(err + str(e))
        except URLError, e:
            err = 'Failed to reach the server ' + self.host + ':' + self.port + '. Error/Reason: ' 
            raise CommandInvokerError(err + ' ' + str(e.reason))
        #reset the output type back to user's request
        self.output = output

    def invoke1(self, command, args):
        '''Attempt to remotely invoke the given command on the given ePO server
    
        Inputs:
            -strCmd is the command class name as it would be given to the
             ePO remote client. I.e. ComputerMgmt.AgentWakeup
            -dictParams is a dictionary of param:value pairs that the command will
             understand
    
        Return the response data as a string. 
        Otherwise raise RemoteEPOException with error text.
        '''     
        # url = "https://" + self. + ":8443/remote/scheduler.runSingleCommandAsTask.do"
        commandURI = "schedule:" + command + "?"
        for (k,v) in args.iteritems():
            commandURI += str(k) + "=" + str(v) + "&"
        
        commandURI = commandURI[:-1] #strip the trailing '&'
    
        compiledParams = {"taskName":command,
                          "taskDescription":"MA FVT Remote Task",
                          "waitForResults":True,
                          "commandURI":commandURI}
    
        # Create an OpenerDirector with support for Basic HTTP Authentication...
        auth_handler = urllib2.HTTPBasicAuthHandler()
        auth_handler.add_password("Orion remote command realm", self.baseurl, self.username, self.password)
        opener = urllib2.build_opener(auth_handler)
        # ...and install it globally so it can be used with urlopen.
        urllib2.install_opener(opener)
        
        data = urllib.urlencode(compiledParams)
        print self.baseurl
        print data
        try:
            result = urllib2.urlopen(self.baseurl, data)
        except Exception, inst:
            raise RemoteEPOCmdError("There was an error contacting the ePO server: " + \
                                str(inst))
        
        lines = result.read()
        
        if lines.lower().find("error:") != -1:
            raise RemoteEPOCmdError("ePO command " + strCmd + \
                                " returned an error: " + commandURI + ":" + lines)
        #strip off brackets
        print lines
        return lines[lines.find("[")+1 : lines.rfind("]")]


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
            print ('Response:\n' + resultStr)
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
        print ('Request: ' + url)
        if( len(args) == 0):
            return self.opener.open(url)
        else:
            body, content_type = _encode_multipart_formdata(args)
            data = 'Content-Type: ' + content_type + '\r\n'
            data += 'Content-Length: ' + str(len(body)) + '\r\n\r\n'
            data += body
            print ('postdata:\r\n' + data)
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


if __name__ == '__main__' :
    invoker = ePOCommandInvoker('172.16.193.75', 8443, 'admin', 'nai123')
    """ Old APIs - Works good but nothing returning.
    """
    bCollectAllProps = True
    bSuperAgent = False
    strNode = '172.16.193.79'
    params = {"param1" : str(bCollectAllProps), #full props
              "param2" : str(bSuperAgent),      #super agent
              "param3" : '0',                #randomize
              "param4" : strNode,          #csv comp names
              "param5" : '0',                #unique ID
              "param6" : '0',                #group ID
              "param7" : str(False),            #all children
              "param8" : "csv_comp_names"} 
    params['param4'] = 'SGUPTA6-EEPC-PC'
    r = invoker.invoke('system.wakeupAgent', params)

