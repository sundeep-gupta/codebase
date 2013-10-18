#!/bin/sh
#Recursive scp through orb boxes
if [ $# -ne 1 ]; then
   echo "usage $0 <remote_IP> "
   exit 1
fi
#define the number of loop to run
cycle = 100
echo "Start copying files ..." >log
for ((i = 1; i <= $cycle; i++))
do
echo "DATE $(date)" >> log
scp /root/56-66/56/* root@$1:/root/56-66/66/.
echo "These are files copying to the remote host" >> log
echo "----------------" >>log
#run a remote command to extract the files 
ssh $1 "ls -l /root/56-66/66" >> log
scp root@$1:/root/56-66/66/* /root/56-66/66/.
echo "Files re-copied back from the remote host" >> log
echo "----------------" >>log
ls -l /root/56-66/66 >>log
echo "Diff the files" >> log
echo "----------------" >>log
#report if files are the same (-s) and log
diff -s  /root/56-66/56 /root/56-66/66 >>log
mail -s "test results" dong@orbitaldata.com < log
done
