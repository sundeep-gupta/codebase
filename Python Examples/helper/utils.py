#!/usr/bin/env python

# This program is used to decrypt my ICICI's encrypted files. Expects the directory as sysarg

import sys
import os.path
import subprocess
import pyPdf
import logging
import re

sys.path.append('../google')
from Picasa import *
from Docs import *

def uploadIciciCron(folder='/media/DATA/documents/icici', account='sundeep.techie', account_password='gr33N!e.') :
    """
    Looks if there is any file in any of the below subdirectories of given directory,
    Subdirs searched - 'bank', 'equity', 'mutualfund', 'creditcard'
    If any file is found [assuming it is pdf and encrypted] we try to decrypt it and upload to google account.
    
    More to do :
    1. option to upload already decrypted file.
    2. Look into other directories also if specified.
    3. check the file-type [not just extn] and upload to google doc as appropriate type.
    """
    subdirs = os.listdir(folder)
    pw_list = {'bank':'007601517065', 'equity':'8501078634', 'mutualfund':'8501078634','creditcard':'sund1103',
               'grid': 'SUNQFRT3'}
    for subdir in subdirs :
        logging.info("Looking in directory " + subdir)
        if subdir in pw_list.keys():
            password = pw_list[subdir]
            subdir_list = os.listdir(folder + '/' + subdir)
            for f in subdir_list :
                abs_subdir = folder + '/' + subdir
                filename = abs_subdir + '/' + f
                if not os.path.isfile(filename) :
                    continue
                tmp_dir = abs_subdir + '/.tmp'
                if not os.path.exists(tmp_dir) :
                    os.mkdir(tmp_dir)

                output = tmp_dir + '/' + f
                if os.path.exists(output) :
                    logging.info("%s already exists. Deleting it" % output)
                    os.unlink(output)
                
                """ Decrypt the file"""
                logging.info("Decrypting file %s to %s with password %s" %(filename, output, password))
                try :
                    print "Will try qpdf and pyPdf"
                    decryptPdf(filename, output, password)
                except:
                    print("Exception occured during decrypt, skipping %s" % f)
                    logging.error("Exception occured while decrypting %s" % f)
                    continue
                if os.path.exists(output) :
                    logging.info("%s file got created successfully" % output)
                """Upload to Google Docs
                TODO : Currently 'Upload to particular folder is not available"""
                docsInstance = Docs(account, account_password)
                title = re.sub('\.pdf$','', os.path.basename(output))
                print title 
                docsInstance.uploadPdf(output, title)
                if not os.path.exists(abs_subdir + '/uploaded') :
                    os.mkdir(abs_subdir + '/uploaded')
                os.rename(filename, abs_subdir + '/uploaded/' + f)

def upload2picasa(folder, pwmap):
    subdirs = os.listdir(folder)
    pw_list = pwmap
    uploaded = {}
    for subdir in subdirs :
        logging.info("Looking in directory " + subdir)
        if subdir not in pw_list.keys() :
            continue
        password = pw_list[subdir]
        access = 'private'
        
        """For apnabollywoodpics account, lets keep it public"""
        if subdir == 'apnabollywoodpics' :
            access = 'public'
        """We will upload all directories but 'upload' and hidden ones"""
        abs_subdir = folder + '/' + subdir
        subdir_list = os.listdir(folder + '/' + subdir)
        albums_to_upload = [album for album in subdir_list if os.path.isdir(abs_subdir + '/' + album) and album  != 'uploaded' and not album.startswith('.')]
        if len(albums_to_upload) == 0 :
            logging.info("No new albums to upload for %s" % subdir)
            continue
        uploaded[subdir] = albums_to_upload
        logging.info("Found new album(s) for user %s" % subdir)
        picasa = Picasa(subdir, password)
        if picasa is None :
            logging.error("Could not connect to picasa using username %s" % subdir)
            continue
        for album_name in albums_to_upload :
            album_path = abs_subdir + '/' + album_name
            newAlbum = picasa.CreateNewAlbum(album_path, album_name)
            if newAlbum is not None :
                logging.info("Album %s successfully created" % album_name)
            else :
                logging.error("Failed to create new album.")
            if not os.path.exists(abs_subdir + '/uploaded') :
                os.mkdir(abs_subdir + '/uploaded')
            os.rename(album_path, abs_subdir + '/uploaded/' + album_name)
        return uploaded
def decryptPdf(source, target, password):
    try :
        logging.info("Reading " + source)
        input = pyPdf.PdfFileReader( file(source, 'rb'))
        logging.info("Checking if file is encrypted")
        if(input.getIsEncrypted()) :
            logging.info("File is incrypted, decrypting it")
            input.decrypt(password)
        output = pyPdf.PdfFileWriter()
        for i in range(0, input.getNumPages()) :
            output.addPage(input.getPage(i))
        outputStream = file(target, 'wb')
        output.write(outputStream)
        outputStream.close()
    except Exception, e :
        logging.warn("Failed to decrypt using pyPdf, now trying with qpdf")
        command = 'qpdf --password="' + password +'" --decrypt "' + source + '" "' + target + '"'
        logging.info("Running command " + command)
        result = subprocess.call(command, shell=True) # Not piping the stdout as we will not use it.
        if result == 0 :
            logging.info("Successfully decrypted using qpdf")
        else :
            logging.error("Failed with qpdf, raising the same exception")
            raise e
