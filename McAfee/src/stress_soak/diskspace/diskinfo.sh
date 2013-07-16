rm -rf *.log


date1=`date`
user=`whoami`
while :
do

echo '*********************************************************************' >> freedisk.log
echo 'The Current System or Logged in user is :'$user >> freedisk.log
echo 'The Disk Statistics at :' $date1 >> freedisk.log
echo '*********************************************************************' >> freedisk.log
df -ahm >> freedisk.log

echo '\n' >> freedisk.log
echo '\n' >> freedisk.log
echo '\n' >> freedisk.log

echo "note : read the values in MB's" >> freedisk.log

sleep 100

done
