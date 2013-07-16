#!/bin/sh
#Dong 3/25/05
#This script is used for reliability compression test.
if [ $# -ne 3 ]; then
   echo "usage $0 <IPERF Server> <#sess> <DIR CompFiles>"
   exit 1
fi
while true
do
sudo sh -c "ulimit -s 126 && ulimit -n 4096 && ulimit -a && iperf -c $1 -P $2 -X $3  -t 999999"
done
