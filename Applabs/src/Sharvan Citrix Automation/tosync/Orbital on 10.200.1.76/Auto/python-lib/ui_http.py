'Orbital box control via user interface, http portion'

__author__ = "Val Shkolnikov <val.shkolnikov@orbitaldata.com>"
__version__ = "$Id: ui_http.py,v 1.1 2005/04/06 22:18:55 jason Exp $"

from httpown import *
import time, re, urlparse, urllib, signal, copy
import ui_html

	# option/field constants
ALLPORTS,ALLIPS,SOME = 'allports','allips','some'
ENABLE,DISABLE,FORM_NAME = 'Enable','Disable','FormName'

OPT_CO_CH = ENABLE,DISABLE
GLOBAL_CTRL_INPUTS = {
  'EnableCompression':ENABLE,'DisableCompression':DISABLE,
}

PORT_LIST_NAME,PORT_STATE_NAME = ('AccelPorts','AccelState',)
PORT_CTRL_INPUTS = { FORM_NAME:'form_name',PORT_LIST_NAME:'port_list',
 PORT_STATE_NAME:'port_state', }
PORT_STATES = { ALLPORTS+ENABLE:'0',SOME+ENABLE:'1',SOME+DISABLE:'2'}

IP_ADD_NAME,IP_LIST_NAME,IP_STATE_NAME = ('NewIPMask','AccelIPs',
 'CompressionAccelIPsMode')
ADD,DELETE,CHANGE_MODE,CHANGE_MODE_VALUE = ('Add','Delete','ChangeMode',
 'Change Mode')
IP_CTRL_INPUTS = { FORM_NAME:'form_name',IP_LIST_NAME:'ip_list',
 IP_STATE_NAME:'ip_state', }
IP_CTRL_INPUTS_MIN = { FORM_NAME:'form_name',IP_STATE_NAME:'ip_state', }
IP_STATES = { ALLIPS+ENABLE:'1',SOME+ENABLE:'2',SOME+DISABLE:'3'}
USERFILE='userFile'
BLOCKSIZE = 10 * 512

maint_user_pwd = ('Admin','snobgras')
lic_user_pwd = ('val','val')
Lic_gen_page = 'http://zoo.orbitaldata.com:80/license/'

class HttpError (common.Error):

  def __init__(self, msg='', page_no=None):
    pn = ''
    if page_no != None:
      pn = 'page %s: ' % str(page_no)
    self.message = pn + str(msg)
    Exception.__init__(self, self.message)

class ConnError (HttpError):
  'Raised on bad connection to server'

  def __repr__ (self):
    return 'connection error, ' + self.message
  __str__ = __repr__

class StatusError (HttpError):
  'Raised on bad status from server'

  def __init__(self, errcode, errmsg, page_no=None):
    HttpError.__init__(self,'%d, %s' % (errcode,errmsg),page_no)

  def __repr__ (self):
    return 'bad server status, ' + self.message
  __str__ = __repr__

class PageError (HttpError):
  'Raised on bad page content'

  def __repr__ (self):
    return 'bad page, ' + self.message
  __str__ = __repr__

submitF = "submit"
cancelF = "cancel"
actionF = "action"
methodF = "method"

io_timeout = 300			# I/O timeout in sec
group_size = 30				# ticker group size
EOL = common.EOL
REC_SEP = EOL

HTTP_SCHEME = "http"
HTTPS_SCHEME = "https"

pages = {
  'compression':'compression_configuration.php',
  'parameters':'parameters.php',
  'restart':'restart.php',
  'update':'patch.php',
  'level':'patch.php',
  'license':'license.php',
}

AllTimeout = common.AllTimeout

class HttpAccess:

  def __init__ (self, address, user_pwd=None, log=None, log_raw=None,
   use_ssl=False,ident='unknown'):
    try:
      host,port = address.split(':')
    except ValueError:
      host = address
      port = '80'
    try:
      port = int(port)
    except ValueError:
      raise common.FatalError('invalid port in address ' + address)
    self.address = address
    self.host,self.port = host,port
    if user_pwd:
      user,pwd = user_pwd
    else:
      user,pwd = maint_user_pwd
    self.user_pwd = common.Common().encode_cs(user + ':' + pwd)
    if log:
      self.log = log
    self.log_raw = log_raw
    if not log_raw:
      self.log_raw = log
    
    self.use_ssl = use_ssl
    self.scheme = HTTP_SCHEME
    if use_ssl:
      self.scheme = HTTPS_SCHEME
    self.ident = ident

    self.htmp = ui_html.HtmlParser()	# most pages are parsed so
        		# define error status detection
    ok_pat = "^..STATUS..OK"
    error_pat = "^..STATUS..ERROR"
    reason_pat = "^^^"	# something invalid
    self.ok_status_ex = re.compile(ok_pat)
    self.error_status_ex = re.compile(error_pat)
    self.reason_ex = re.compile(reason_pat)
