#!/usr/bin/python
import zipfile
import sys
import os

path = sys.argv[1]
if not os.path.exists(path) :
    print "Please gimme the valid path"

dest = "/Volumes/Bubble"

zipFile = zipfile.ZipFile(path)
zipFile.extractall(path=dest)


