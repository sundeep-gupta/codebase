#!/bin/sh
#Dong 3/25/05
#This script is used for reliability test.
if [ $# -ne 3 ]; then
   echo "usage $0 <IPERF Server> <#sess> <duration>"
   exit 1
fi
sudo sh -c "ulimit -s 126 && ulimit -n 4096 && ulimit -a && iperf -c $1 -P $2 -t $3 -l 500 -w 500"