#    self.cookie_id = re.compile('^'+cm.inputs["cookie_id"])
    self.form_method = ""		# default method GET

  def log (self, str, *other):
    sys.stdout.write('ORBHTTP ' + str)
    sys.stdout.flush()

  def start_server (self):	# start talking to server
    try: self.conn.close()
    except AttributeError: pass
    port = ""
    if self.port: port = ':' + `self.port`
    self.log("server " + self.host + port + EOL,2)
    try:
      httpo = HttpOwn(host=self.host,port=self.port,use_ssl=self.use_ssl,
       log=self.log)
    except (IOError,socket.error,socket.sslerror,AllTimeout),msg:
      raise ConnError(' '.join(('server',self.host + port,str(msg))))
    return httpo

  def review_page (self, page_no, pagetext, form_ct, fail,
      expect_ok):
    self.htmp.clear_serv()
    self.htmp.form_ct = form_ct
    self.htmp.fail = fail
    self.htmp.expect_ok = expect_ok
    self.htmp.ok_status_ex = self.ok_status_ex
    self.htmp.error_status_ex = self.error_status_ex
    self.htmp.reason_ex = self.reason_ex
    if not len(pagetext): raise PageError("empty page")

    self.htmp.feed(''.join(pagetext))	# parse the page
    self.htmp.close()

    if self.htmp.data and not re.match(r'\s*$',self.htmp.data):
      raise PageError(self.htmp.data,page_no)
    if self.htmp.status: raise PageError("status",page_no)
    self.form_method = self.htmp.form_method
    return self.htmp.form_action,self.htmp.text

  def format_query (self, add):
