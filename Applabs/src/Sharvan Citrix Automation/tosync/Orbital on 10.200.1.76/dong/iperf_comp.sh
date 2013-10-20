#!/bin/sh
#Dong 3/25/05
#This script is used for reliability compression test.
if [ $# -ne 4 ]; then
   echo "usage $0 <IPERF Server> <#sess> <time> <DIR CompFiles>"
   exit 1
fi
sudo sh -c "ulimit -s 128 && ulimit -n 4096 && ulimit -a && iperf -c $1 -P $2 -t $3 -X $4"
