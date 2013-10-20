'Common python script variables, functions, classes'

__author__ = "Val Shkolnikov <val.shkolnikov@orbitaldata.com>"
__version__ = "$Id: common.py,v 1.1 2005/04/06 22:18:55 jason Exp $"

import os, sys, re, time, signal, md5, base64, optparse, textwrap, logger
import struct
import pdb

s_t = pdb.set_trace
EOL = '\n'
EODL = '\r\n'
EOS = '\0'
TAB = '\t'

	# exception classes
class Error (Exception):
  'Base class for local exceptions'

  def __init__(self, msg=''):
    self.message = msg
    Exception.__init__(self, msg)

  def __repr__ (self):
    return str(self.message)
  __str__ = __repr__

class FatalError (Error):
  'Raised to bail out fast'

class AllTimeout (Error):
  'Raised on overall long wait'

class Timeout (Error):
  'Raised on long IO wait'

  def __init__ (self, who=None, msg=None):
    self.who = who
    if not msg: msg = 'timeout'
    else: msg += ' timeout'
    Error.__init__(self,msg)

	# option reading
class TW (textwrap.TextWrapper):

  def fill (self, text):
    return "\\\n".join(self.wrap(text))

def fill (text, width=70, **kwargs):
  w = TW(width=width, **kwargs)
  return w.fill(text)

optparse.STD_HELP_OPTION = optparse.Option("-?","-h","--help",
  action="help",help="show this help message and exit")

class IH (optparse.IndentedHelpFormatter):

  def format_string (self, str):
    str_width = self.width - self.current_indent
    indent = " "*self.current_indent
    return fill(str, str_width,initial_indent=indent,
     subsequent_indent=indent+"  ")

  def format_usage (self, usage):
    return self.format_string("Usage: python %s\n" % usage)

  def format_description (self, description):
    if description[0] == '=': return description[1:]	# no fill
    return '\n' + '\n\n'.join([
     optparse.IndentedHelpFormatter.format_description(self,
     paragraph) for paragraph in description.split('\n\n')])

  def format_heading (self, heading):
    return "\n%s\n%s\n" % (heading.capitalize(),
     "=-"[self.level] * len(heading))

  def format_option_strings (self, option):
    """Return a comma-separated list of option strings & metavariables."""
    if option.takes_value():
      metavar = option.metavar or option.dest.upper()
      short_opts = [sopt + " " + metavar for sopt in option._short_opts]
      long_opts = [lopt + " " + metavar for lopt in option._long_opts]
    else:
      short_opts = option._short_opts
      long_opts = option._long_opts

    if self.short_first:
      opts = short_opts + long_opts
    else:
      opts = long_opts + short_opts
    return ", ".join(opts)

class OP (optparse.OptionParser):

#  def __init__ (self, usage=None, option_list=None,
#   option_class=optparse.Option, version=None, conflict_handler="error",
#   description=None, formatter=IH(), add_help_option=1, prog=None):

  def __init__ (self, options, arguments=None, nargs=None, description=None):

    self.options,self.arguments,self.nargs = options,arguments,nargs
    optparse.OptionParser.__init__(self,usage=None,option_list=None,option_class=optparse.Option,
     version=None,conflict_handler="error",description=description,formatter=IH(),add_help_option=1,prog=None)

  def get_opts (self):
    "Get options from command string"
  
    def opttype (opt):
      if isinstance(opt,str):
        return 'string'
      elif isinstance(opt,int) and not isinstance(opt,bool):
        return 'int'
      
    def cmp (opt1,opt2):
      return ord(options[opt1]['sopt']) - ord(options[opt2]['sopt'])

    options,arguments,nargs = self.options,self.arguments,self.nargs
    usage = "%prog "
    parser = self
    for optname in options.keys():
      option = options[optname]
      try: sopt = option['sopt']	
  		# short option not specified, use first letter of option name
      except KeyError: options[optname]['sopt'] = optname[0]
    optnames = options.keys()
    optnames.sort(cmp)
    for optname in optnames:
      option = options[optname]
      default = option['default']
      try: sopt = option['sopt']	
  		# short option not specified, use first letter of option name
      except KeyError: sopt = optname[0]
      sopt = '-' + sopt
      try: lopt = option['lopt']
  		# long option not specified, use option name
      except KeyError: lopt = optname
      lopt = '--' + lopt
  		# option parameter name not specified, use option name
      try: dest = option['dest']
      except KeyError: dest = optname
      try: action = option['action']
  		# action not specified, use store
      except KeyError: action = 'store'
  
  		# show default unless explicitely prevented
      shd = ' [' + str(default) + '] '
      try:
        if not option['show']:
          shd = ''
      except KeyError:
        pass
  
      kws = { 'action':action,'default':default,
      'help':option['help'] + shd,}
      try: kws['metavar'] = option['metavar']
      except KeyError: pass
      tp = opttype(default)	# set type based on default
      if tp:
        kws['type'] = tp
        usage += '[' + sopt + ' ' + optname + ']'
      else:	# option without argument
        usage += '[' + sopt + ']'
      parser.add_option(sopt,lopt,**kws)
    if arguments: usage += ' ' + arguments
    parser.set_usage(usage)
  
    opts,args = parser.parse_args()
    if nargs == None:
      if args:
        parser.error("Unexpected arg(s)")
    else:
      if isinstance(nargs,int):
        if len(args) != nargs:
          if nargs == 1:
             parser.error("Need 1 arg")
          else:
            parser.error("Need %d args" % nargs)
      elif not eval(str(len(args)) + nargs):
          parser.error("Need number of args " + nargs)
    return opts,args
  
	# common functions
