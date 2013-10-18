#!/bin/sh
#Dong 12/15/05
#Run LFTP automatically on a pre-defined set of files
#The script will be running on Linux client with no extra disk space
# I have to use GET to statically get each file to a null device
#-------------------

if [ $# -ne 2 ]; then
   echo "usage $0 <FTP Server> <last-3digit-filename> "
   exit 1
fi

lftp dbc1:dbc1@$1 -e "get 5GB-RANDOM-$2 -o /dev/null;bye"
sleep 10
lftp dbc1:dbc1@$1 -e "get 3GB-RANDOM-$2 -o /dev/null;bye"
sleep 10
lftp dbc1:dbc1@$1 -e "get 2GB-RANDOM-$2 -o /dev/null;bye"
sleep 10
lftp dbc1:dbc1@$1 -e "get 1GB-RANDOM-$2 -o /dev/null;bye"



