'Orbital box control via user interface, html portion'

__author__ = "Val Shkolnikov <val.shkolnikov@orbitaldata.com>"
__version__ = "$Id: ui_html.py 6533 2005-03-09 01:29:06Z val $"

from htmllib import HTMLParser
from formatter import NullFormatter
import re, htmlentitydefs, copy, common

s_t = common.s_t
actionF = "action"
methodF = "method"

FIELD_SEP = ','
REC_SEP = common.EOL

class HtmlParser (HTMLParser):
  'Parse HTML page'

  def __init__ (self):
    HTMLParser.__init__(self,NullFormatter())
    self.clear_serv()

  def clear_serv (self):
    self.inputs = {}
    self.html = self.data =\
      self.form_action = self.form_method =\
      self.content = self.status = self.text = ''

  def start_html (self, attrs):
    self.html = 1
    self.state = 0
    self.form = 0

  def start_title (self, attrs):
    self.title = 1

  def end_title (self):
    try: del self.title
    except AttributeError: pass

  def handle_entityref (self, name):
    table = self.entitydefs
    if table.has_key(name):
      self.handle_data(table[name])
    else:
      self.handle_data('&' + name)

  def do_meta (self, attrs):
    content = re.compile("([0-9]+);.*url=(.*)",re.I)
    meta = {}
    for attrname, attrvalue in attrs:
      meta[attrname] = attrvalue
    try:
      if meta["http-equiv"].lower() == "refresh":
        content_match = content.match(meta["content"])
        if content_match:
          self.content = (content_match.group(1),content_match.group(2))
    except KeyError:
      pass

  def do_form (self, attrs):
    self.form += 1
    if self.form_ct and self.form_ct != self.form: return
    for attrname, attrvalue in attrs:
      if attrname == actionF: self.form_action = attrvalue
      elif attrname == methodF: self.form_method = attrvalue.lower()
    try:
      self.text = self.heading_text
      del self.heading_text
    except AttributeError: pass

  def do_input (self, attrs, proc_name=None):
    name = value = input_type = checked = ''
    if self.form_ct and self.form_ct != self.form: return ()
    for attrname, attrvalue in attrs:
      if attrname == "type": input_type = attrvalue.lower()
      elif attrname == "checked": checked = True
      elif attrname == "name": name = attrvalue
      elif attrname == "value": value = attrvalue
    if input_type == 'radio':
      if checked: self.inputs[name] = value
    elif name:
      if proc_name: proc_name(name,value)
      else: self.inputs[name] = value
    return name,value

  def start_select (self, attrs):
    try:
      self.sel_name,value = self.do_input(attrs)
    except ValueError: pass
    self.sel_opts = []

  def end_select (self):
    value = ''
		# value is first select option if any
    try: value = self.sel_opts[0][1]
    except IndexError: pass
		# value is selected select option, if any
    try: value = self.opt_sel_name_value[1]
    except AttributeError: pass
		# name, value as select name and option value
    try: self.inputs[self.sel_name] = value
    except AttributeError: pass

    for attr in ('sel_name','opt_sel_name_value'):
      try: delattr(self,attr)
      except AttributeError: pass

  def start_option (self, attrs):
    self.opt_name = ''
    for attrname,attrvalue in attrs:
      if attrname == 'value': self.opt_value = attrvalue
      elif attrname == 'selected': self.opt_sel = 1

  def end_option (self):
    try:
      self.sel_opts.append((self.opt_name,self.opt_value))
      if self.opt_sel: self.opt_sel_name_value = (self.opt_name,self.opt_value)
    except AttributeError: pass
    for attr in ('option','opt_name','opt_sel'):
      try: delattr(self,attr)
      except AttributeError: pass

  def start_textarea (self, attrs):
    try:
      self.textarea_name,value = HtmlParser.do_input(self,attrs)
      self.textarea = ''
    except ValueError: pass

  def end_textarea (self):
     try:
       self.inputs[self.textarea_name] = self.textarea
       del self.textarea
     except AttributeError: pass

  def start_font (self, attrs):
    color = size = ''
    for attrname, attrvalue in attrs:
      if attrname == 'class' and attrvalue == 'pageheading':
        self.heading_text = ''
      elif attrname == 'color': color = attrvalue
      elif attrname == 'size': size = attrvalue
    self.errmsg = (color == 'red' and size == '+2')
    self.okmsg = (color == 'red' and size == '+2')

  def end_font (self):
    for attr in ('okmsg','errmsg','heading_text'):
      try: delattr(self,attr)
      except AttributeError: pass

  def handle_data (self, data):
    if self.html:
      try: self.heading_text += data
      except AttributeError: pass
      try: self.opt_name += data.strip()
      except AttributeError: pass
      try:
        if self.title: self.text = data
      except AttributeError: pass
      try:
        self.textarea += data
      except AttributeError: pass
      try:	# OK message
        if self.okmsg:
          self.text += ' ' + data
      except AttributeError: pass
      try:	# error message
        if self.errmsg:
          self.data += data
      except AttributeError: pass

