#!/usr/bin/python
import tarfile
import sys
filename = sys.argv[1]
mypath = sys.argv[2]
tf = tarfile.open(filename, mode='r:gz')
print tf.getnames()
tf.extractall(path=mypath)


