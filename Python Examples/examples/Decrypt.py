import sys
import os.path
import subprocess
import pyPdf
import logging
import re


def decryptPdf(source, target, password):
    try :
        logging.info("Reading " + source)
        input = pyPdf.PdfFileReader( file(source, 'rb'))
        logging.info("Checking if file is encrypted")
        if(input.getIsEncrypted()) :
            logging.info("File is incrypted, decrypting it")
            input.decrypt(password)
        output = pyPdf.PdfFileWriter()
        output.encrypt("SCJP+scwcd5")
        for i in range(0, input.getNumPages()) :
            output.addPage(input.getPage(i))
        outputStream = file(target, 'wb')
        output.write(outputStream)
        outputStream.close()
    except Exception, e :
        logging.warn("Failed to decrypt using pyPdf" + e.strerror)
        

decryptPdf("D:\\one.pdf", "D:\\two.pdf", "007601517065");