class ParParser (HtmlParser):
  'Parameter page parser'

  def __init__ (self, pars, set=False):
    'pars is a map of parameter names/values'

    self.pars = pars
    self.set = set		# True: prepare to set pars, False: verify set pars
    self.par_name = ''
    self.par_start = False
    HtmlParser.__init__(self)

  def do_tr (self, attr):
    self.state = 'tr'	# row started

  def start_td (self, attrs):
    if self.html and self.state == 'tr':
      self.par_name = ''
      self.par_start = True

  def end_td (self):
    self.par_start = False
    self.state = 0

  def do_input (self, attrs):
    par_attr_ex = re.compile(r'\d+')
    name = value = ''
    self.par_name = self.par_name.strip()
    for attrname, attrvalue in attrs:
      if attrname == 'name': name = attrvalue
      elif attrname == 'value': value = attrvalue
    if par_attr_ex.match(name) and self.par_name in self.pars.keys():
      if self.set: self.inputs[name] = self.pars[self.par_name] # set value
      elif value != self.pars[self.par_name]:	# check value
        raise AttributeError('parameter %s=%s, expect %s' % (self.par_name,
          value,self.pars[self.par_name]))
      del self.pars[self.par_name]
    return name,value

  def handle_data (self, data):
    if self.par_start: self.par_name += data	# record parameter name
    HtmlParser.handle_data(self,data)

class YesNoParser (HtmlParser):

  def anchor_bgn (self, href, name, type):
    if href.find('MsgBoxResponse=1') != -1:
      self.yes_href = href

class LicParser (HtmlParser):

  def start_div (self, attrs):
    for attrname,attrvalue in attrs:
      if attrname == 'class' and attrvalue == 'settings_table':
        self.settings = True

  def end_div (self):
    try: del self.settings
    except AttributeError: pass

  def start_th (self, attrs):
    self.th = True

  def end_th (self):
    try: self.th = ''
    except AttributeError: pass

  def handle_data (self, data):
    mac_title = re.compile(r'\s*eth0\s+mac:\s*',re.IGNORECASE)
    mac_pattern = re.compile(
     r'\s*((?:[\da-fA-F][\da-fA-F][-:]){5}[\da-fA-F][\da-fA-F])\s*')
    HtmlParser.handle_data(self,data)
    try:	# MAC address
      if self.settings and self.th and mac_title.match(data):
        self.mac_title = True
      elif self.mac_title and mac_pattern.match(data):
        self.mac = mac_pattern.match(data).group(1)
        del self.mac_title
    except AttributeError: pass

class LicGenParser (HtmlParser):

  def __init__ (self, mac, lic_pars):
    HtmlParser.__init__(self)
    self.lic_pars = lic_pars
    self.lic_pars['EtherAddresses'] = '{ '+mac+' }'
    self.limits = []
    self.rename = {}
		# pretend this is given as the first <strong>hdr</strong>
    self.strong_hdr = 'Company'

  def start_td (self, attrs):
    for attrname,attrvalue in attrs:
      if attrname == 'class' and attrvalue == 'limitEntry':
        self.limitEntry = 1	# found parameter row

  def end_td (self):
    try: del self.limitEntry
    except AttributeError: pass

  def start_select (self, attrs):
    try:
      self.sel_name,value = HtmlParser.do_input(self,attrs)
    except ValueError: pass
    self.sel_opts = []
    try: self.rename[self.sel_name] = self.strong_hdr.strip().strip(':')
    except AttributeError: pass
    try: del self.strong_hdr
    except AttributeError: pass

  def end_select (self):
    try: sel_name = sel_name_external = self.sel_name
    except AttrubuteError: return
    try: sel_name_external = self.rename[sel_name_external]
    except KeyError: pass
    try: sel_value = self.lic_pars[sel_name_external]
    except KeyError:
      HtmlParser.end_select(self)
      return
    try:
      for opt_name,opt_value in self.sel_opts:
		# replace option name (displayed text) with option value (tag attribute)
        if opt_name == sel_value: sel_value = opt_value
    except AttributeError: pass
    self.inputs[sel_name] = sel_value
    del self.lic_pars[sel_name_external]

  def start_textarea (self, attrs):
    HtmlParser.start_textarea(self,attrs)
    try: self.rename[self.textarea_name] = self.strong_hdr.strip().strip(':')
    except AttributeError: pass
    try: del self.strong_hdr
    except AttributeError: pass

  def end_textarea (self):
    try: textarea_name = textarea_name_external = self.textarea_name
    except AttrubuteError: return
    try: textarea_name_external = self.rename[textarea_name_external]
    except KeyError: pass
    try: textarea_value = self.lic_pars[textarea_name_external]
    except KeyError:
      HtmlParser.end_textarea(self)
      return
    self.inputs[textarea_name] = textarea_value
    del self.lic_pars[textarea_name_external]

  def anchor_bgn (self, href, name, type):
    download = re.compile(r'Limits.*time=')
    if download.search(href): self.href = href

  def do_input (self, attrs):
    def proc_name (name, value):
      array = re.compile(r'(\w+)\[]')	# word[]
      try: self.limitEntry
      except AttributeError:
        self.inputs[name] = value
        try:
          self.inputs[name] = self.lic_pars[name]
          del lic_pars[name]
        except KeyError: pass
      else:		# limit table entry
        if array.match(name):	# element of array of limit attributes
          array_elem = array.match(name).group(1)
          if array_elem == 'paramIDs': self.limits.append([(name,value)])
          else:
            if array_elem == 'paramNames':
              self.limitEntry = 2	# found limit name cell
            elif array_elem == 'paramVals':
              try: self.limit_name
              except AttributeError: pass
              else:	# value element
                try:
                  value = self.lic_pars[self.limit_name]
                  del self.lic_pars[self.limit_name]
                except KeyError: pass
            self.limits[-1].append((name,value))

    return HtmlParser.do_input(self,attrs,proc_name)

  def start_strong (self, attrs):
    self.strong = ''

  def end_strong (self):
    try:
      self.strong_hdr = self.strong
      del self.strong
    except AttributeError: pass

  def handle_data (self, data):
    HtmlParser.handle_data(self,data)
    try:
      if self.limitEntry == 2:
        self.limit_name = data.strip()	# current limit name
    except AttributeError: pass
    try: self.strong += data
    except AttributeError: pass