#		if not add.has_key(submitF):
#			add[submitF] = ""
    self.htmp.inputs.update(add)
    return urllib.urlencode(self.htmp.inputs)

  def unformat_query (self, query):
    return urllib.unquote_plus(query)

    unform = {}
    query = query.split('&')
    for key_value in query:
      k_v = key_value.split('=')
      unform[k_v[0]] = k_v[1]
    return unform

  def url2addr_req (self, url, page_no=None):
    url_parsed = urlparse.urlparse(url)
    self.scheme = url_parsed[0]
    try:
      self.port = self.port
    except AttributeError:
      self.port = None
    if url_parsed[1]:
      addr_port = url_parsed[1].split(':')
      addr = addr_port[0]
      self.address = addr
      if len(addr_port) > 1:
        try: self.port = int(addr_port[1])
        except ValueError:
          raise PageError("non-numeric port",page_no)
    request = ""
    if url_parsed[2]: request = url_parsed[2]
    self.request = urlparse.urlunparse(("","") + (request,) +
       (url_parsed[3:]))

  def format_multipart (self, content, httpo):
    'Format multipart post request'
    return httpo.encode_multipart_formdata(content['fields'].items(),
     content['files'].items(),httpo.make_boundary())

  def request_reply (self, page_no, req_query=None, post_multipart=None,
      form_ct=0, fail=0, expect_ok=0, iot=None):
    if not iot: iot = io_timeout
    self.start_time = time.time()
    try:
      httpo = self.start_server()	# connect to server
      text = ""
      http = httpo.http
      pagetext = None
      query = ''
      if req_query:
         query = self.format_query(req_query)

      if self.form_method == "post":	# POST request
        if post_multipart:	# post multipart
          content_type,content_length,body = self.format_multipart(
           post_multipart,httpo)
          http.putrequest("POST",self.request)
          http.putheader("User-Agent",self.ident)
          http.putheader("Content-type",content_type)
          http.putheader("Accept","text/html")
          try:
            http.putheader("Cookie",self.cookie)
          except AttributeError:
            pass
          http.putheader("Content-length",str(content_length))
          http.putheader("Authorization",'Basic ' + self.user_pwd)
          http.endheaders()
          for entry in body:
            if type(entry) == type('string'):
              http.send(entry)
            else:
              f = file(entry[0])
              while 1:
                c = f.read(BLOCKSIZE)
                if not c: break
                http.send(c)
              f.close()
        else: 		# post urlencoded
          http.putrequest("POST",self.request)
          http.putheader("User-Agent",self.ident)
          http.putheader("Content-type","application/x-www-form-urlencoded")
          http.putheader("Accept","text/html")
          try:
            http.putheader("Cookie",self.cookie)
          except AttributeError:
            pass
          http.putheader("Content-length", str(len(query)))
          http.putheader("Authorization",'Basic ' + self.user_pwd)
          http.endheaders()
          http.send(query)

      else:		# GET request
        if query:
          if self.request.find('?') < 0:
          	query = '?' + query
          else:
          	query = '&' + query
        http.putrequest("GET", self.request + query)
        http.putheader("User-Agent",self.ident)
        http.putheader("Accept","text/html")
        try:
          http.putheader("Cookie",self.cookie)
        except AttributeError:
          pass
        http.putheader("Authorization", 'Basic ' + self.user_pwd)
        http.endheaders()
        	# reply
      errcode, errmsg, headers = http.getreply()
    except (IOError,socket.error,socket.sslerror,AllTimeout),msg:
        raise ConnError(msg,page_no)
    else:
      if errcode not in (200,302):
        raise StatusError(errcode,errmsg,page_no)
      else:			# read file
        file_page = http.getfile()
        try:
          self.pagetext = pagetext = file_page.readlines()
          self.log(''.join(['page text:'] + pagetext) + "\n\n",4)
          maintype = headers.getmaintype()
          if not (maintype == "text" or expect_ok or
           (maintype == "application" and
           headers.getsubtype() == "x-wn-egcy")):
        	raise ValueError,"unexpected type " + headers.gettype()
        except (IOError,EOFError,ValueError,socket.error,AllTimeout),msg:
          raise PageError(msg,page_no)
        try:		# disconnect from server
          file_page.close()
        except (EOFError, ValueError, socket.error):
          pass
        cookie_set = headers.getheader("Set-Cookie")
        if cookie_set:
          self.cookie = cookie_set.split(';')[0]
#       if self.cookie_id.match(text):
#          self.cookie = text
        if (errcode == 302):
          form_action = headers.getheader("Location")
        else:
          form_action,text =\
           self.review_page(page_no,pagetext,form_ct,fail,expect_ok)

        # form action -> addr/request 
        url_cur = urlparse.urlunparse((self.scheme,self.address) +
         urlparse.urlparse(self.request)[2:])
        self.url2addr_req(urlparse.urljoin(url_cur,form_action),page_no)
        if (errcode == 302):
          return self.request_reply(page_no,req_query=req_query,
           form_ct=form_ct,fail=fail,expect_ok=expect_ok)
    self.log(self.cmd + " page %s %s" % (page_no, text) + EOL)
    return pagetext

  def compression (self, page, args):

    verb = args[0]
    v = verb[0].lower()

    def check_global (query=None):
      self.request_reply(self.page_no,form_ct=1,req_query=query)
      self.inputs = self.htmp.inputs
      input_value = [value.lower()[0] for value in self.inputs.values()]
      if len(input_value) != 1:
        raise AttributeError('one value expected')
      input_value = input_value[0]
      if input_value in [value.lower()[0] for value in OPT_CO_CH]:
        return v == input_value	# True means need to change value
      else:
        raise AttributeError('illegal value')
    
    def select_inputs (input_dict):
      'Select important input fields'

      self.inputs = {}
      input_dict_keys = input_dict.keys()
      for input_name in self.htmp.inputs.keys():
        if input_name in input_dict_keys:
          self.inputs[input_name] = self.htmp.inputs[input_name]
          input_dict_keys.remove(input_name)
      if input_dict_keys:
