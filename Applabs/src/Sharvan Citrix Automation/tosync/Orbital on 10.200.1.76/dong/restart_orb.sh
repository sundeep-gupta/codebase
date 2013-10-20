#Continuously restart the Orb process.
#The system should not coredump
#--------------------------------
#!/bin/sh
if [ $# -ne 1]; then
   echo "usage $0 <Orb>"
   exit 1
fi
#starting the loop
while true
do
 ssh $1 "/etc/init.d/orbital restart"
 sleep 60
done

