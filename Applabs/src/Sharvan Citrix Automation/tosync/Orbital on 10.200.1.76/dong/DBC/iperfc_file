#!/bin/sh
if [ $# -ne 4 ]; then
   echo "usage $0 <IPERF Server> <#sess> <duration> <file>"
   exit 1
fi
while true
do
sudo sh -c "ulimit -s 256 && ulimit -n 8192 && ulimit -a && iperf -c $1 -P $2 -t $3 -F $4"
sleep 5
done
