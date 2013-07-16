#!/usr/bin/python
import sys
import os
import logging
import getopt
sys.path.append(os.path.dirname(os.path.abspath(sys.argv[0])) + '/google')
sys.path.append(os.path.dirname(os.path.abspath(sys.argv[0])) + '/helper')
from Picasa import *
from utils import *

logging.basicConfig(level=logging.DEBUG,
        format='[%(asctime)s] [%(levelname)s] [%(filename)s::%(funcName)s] %(message)s',
        datefmt='%d %b %H:%M:%S',
        filename="/media/sf_DATA/logs/google_helper.log",
        )
pwmap = {'sundeep.techie':'gr33N!e.', 'harshasanghi':'131984', 'apnabollywoodpics':'SCJP+scwcd5'}
picasa_folder = '/media/sf_DATA/pictures/picasa'
doc_folder='/media/sf_DATA/documents/icici'
account = 'sundeep.techie'
account_password = 'gr33N!e.'
def upload_albums():
    global pwmap, picasa_folder
    
    return upload2picasa(picasa_folder, pwmap)

def delete_empty_albums():
    global pwmap
    for username, password in pwmap.items() :
        handler = Picasa(username, password)
        if handler is not None :
            logging.info('Deleting empty albums of ' + username)
            handler.DeleteAllEmptyAlbums()
            logging.info("Deletion of empty albums is complete for user -" + username)
        else :
            logging.error('Failed to authenticate.')
            
def upload_docs():
    global doc_folder
    global account
    global account_password
    uploadIciciCron(doc_folder, account, account_password)

def create_bollywood_blog(): 
    username = 'sundeep.techie'
    password = 'gr33N!e.'
    #albums_uploaded = upload2picasa(picasa_folder, {'apnabollywoodpics':'SCJP+scwcd5'})
    # Now get all pics of the album (URL) and create an album
    hPicasa = Picasa(username, password)
    l = hPicasa.GetAllPhotoes('Gangor')
    for p in l :
        print p.GetMediaURL() + str(p.height.text)
    
    
def print_help():
    print """
    google_helper --upload <value>  --delete-empty-albums
    
    OPTIONS:
    ========
    
    --delete-empty-albums : deletes the empty albums
    --upload : valid values are 'album' or 'docs'
    
"""


def main():
    
    valid_options = {'help':0, 'upload=':None, 'delete-empty-albums':False}
    
    optlist, args = getopt.getopt(sys.argv[1:], 'x', valid_options.keys())
    for opt, val in optlist :
        if opt == '--help' :
            print_help()
            sys.exit(1)
        elif opt == '--delete-empty-albums' :
            valid_options['delete-empty-albums'] = True
        elif opt == '--upload' :
           valid_options['upload'] = val
    print valid_options    
    if valid_options['upload'] is not None and valid_options['delete-empty-albums'] :
        print "Cannot give both upload and delete-empty-albums at same time"
        logging.error("Cannot give both upload and delete-empty-albums at same time")
        return print_help()
    elif valid_options['upload'] is  None and not valid_options['delete-empty-albums'] :
        print "Atleast one option is must."
        logging.error("Atleast one option is must.")
        return print_help()
    
    if valid_options['delete-empty-albums'] :
        return delete_empty_albums()
    if valid_options['upload'] == 'albums' :
        return upload_albums()
    if valid_options['upload'] == 'docs' :
        return upload_docs()

if __name__ == '__main__' :
    main()
    #create_bollywood_blog()
