'httplib modifications to add logging'

__author__ = "Val Shkolnikov <val.shkolnikov@orbitaldata.com>"
__version__ = "$Id: httpown.py,v 1.1 2005/04/06 22:18:55 jason Exp $"

import sys, os, stat, time, httplib, random, mimetools, mimetypes, socket
import common
EOL= common.EOL
s_t = common.s_t

class ConnectError (common.Error):
  'Raised on connection error'

class HTTPResponse (httplib.HTTPResponse):

	# adapted from Lib/httplib.py to use log
    def _read_status (self):
        # Initialize with Simple-Response defaults
        line = self.fp.readline()
        self.log("reply: " + repr(line) + EOL,2)
        if not line:
            # Presumably, the server closed the connection before
            # sending a valid response.
            raise BadStatusLine(line)
        try:
            [version, status, reason] = line.split(None, 2)
        except ValueError:
            try:
                [version, status] = line.split(None, 1)
                reason = ""
            except ValueError:
                # empty version will cause next test to fail and status
                # will be treated as 0.9 response.
                version = ""
        if not version.startswith('HTTP/'):
            if self.strict:
                self.close()
                raise BadStatusLine(line)
            else:
                # assume it's a Simple-Response from an 0.9 server
                self.fp = LineAndFileWrapper(line, self.fp)
                return "HTTP/0.9", 200, ""

        # The status code is a three-digit number
        try:
            status = int(status)
            if status < 100 or status > 999:
                raise BadStatusLine(line)
        except ValueError:
            raise BadStatusLine(line)
        return version, status, reason

    def begin(self):
        if self.msg is not None:
            # we've already started reading the response
            return

        # read until we get a non-100 response
        while True:
            version, status, reason = self._read_status()
            if status != 100:
                break
            # skip the header from the 100 response
            while True:
                skip = self.fp.readline().strip()
                if not skip:
                    break
                self.log("header: " + skip + EOL,2)

        self.status = status
        self.reason = reason.strip()
        if version == 'HTTP/1.0':
            self.version = 10
        elif version.startswith('HTTP/1.'):
            self.version = 11   # use HTTP/1.1 code for HTTP/1.x where x>=1
        elif version == 'HTTP/0.9':
            self.version = 9
        else:
            raise UnknownProtocol(version)

        if self.version == 9:
            self.chunked = 0
            self.will_close = 1
            self.msg = HTTPMessage(StringIO())
            return

        self.msg = httplib.HTTPMessage(self.fp, 0)
        self.log('headers: ' + `self.msg.headers` + EOL,3)

        # don't let the msg keep an fp
        self.msg.fp = None

        # are we using the chunked-style of transfer encoding?
        tr_enc = self.msg.getheader('transfer-encoding')
        if tr_enc and tr_enc.lower() == "chunked":
            self.chunked = 1
            self.chunk_left = None
        else:
            self.chunked = 0

        # will the connection close at the end of the response?
        self.will_close = self._check_close()

        # do we have a Content-Length?
        # NOTE: RFC 2616, S4.4, #3 says we ignore this if tr_enc is "chunked"
        length = self.msg.getheader('content-length')
        if length and not self.chunked:
            try:
                self.length = int(length)
            except ValueError:
                self.length = None
        else:
            self.length = None

        # does the body have a fixed length? (of zero)
        if (status == 204 or            # No Content
            status == 304 or            # Not Modified
            100 <= status < 200 or      # 1xx codes
            self._method == 'HEAD'):
            self.length = 0

        # if the connection remains open, and we aren't using chunked, and
        # a content-length was not provided, then assume that the connection
        # WILL close.
        if not self.will_close and \
           not self.chunked and \
           self.length is None:
            self.will_close = 1

class HttpOwn:

  def __init__ (self, host, port=80, use_ssl=0, log=None):
    if use_ssl:
      http = httplib.HTTPS(host,port)
    else:
      http = httplib.HTTP(host,port)
    if log:
      self.log = log
    self.conn = conn = http._conn
    self.http = http
    http.send = conn.send = self.send
    conn.response_class = HTTPResponse
    conn.response_class.log = self.log
    conn.connect()

  def log (self, str, *other):
    sys.stdout.write('HTTPOWN ' + str)
    sys.stdout.flush()

  def send (self, str):
    'Send str to the server'

    log = self.log
    self = self.conn		# tricky!
    if self.sock is None:
      if self.auto_open:
        self.connect()
      else:
        raise httplib.NotConnected()

        # send the data to the server. if we get a broken pipe, then close
        # the socket. we want to reconnect when somebody tries to send again.
        #
        # NOTE: we DO propagate the error, though, because we cannot simply
        #       ignore the error... the caller will know if they can retry.
    log('send: ' + repr(str)[:300] + common.EOL,2)
    log('send: ' + repr(str)[300:] + common.EOL,4)
    try:
      self.sock.send(str)
    except socket.error, v:
      if v[0] == 32:      # Broken pipe
        self.close()
      raise

  # based on post_multipart() by Wade Leftwich, 2002/08/23
  # http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/146306
  def encode_multipart_formdata (self, fields, files, boundary=None):
    """
    fields is a sequence of (name, value) elements for regular form fields.
    files is a sequence of (name, filename) elements for data to be
    uploaded as files.  boundary is a separator string.  Return
    (content_type, content_length, body) where body is
    [ string, (filename,), ... ].  The caller sends string directly and
    reads file contents from the files specified.
    """
    BOUNDARY = '----------ThIs_Is_tHe_bouNdaRY_$' # to compare w/post_multipart
    if not boundary: boundary = BOUNDARY
    CRLF = '\r\n'
    content_length = 0
    body = []
    body_entry = []
    for (key, value) in fields:
      body_entry.append('--' + boundary)
      body_entry.append('Content-Disposition: form-data; name="%s"' % key)
      body_entry.append('')
      body_entry.append(value)
    body_entry.append('')
    body.append(CRLF.join(body_entry))
    content_length += len(body[-1])
    body_entry = []
    for (key, filename) in files:
      body_entry.append('--' + boundary)
      body_entry.append(
       'Content-Disposition: form-data; name="%s"; filename="%s"' %
       (key, os.path.basename(filename)))
      body_entry.append('Content-Type: %s' % self.get_content_type(filename))
      body_entry.append('')
      body_entry.append('')
      body.append(CRLF.join(body_entry))
      content_length += len(body[-1])
    body.append((filename,))
    content_length += os.stat(filename)[stat.ST_SIZE]
    body_entry = []
    body_entry.append('')
    body_entry.append('--' + boundary + '--')
    body_entry.append('')
    body.append(CRLF.join(body_entry))
    content_length += len(body[-1])
    content_type = 'multipart/form-data; boundary=%s' % boundary
    return content_type, content_length, body
  
  def get_content_type (self, filename):
    return mimetypes.guess_type(filename)[0] or 'application/octet-stream'
  
  def make_boundary (self):
    boundary = '-'*27
    for i in range(30):
      boundary += str(random.randint(0,9))
    return boundary
