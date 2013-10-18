'Orbital box control via user interface'

__author__ = "Val Shkolnikov <val.shkolnikov@orbitaldata.com>"
__version__ = "$Id: ui_ctrl.py 6533 2005-03-09 01:29:06Z val $"

import os, sys, socket, time
import common
import re
import ui_http

VERSION = '0.1'
IDENT = 'Orbital box UI control (V%s)' % VERSION
cm = common.Common()

	# control options
OPT_CO = 'compression'
OPT_PA = 'parameters'
OPT_UP = 'update'
OPT_LE = 'level'
OPT_LI = 'license'
control_options = (OPT_CO,OPT_PA,OPT_UP,OPT_LE,OPT_LI)
level_options = ('server','level1','level2')

OPT_CO_CH = ui_http.OPT_CO_CH
ALLPORTS,ALLIPS = ui_http.ALLPORTS,ui_http.ALLIPS
port_ips_ex = re.compile(
 r'((\d{1,5},{0,1})|((\d{1,3}\.){3}\d{1,3}(/\d{1,2}){0,1},{0,1}))+$')

class OptionError (common.Error):
  "Option error detected"

  def __init__ (self, msg='', option=None):
    if not msg: msg = 'invalid'
    if option:
      msg = 'option -%s/--%s: ' % (options[option]['sopt'],option) + msg
    common.Error.__init__(self,msg)

FatalError = common.FatalError

class UiCtrl:
  "Control box with UI"

  def __init__ (self, address, logpref, loglevel):
    self.address = address
    if logpref == '-':
      logger_object=common.logger.file_logger(sys.stdout)
    else:
      logger_object=common.logger.file_logger(logpref + '.log')
    self.logger = common.UnresolvingLogger(logger_object)
    self.log_level = loglevel
    self.httpa = ui_http.HttpAccess(address,log=self.log,
      log_raw=self.logger.log_raw,ident=IDENT)

  def log (self, msg, level=1, bin=False):
    if not level or level <= self.log_level:
      if level: lev = ',%d'  % level
      else: lev = ''
      out = '%s%s: %s' % (self.address,lev,msg)
      if bin:
        self.logger.log_bin(out)
      else:
        self.logger.log(out)

  def log_error (self, msg):
    self.log('ERROR: ' + msg,0)

  def read_pars (self, opt, parfile):
    line_ct = 0
    pars = {}
    try:
      for line in file(parfile):
        line_ct += 1
        if not cm.empty_line(line):
          fields = [ field.strip() for field in line.strip().split(':') ]
          try:
            pars[fields[0]] = fields[1]
          except IndexError:
            raise FatalError('%s %d: invalid line' % (parfile,line_ct) +
                + common.EOL +  line)
    except IOError,msg:
      raise OptionError(str(msg),option=opt)
    if not pars:
      raise FatalError('%s: no parameters specified' % parfile) 
    return pars

  def proc_opt (self, opt_args):
    self.log('start',0)

    opt,args = opt_args
    if opt == OPT_CO:
      verb = args[0]
      if verb.lower()[0] in [val.lower()[0] for val in OPT_CO_CH]:
        try:
          port_ips = args.split('=')[1]
          if not ((port_ips.lower() in (ALLPORTS,ALLIPS)) or
           port_ips_ex.match(port_ips)):
            raise OptionError(option=opt)
          self.httpa.command(opt,verb,port_ips.lower().rstrip(','))
        except IndexError:
          self.httpa.command(opt,verb)
      else:
        raise OptionError(option=opt)

    elif opt in (OPT_PA,OPT_LI):
      pars = self.read_pars(opt,args)
      self.httpa.command(opt,pars)

    elif opt == OPT_UP:
      self.httpa.command(opt,args)

    elif opt == OPT_LE:
      level = args.split(',')
      try:
        level,reboot = level
      except ValueError:
        level = level[0]
        reboot = ''
      reboot = (reboot == 'r') or  (len(reboot) > 1 and reboot[0] == 'r')
      if level not in level_options:
        raise FatalError("invalid level '%s', must be one of: %s" % (level,
         ', '.join(level_options))) 
      self.httpa.command(opt,level,reboot)

    self.log('end',0)

if __name__ == '__main__':

# set up options

  options = {
      'logpref':{'sopt':'g','default':'-',
       'help':"log file name prefix, '-' means stdout",},
      'loglevel':{'default':1,'help':"logging level, 0 - no log, \
1,2,... - log with increasing detail",},
      OPT_CO:{'default':'','sopt':OPT_CO[0].upper(),
       'help':"enable/disable compression globally, or on specified ports \
or IPs",'metavar':"""\\
e|d|e=allports|e=allips|e=port,...|d=port,...|e=ip,...|d=ip,...
""",
'show':False,},
      OPT_PA:{'default':'','sopt':OPT_PA[0].upper(),
       'help':"set parameters from file of names and values",
       'metavar':'parfile','show':False,},
      OPT_UP:{'default':'','sopt':OPT_UP[0].upper(),
       'help':"upload patch file of given name",'metavar':'name','show':False,},
      OPT_LE:{'default':'','sopt':OPT_LE[0].upper(),'help':
       "set up execution level rebooting afterwards if indicated by ,r \
after level number",'metavar':'level_no[,r]','show':False,},
      OPT_LI:{'default':'','sopt':OPT_LI[1].upper(),
       'help':"update software license",'metavar':'licparfile','show':False,},
  }
 
  arguments = 'box_address[:port]'
  description = """\
Control orbital software thru HTTP user interface.  Server address and TCP
port are specified in the argument where address is a host name or IP address.
Default HTTP port is 80.  Only one of the control options """ + \
', '.join(control_options) + \
""" is allowed.
"""
  op = common.OP(options,arguments,1,description)
  opts,args = op.get_opts()
  ctrl_opt = [ (opt,val) for opt,val in opts.__dict__.items()
   if opt in control_options and val ]

  try:
    if not len(ctrl_opt):
      raise OptionError('No control options specified')
    if len(ctrl_opt) != 1:
      raise OptionError('Exactly one control option is allowed')

    ui = UiCtrl(args[0],opts.logpref,opts.loglevel)
    ui.proc_opt(ctrl_opt[0])
  except OptionError,msg:
    op.print_usage()
    cm.fatal_err(str(msg))
  except FatalError,msg:
    ui.log_error(str(msg))
    sys.exit(2)
  except KeyboardInterrupt:
    cm.fatal_err('interrupted')
