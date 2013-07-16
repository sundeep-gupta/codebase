import sys
sys.path.append('google')
from Docs import *
username='google_username'
password='google_password'
docs = Docs(username, password)
docs.uploadPdf('/home/soulful/DST_Reports_Receiver_Requirements_Specification.pdf', 'Test Title')
