#!/bin/sh
#Dong 3/25/05
#This script is used for reliability compression test.
if [ $# -ne 4 ]; then
   echo "usage $0 <IPERF Server> <#sess> <time> <DIR CompFiles>"
   exit 1
fi
while true
do
sudo sh -c "ulimit -s 126 && ulimit -n 4096 && ulimit -a && iperf -c $1 -P $2 -t $3 -X $4 -l 256 -w 500"
sleep 10
done
