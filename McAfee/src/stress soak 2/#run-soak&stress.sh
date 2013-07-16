#!/bin/sh


cp Includes/VSMacDatabase.db /usr/local/McAfee/AntiMalware/

if [ -d "/private/tmp/ScanFolder" ];
then 
rm /private/tmp/ScanFolder
fi

#rm *.log

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "This script would help you to create tasks for VirusScan on your Mac for STRESS and SOAK tests"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ""
echo "Select the desire option from 1,2,3,4 to continue................"
echo""
echo "1. Start Soak Test with CLEAN dataset"
echo "2. Start Soak Test with MIXED dataset"
echo "3. Start STRESS Test with CLEAN dataset"
echo "4. Start STRESS Test with MIXED dataset"
echo ""
echo "Please enter the required option and press ENTER key :   "

read response

case $response in

1)
echo ""
echo "You selected........Soak Test with CLEAN dataset..Option 1"
crontab -r
sudo crontab -r
perl create_cron_jobs.pl soak clean
crontab crontabjobs.txt
perl soak-clean.pl
;;

2)
echo ""
echo "You selected........Soak Test with MIXED dataset.. Option 2 "
crontab -r
sudo crontab -r
perl create_cron_jobs.pl soak mixed
crontab crontabjobs.txt
perl soak-mixed.pl
;;

3)
echo ""
echo "You selected........STRESS Test with CLEAN dataset..Option 3 "
crontab -r
sudo crontab -r
perl create_cron_jobs.pl stress clean
crontab crontabjobs.txt
perl stress-clean.pl
;;

4)
echo ""
echo "You selected........STRESS Test with MIXED dataset..Option 4"
crontab -r
sudo crontab -r
perl create_cron_jobs.pl stress mixed
crontab crontabjobs.txt
perl stress-mixed.pl
;;

*)
echo "Invalid selection. Please rerun and reselect.........."
echo "Invalid selection. Please rerun and reselect.........."
echo "Invalid selection. Please rerun and reselect.........."

;;
esac
