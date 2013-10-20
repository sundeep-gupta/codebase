#!/bin/sh
#Dong 12/15/05
# WGET a chunk of files and send it to the null device
# Make sure the files are lesser than 2GB. Known to fail with
# 3GB
#-------------------


if [ $# -ne 1 ]; then
   echo "usage $0 <FTP Server> "
   exit 1
fi

wget ftp://dbc:dbc@$1/* -O /dev/null