class Common:

  def __init__ (self):
    import socket, getpass
    hostname = socket.gethostname().split('.')[0]
    self.user = getpass.getuser()
    self.id = self.user + '@' + hostname + ' ' + sys.argv[0]

  def out_raw (self, msg):
    sys.stdout.write(msg)

  def fmt_out (self, msg):
    return self.id + ': '+ msg + EOL

  def out_msg (self, msg):
    self.out_raw(self.fmt_out(msg))

  def out_dated (self, msg):
    self.out_msg(msg + ' ' + time.ctime(time.time()))

  def err_raw (self, msg):
    sys.stderr.write(msg)

  def fmt_err (self, msg):
    return self.id + ' ERROR: '+ msg + EOL

  def err_msg (self, msg):
    self.err_raw(self.fmt_err(msg))

  def fatal_err (self, msg, status=1):
    self.err_msg(msg)
    sys.exit(status)

  def encode_cs (self, cs):
    return base64.encodestring(cs).strip()

  def file_cs (self, f):
    m = md5.new()
    f.seek(0)
    while True:
      buf = f.read()
      if not buf: break
      m.update(buf)
    f.seek(0)
    return self.encode_cs(m.digest())

  def file_size (self, f):
    return os.stat(f.name).st_size

  def empty_line (self, line):
    emptyline = re.compile(r'^\s*$|^\s*#.*$')
    return emptyline.match(line) or False

  def set_interrupt (self):
    def interrupt (signum, frame):
      raise KeyboardInterrupt
  
    signal.signal(signal.SIGTERM,interrupt)
    signal.signal(signal.SIGINT,interrupt)

  def set_alarm (self, timeout=0, caller=None, msg=''):
    def alarm (signo, frame):
      raise Timeout(caller,msg)
    signal.signal(signal.SIGTERM,alarm)
    signal.alarm(timeout)
   
  def start_trace (self, trace_excl=(), trace_incl=(), level=2, out=()):
    'Start call trace excluding certain callers'

    def trace (frame, event, arg):
      import traceback
  
      if (frame.f_back and ((not trace_incl and frame.f_back.f_code.co_name
       not in trace_excl) or (trace_incl and frame.f_code.co_name
       in trace_incl))):
        out_str = ''
        for item in traceback.extract_stack(frame,level):
          out_str += "%s,%s:%d|" % (item[0],item[2],item[1])
        out_str = out_str[:-1]
        if out:
          out[0](out_str,*out[1:])
        else:
          print out_str

    self.trace_excl,self.trace_incl,self.out = trace_excl,trace_incl,out
    sys.settrace(trace)

  def stop_trace (self):
    sys.settrace(None)

  def set_timeval (self, sec=0):
    if sec == 0:	# reset to zero
      return struct.pack('ll',0,0)
    isec = long(sec)
    iusec = long((sec * 10.**6) % 10.**6)
    s = struct.pack('ll',isec,iusec)
    isec,iusec = struct.unpack('ll',s)
    return struct.pack('ll',isec,iusec)
 
  def get_timeval (self, tv):
    isec,iusec = struct.unpack('ll',tv)
    if isec == 0 and iusec == 0:
      return 0
    return (isec * 10.**6 + iusec) / 10.**6

class UnresolvingLogger (logger.unresolving_logger):

  def time_stamp (self):
    return time.strftime('%Y%m%d.%H%M%S')

  def log (self, msg, announce=False):
    msg = ' '.join((self.time_stamp(),msg))
    self.logger.log(msg)
    if announce and self.logger.file != sys.stdout:
      sys.stdout.write(msg + EOL)
      sys.stdout.flush()

  def log_raw (self, msg):
    self.logger.write(msg)

  def log_bin (self, msg):
    "Log potentially binary data"

    if '\\x' in repr(msg[:100]):
      self.logger.log(self.time_stamp() + ' ' + repr(msg))
    else:
      self.logger.log(self.time_stamp() + ' ' +  msg)
