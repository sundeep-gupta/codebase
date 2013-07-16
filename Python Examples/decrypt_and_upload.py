#!/usr/bin/python
import getopt
import logging
import sys
import os
import re
sys.path.append(os.path.dirname(sys.argv[0]) + "/helper")
sys.path.append(os.path.dirname(sys.argv[0]) + '/google')

from Docs import *
from utils import *

def print_help():
    print """
    decrypt_and_upload --filename <encrypted_pdf> --output <target_file> --password <pdf_passwd> --account <email_id> --account-password <gmail_passwd>
    
    OPTIONS:
    ========
    
    --filename : the encrypted pdf file
    --output : The target file name after the file is decrypted
    --password : Password of the encrypted file
    --account : The Google Account ID
    --account-password : The Google Account password
    
"""

if __name__ == '__main__' :
    # Now, configure the logging
    logging.basicConfig(level=logging.DEBUG,
            format='[%(asctime)s] [%(levelname)s] [%(filename)s::%(funcName)s] %(message)s',
            datefmt='%d %b %H:%M:%S',
            filename="/media/DATA/logs/decrypt_and_upload.log",
            filemode='w')
    doc_folder='/media/DATA/documents/icici',
    account = 'sundeep.techie'
    account_password = 'gr33N!e.'
    uploadIciciCron(doc_folder, account, account_password)
    logging.error('Done')

if __name__ == '__Undefined__' :
    valid_options = ['help', 'password=', 'filename=', 'output=', 'account=', 'account-password=']
    optlist, args = getopt.getopt(sys.argv[1:], 'x', valid_options)
    for opt, val in optlist :
        if opt == '--help' :
            print_help()
            sys.exit(1)
        elif opt == '--password' :
            password = val
        elif opt == '--filename' :
            filename = val
            if not os.path.isfile(filename) :
                logging.error("%s is not a file" % filename)
                sys.exit(1)
        elif opt == '--output' :
            if os.path.exists(val) :
                logging.error("Output location already exist - %s" % val)
                sys.exit(1)
            output = val
        elif opt == '--account' :
            account = val
        elif opt == '--account-password' :
            account_password = val
    """ Decrypt the file"""
    decryptPdf(filename, output, password)
    """Upload to Google Docs
    TODO : Currently 'Upload to particular folder is not available"""
    
    docsInstance = Docs(account, account_password)
    docsInstance.uploadPdf(output, os.path.basename(output))
    
