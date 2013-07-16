import urllib2
import urllib
import mimetools, mimetypes

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


class ePOInvokerFactory :
    """Handles processing of a remote command request.
    This class is only intended for use inside this script (private)
    """
    
    def getInvokerInstance(cls, epoVersion) :
        if ePOInvokerFactory._invoker is not None:
            return ePOInvokerFactory._invoker

        if epoVersion > 4.5 :
            ePOInvokerFactory._invoker = ePOInvoker46()
        else :
            ePOInvokerFactory._invoker = ePOInvoker45()

        return ePOInvokerFactory._invoker

class ePOInvoker45 :
    def __init__(self, host, port, username, password) :
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
        self.protocol = 'https'
        # self.baseurl = protocol + '://' + self.host + ':' + self.port + '/remote' # For 4.6 - New
        self.baseurl = self.protocol + '://' + self.host + ':' + self.port + '/remote/scheduler.runSingleCommandAsTask.do' # For 4.5

    def invoke(self, command, args):
        '''Attempt to remotely invoke the given command on the given ePO server
    
        Inputs:
            -strCmd is the command class name as it would be given to the
             ePO remote client. I.e. ComputerMgmt.AgentWakeup
            -dictParams is a dictionary of param:value pairs that the command will
             understand
    
        Return the response data as a string. 
        Otherwise raise RemoteEPOException with error text.
        '''     
        argscopy = args
        #Extract the file upload arguments, put them in data
        fileargs = {}
        deletekeys = []
        for key in argscopy:
            if argscopy[key][:8] == 'file:///':
                filename = argscopy[key][8:]
                print filename
                content = self.get_file_contents(filename)
                fileargs[key] = (filename, content)
                deletekeys.append(key)
        for key in deletekeys:
            del argscopy[key]

        commandURI = self.build_url_request(command, argscopy)

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
            raise RemoteEPOCmdError("ePO command " + command+ \
                                " returned an error: " + commandURI + ":" + lines)
        #strip off brackets
        print lines
        return lines[lines.find("[")+1 : lines.rfind("]")]
    
    def build_url_request(self, command, args):
        """Helper function to construct the url that will be requested from the server
        
        @param command - the command name (i.e., prefix.commandName)
        @param args - dictionary of the arguments to pass (i.e., {"arg":"value"})
        @returns the url to fetch (i.e, http://servername:8080/remote/prefix.commandName.do?arg=value)
        """
        queryString = "&".join(["%s=%s" % (quote(str(k)), quote(v)) for k, v in args.items()])
        url = 'schedule:' + command
        url += '?' + queryString
        return url


    def get_file_contents(self, filename):
        readmode = 'r'  #assume text file
        # find out type of file
        type = mimetypes.guess_type(filename)[0] or 'application/octet-stream'
        if(type[:3] != 'text'):
            readmode = 'rb'  #binary file
        f = open(filename, readmode)
        content = f.read()
        f.close()
        return content