#        raise PageError('missing inputs % '%(`input_dict_keys`,),
        raise PageError('missing inputs '+`input_dict_keys`,self.page_no)
      self.htmp.inputs = self.inputs

    def check_ports (query=None):
        # convert verb, ports to state
      state = ALLPORTS
      if port_ips != ALLPORTS: state = SOME
      key_len = len(state) + 1
      state_name = (state + verb).lower()[:key_len] # all[e|d] some[e|d]
      try:
        state = [ value for key,value in
         PORT_STATES.items() if key[:key_len].lower() == state_name ][0]
      except IndexError:
        raise AttributeError('setting not defined')
      self.request_reply(self.page_no,form_ct=2,req_query=query)
      select_inputs(PORT_CTRL_INPUTS)
		# verify if change required
      if ((state != self.inputs[PORT_STATE_NAME]) or
       (port_ips != ALLPORTS and port_ips != self.inputs[PORT_LIST_NAME])):
        return state	# need to change value

    def check_ips (query=False):
        # convert verb, ips to state
      state = ALLIPS
      if port_ips != ALLIPS: state = SOME
      key_len = len(state) + 1
      state_name = (state + verb).lower()[:key_len] # all[e|d] some[e|d]
      try:
        state = [ value for key,value in
         IP_STATES.items() if key[:key_len].lower() == state_name ][0]
      except IndexError:
        raise AttributeError('setting not defined')
      self.request_reply(self.page_no,form_ct=3)
      select_inputs(IP_CTRL_INPUTS)
      need_ips = [ ip.strip() for ip in port_ips.split(',') ]
      set_ips = self.inputs[IP_LIST_NAME]

      if query:
		# delete unneeded IPs
        for set_ip in set_ips:
          if port_ips == ALLIPS or set_ip not in need_ips:
            self.page_no += 1
            self.request_reply(self.page_no,form_ct=3,req_query={
             IP_LIST_NAME:set_ip,DELETE:DELETE})
          select_inputs(IP_CTRL_INPUTS_MIN)
            
		# add needed IPs
        if port_ips != ALLIPS:
          for need_ip in need_ips:
            if need_ip not in set_ips:
              self.page_no += 1
              self.request_reply(self.page_no,form_ct=3,req_query={
               IP_ADD_NAME:need_ip,ADD:ADD})
              select_inputs(IP_CTRL_INPUTS_MIN)
        # set state
        self.page_no += 1
        self.request_reply(self.page_no,form_ct=3,req_query={
         IP_STATE_NAME:state,CHANGE_MODE:CHANGE_MODE_VALUE})
        select_inputs(IP_CTRL_INPUTS)

		# verify if change required
      need_ips.sort()
      self.inputs[IP_LIST_NAME].sort()
      if ((state != self.inputs[IP_STATE_NAME]) or
       (port_ips != ALLIPS and need_ips != self.inputs[IP_LIST_NAME])):
        return state 	# need to change value

    try:
      self.request = page
      self.page_no = 1

      try:
        port_ips = args[1]
      except IndexError:
      						# global enable/disable
        check = check_global
        ret = check()
        query = [ { name:value } for  name,value in GLOBAL_CTRL_INPUTS.items()
         if value.lower()[0] == v ][0]
      else:
        ports = ips = ''
        if port_ips.find('.') == -1 and port_ips != ALLIPS:
          check = check_ports	# no dots, port enbale/disable
          ret = state = check()
          query = { PORT_LIST_NAME:port_ips,PORT_STATE_NAME:state }
        else:					# ip enable/disable
          check = check_ips
          ret = check()
          query = True
      self.page_no += 1
      if ret and check(query):
        raise AttributeError('could not set value ' + `query`)
    except AttributeError,msg:
      raise PageError('Unexpected inputs, %s, %s' % (str(msg),`self.inputs`),
        self.page_no)
     
  def parameters (self, page, args):
    self.request = page
    pars, = args

    page_no = 1
    pars_copy = copy.copy(pars)
		# read and prepare to set parameters
    self.htmp = ui_html.ParParser(pars_copy,True)
    self.request_reply(page_no)	# get par names
    if pars_copy:
      raise PageError('parameter(s) not found in page: ' +
        ', '.join(pars_copy.keys()),page_no)
		# set and verify parameter values
    page_no = 2
    pars_copy = copy.copy(pars)
    req_query = self.htmp.inputs
    self.htmp = ui_html.ParParser(pars_copy)
    try:
      self.request_reply(page_no,req_query)
    except AttributeError,msg:
      raise PageError(str(msg),page_no)

  def _wait_reboot (self, page, page_no, *args, **kws):
    self.request = page
    max_atts = 12
    time.sleep(60)
    for att in range(max_atts):
      self.log_raw('.')
      try:
        self.request_reply(page_no,*args,**kws)
        break
      except (PageError,StatusError,ConnError),msg:
        if att == max_atts-1: raise
        time.sleep(20)

  def update (self, page, args):
    self.request = page
    patch, = args
    page_no = 1
    self.request_reply(page_no,form_ct=1)

    page_no = 2
    del self.htmp.inputs[USERFILE]
    post_multipart = {'fields':self.htmp.inputs,'files':{USERFILE:patch}}
    self.request_reply(page_no,form_ct=3,post_multipart=post_multipart)
		# upload image
    self._wait_reboot(page,3,form_ct=1)

  def level (self, page, args) :
    self.request = page
    level,reboot = args
    page_no = 1
		# change level
    self.request_reply(page_no,form_ct=3)
    page_no = 2
    self.request_reply(page_no,form_ct=3,req_query={'Type':level})
    self.request = '/' + self.htmp.content[1]
		# get reboot page
    page_no = 3
    self.htmp = ui_html.YesNoParser()
    self.request_reply(page_no,req_query={})
    if reboot:
		# confirm reboot
      page_no = 4
      self.request += self.htmp.yes_href
      self.request_reply(page_no,req_query={})

      self._wait_reboot(page,5,form_ct=3)

  def _actuals2names (self, actuals, rename):
    names = [] 
    for actual in actuals:
      try: names.append(rename[actual])
      except KeyError: names.append(actual)
    return names

  def _names2actuals (self, names, rename):
    actuals = []
    for name in names:
      renamed = False
      for key in rename.keys():
        if rename[key] == name:
          actuals.append(key)
          renamed = True
      if not renamed:
        actuals.append(name)
    return actuals
      
  def license (self, page, args):
    self.request = page
    lic_pars, = args
    try: lic_pars['SerialNumber']
    except KeyError: lic_pars['SerialNumber'] =\
     'Python' + time.strftime('%y%m%d')
		# find MAC address
    page_no = 1
    self.htmp = ui_html.LicParser()
    self.request_reply(page_no)
    try:
      mac = self.htmp.mac
    except AttributeError:
      raise PageError("Can't find MAC")
    self.log("mac %s "%mac +  EOL,2)
		# read and prepare to set license generator inputs
    page_no = 2
    address = urlparse.urlparse(Lic_gen_page)[1]
    lic_httpa = HttpAccessLic(address,log=self.log,
     user_pwd=lic_user_pwd,log_raw=self.log_raw,ident=self.ident)
    lic_httpa.cmd = self.cmd
    lic_httpa.request = Lic_gen_page

    lic_pars_copy = copy.copy(lic_pars)
    lic_httpa.htmp = ui_html.LicGenParser(mac,lic_pars_copy)
    lic_httpa.request_reply(page_no,form_ct=1)
    if lic_pars_copy:
      raise PageError('parameter(s) not found in page: ' +
       ', '.join(lic_pars_copy.keys()),page_no)
		# submit license generator input
    page_no = 3
    req_query = lic_httpa.htmp.inputs
    lic_httpa.request_reply(page_no,form_ct=1,req_query=req_query)
		# download license
    page_no = 4
    lic_httpa.request += lic_httpa.htmp.href
    lic_httpa.request_reply(page_no)
		# upload license
    licensetext = ''.join(lic_httpa.pagetext)
    page_no = 5
    self.request_reply(page_no,form_ct=1,req_query={
     'limits_primary':licensetext})

  def command (self, cmd, *args):		# execute control command
    try:
      self.oper = getattr(self,cmd)
      page = '/' + pages[cmd]
    except AttributeError:
      raise common.FatalError("invalid command: " + "%s" % cmd)
    self.cmd = cmd
    try:
        self.oper(page,args)
    except (PageError,StatusError,ConnError),msg:
      raise common.FatalError(msg)
 
class HttpAccessLic (HttpAccess):

  def format_query (self, add):
    'Provide for ordered submision of repetitive limit inputs'

    self.htmp.inputs.update(add)	# standard inputs
    inputs_items = self.htmp.inputs.items()
    for limit in self.htmp.limits:	# limit inputs
      for item in limit:
        inputs_items.append(item)
    return urllib.urlencode(inputs_items)

if __name__ == '__main__': # self test
  host = '10.200.9.3'
  HttpAccess(host).command('compression','enable')
  HttpAccess(host).command('compression','disable')
