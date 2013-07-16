#!/usr/bin/python

import os.path
import re
import shutil

def _func(arg, dirname, fnames) :
	for file in fnames :
	#	if re.search("\.crash$", file) is not None :
		if os.path.isfile(dirname + "/" + file) \
			and re.search("\.(log|crash)$", file) :
			print "Copying : " + dirname + "/" + file
			shutil.copy(dirname + "/" + file , arg[0])

dir = "/Library/Logs"
arg = ["/tmp"]
os.path.walk(dir, _func, ["/tmp"])
if os.path.islink("/tmp/file1.txt") :
	print os.path.realpath("/tmp/file1.txt")

