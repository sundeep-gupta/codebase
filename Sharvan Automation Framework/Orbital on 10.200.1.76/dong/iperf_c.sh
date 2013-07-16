#!/bin/sh
#Dong 3/25/05
#This script is used for reliability test.
if [ $# -ne 3 ]; then
   echo "usage $0 <IPERF Server> <#sess> <duration>"
   exit 1
fi
while true
do
sudo sh -c "ulimit -s 256 && ulimit -n 8192 && ulimit -a && iperf -c $1 -P $2 -t $3"
sleep 4
done
