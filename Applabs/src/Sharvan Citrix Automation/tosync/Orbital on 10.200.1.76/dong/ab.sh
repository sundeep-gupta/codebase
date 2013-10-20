#!/bin/sh
if [ $# -ne 3 ]; then
   echo "usage $0 <request> <concurrent> <HTTP>"
   exit 1
fi
sudo sh -c "ulimit -s 256 && ulimit -n 4096 && ulimit -a && ab -n $1 -c $2 $3"

