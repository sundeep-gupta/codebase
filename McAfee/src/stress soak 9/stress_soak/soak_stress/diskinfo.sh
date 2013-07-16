
date1=`date`
user=`whoami`
while :
do

echo '*********************************************************************' >> ./logs/freedisk.log
echo 'The Current System or Logged in user is :'$user >> ./logs/freedisk.log
echo 'The Disk Statistics at :' $date1 >> freedisk.log
echo '*********************************************************************' >> ./logs/freedisk.log
df -ahm >> ./logs/freedisk.log

echo '\n' >> ./logs/freedisk.log
echo '\n' >> ./logs/freedisk.log
echo '\n' >> ./logs/freedisk.log

echo "Note : read the values in MB's" >> ./logs/freedisk.log

sleep 300 

done
