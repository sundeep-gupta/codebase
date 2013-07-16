
import gdata.docs
import gdata.data
import gdata.docs.client
import gdata.docs.service
import os
import sys

class Docs :
    
    def __init__(self, username, password):
        self.username = username
        self.password = password
        self.client = gdata.docs.client.DocsClient(source='Soulful-PythonAPI')
        self.client.ssl = True
        self.client.ClientLogin(username+'@gmail.com', password, self.client.source)

    def uploadPdf(self, filename, title):
        f = open(filename)
        ms = gdata.data.MediaSource(file_handle=f,
                            file_name= os.path.basename(filename),
                            content_type='application/pdf',
                            content_length=os.path.getsize(filename))
        entry = self.client.Upload(ms, title, folder_or_uri='/feeds/default/private/full/?convert=false')
        if entry is None :
            logging.error("Failed to upload pdf file")
            
"""
OTHER TRIALS 
============
feed = client.GetDocList(uri='/feeds/default/private/full/-/folder')
folder = feed.entry[0]
print folder.GetAttributes()
print folder.category[0].label
print folder.category[1].label
print folder.category[2].label
print folder.id

sys.exit(1)
print folder
print 'Contents of folder: ' + folder.title.text
feed = client.GetDocList(uri=folder.content.src)
for doc in feed.entry:
  print doc.title.text, [f.title for f in doc.InFolders()]
  
  
# Create a client class which will make HTTP requests with Google Docs server.
client = gdata.docs.service.DocsService()
# Authenticate using your Google Docs email address and password.
client.ClientLogin('sundeep.techie@gmail.com', 'gr33N!e.')

# Query the server for an Atom feed containing a list of your documents.
#documents_feed = client.GetDocumentListFeed()
# Loop through the feed and extract each document entry.
#for document_entry in documents_feed.entry:
#  # Display the title of the document on the command line.
#  print document_entry.title.text
  
"""
