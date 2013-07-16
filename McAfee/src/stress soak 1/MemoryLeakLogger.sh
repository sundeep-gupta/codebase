# Written by : Anand Pandit
# Modified for MSM : Purvang Vora
#
#
#Please change the delay value as per your need,
#Here Decrease in delay will make leaks command to run frequently.
#Ideally the leaks should run once or twice in day for once in day the delay should be 86400 and for 
#Twice a day delay should be 43200
#
#
# Please do not change any thing other than delay.
#

logpath=./logs/
#delay=120

if [ -f "./leaks_Leopard" -o  -f "./leaks_Tiger" ]; then
echo ""
pid=`ps -a -U root -o "pid" -o "command" | awk -F " " '{ if ( $2 == "/usr/local/McAfee/AntiMalware/VShieldScanManager" ) {print $1}  }'`
echo "Process ID of VShieldScanManager" $pid;

pids=`ps -a -U root -o "pid" -o "command" | awk -F " " '{ if ( $2 == "/usr/local/McAfee/AntiMalware/VShieldScanner" ) {print $1}  } '`
echo "Process ID of VShieldScanners" $pids;

pids2=`ps -a -U root -o "pid" -o "command" | awk -F " " '{ if ( $2 == "/usr/local/McAfee/AntiMalware/VShieldService" ) {print $1}  } '`
echo "Process ID of Process ID of VShieldService" $pids2;

pids3=`ps -a -U root -o "pid" -o "command" | awk -F " " '{ if ( $2 == "/usr/local/McAfee/fmp/bin/fmpd" ) {print $1}  } '`
echo "Process ID of fmpd" $pids2;

pids4=`ps -a -U root -o "pid" -o "command" | awk -F " " '{ if ( $2 == "/usr/local/McAfee/AppProtection/bin/appProtd" ) {print $1}  } '`
echo "Process ID of of appProtd" $pids4;

pids5=`ps -a -U root -o "pid" -o "command" | awk -F " " '{ if ( $2 == "/usr/local/McAfee/Firewall/bin/FWService" ) {print $1}  } '`
echo "Process ID of of FWService" $pids5;

pids6=`ps -a -U root -o "pid" -o "command" | awk -F " " '{ if ( $2 == "/Library/Application Support/McAfee/MSS/Applications/Menulet.app/Contents/MacOS/Menulet" ) {print $1}  } '`
echo "Process ID of of Menulet" $pids6;

osversion=`/usr/bin/defaults read "$3/System/Library/CoreServices/SystemVersion" ProductVersion` 
os_majorversion=`echo $osversion | cut -f2 -d'.'`
os_minorversion=`echo $osversion | cut -f3 -d'.'`

if [ $os_majorversion -eq 4 ]
then
        echo "The Operating System is Tiger" >> $logpath/VShieldScanner_pid_$prid.log
        echo "Running the leaks command on VShieldScanner with pid: $prid" >> $logpath/VShieldScanner_pid_$prid.log

	for prid in $pids
	do 
		./leaks_Tiger $prid >> $logpath/VShieldScanner_pid_$prid.log
		echo "The above leaks output was taken at:" >> $logpath/VShieldScanner_pid_$prid.log
		date >> $logpath/VShieldScanner_pid_$prid.log
		echo " " >> $logpath/VShieldScanner_pid_$prid.log		
	done
       	echo "Running the leaks commmand on VShieldScanManger with pid :$pid" >> $logpath/VShieldScanManager_pid_$pid.log
	./leaks_Tiger $pid >> $logpath/VShieldScanManager_pid_$pid.log
	echo "The above leaks output was taken at:" >> $logpath/VShieldScanManager_pid_$pid.log
	date >> $logpath/VShieldScanManager_pid_$pid.log
	echo " " >> $logpath/VShieldScanManager_pid_$pid.log

        echo "Running the leaks commmand on VShieldService with pid :$pids2" >> $logpath/VShieldService_pid_$pids2.log
        ./leaks_Tiger $pids2 >> $logpath/VShieldService_pid_$pids2.log
        echo "The above leaks output was taken at:" >> $logpath/VShieldService_pid_$pids2.log
        date >> $logpath/VShieldService_pid_$pids2.log
        echo " " >> $logpath/VShieldService_pid_$pids2.log

        echo "Running the leaks commmand on fmpd with pid :$pids3" >> $logpath/fmpd_pid_$pids3.log
        ./leaks_Tiger $pids3 >> $logpath/fmpd_pid_$pids3.log
        echo "The above leaks output was taken at:" >> $logpath/fmpd_pid_$pids3.log
        date >> $logpath/fmpd_pid_$pids3.log
        echo " " >> $logpath/fmpd_pid_$pids3.log

        echo "Running the leaks commmand on appProtd with pid :$pids4" >> $logpath/appProtd_pid_$pids4.log
        ./leaks_Tiger $pids4 >> $logpath/appProtd_pid_$pids4.log
        echo "The above leaks output was taken at:" >> $logpath/appProtd_pid_$pids4.log
        date >> $logpath/appProtd_pid_$pids4.log
        echo " " >> $logpath/appProtd_pid_$pids4.log

        echo "Running the leaks commmand on FWService with pid :$pids5" >> $logpath/FWService_pid_$pids5.log
        ./leaks_Tiger $pids5 >> $logpath/FWService_pid_$pids5.log
        echo "The above leaks output was taken at:" >> $logpath/FWService_pid_$pids5.log
        date >> $logpath/FWService_pid_$pids5.log
        echo " " >> $logpath/FWService_pid_$pids5.log

        echo "Running the leaks commmand on Menulet with pid :$pids6" >> $logpath/Menulet_pid_$pids6.log
        ./leaks_Tiger $pids6 >> $logpath/Menulet_pid_$pids6.log
        echo "The above leaks output was taken at:" >> $logpath/Menulet_pid_$pids6.log
        date >> $logpath/Menulet_pid_$pids6.log

exit
fi

if [  $os_majorversion -lt 7  -a  ${os_minorversion:-0} -lt 8  ]
then
        echo " The Operating System is Leopard,So Running the leaks command" >> $logpath/VShieldScanner_pid_$prid.log
        echo "Running the leaks command on VShieldScanner with pid: $prid" >> $logpath/VShieldScanner_pid_$prid.log
	for prid in $pids
	do 
		./leaks_Leopard $prid >> $logpath/VShieldScanner_pid_$prid.log
		echo "The above leaks output was taken at:" >> $logpath/VShieldScanner_pid_$prid.log
		date >> $logpath/VShieldScanner_pid_$prid.log
		echo " " >> $logpath/VShieldScanner_pid_$prid.log		
	done
       	echo "Running the leaks commmand on VShieldScanManager with pid :$pid" >> $logpath/VShieldScanManager_pid_$pid.log
	./leaks_Leopard $pid >> $logpath/VShieldScanManager_pid_$pid.log
	echo "The above leaks output was taken at:" >> $logpath/VShieldScanManager_pid_$pid.log
	date >> $logpath/VShieldScanManager_pid_$pid.log
	echo " " >> $logpath/VShieldScanManager_pid_$pid.log

        echo "Running the leaks commmand on VShieldService with pid :$pids2" >> $logpath/VShieldService_pid_$pids2.log
        ./leaks_Leopard $pids2 >> $logpath/VShieldService_pid_$pids2.log
        echo "The above leaks output was taken at:" >> $logpath/VShieldService_pid_$pids2.log
        date >> $logpath/VShieldService_pid_$pids2.log
        echo " " >> $logpath/VShieldService_pid_$pids2.log


        echo "Running the leaks commmand on fmpd with pid :$pids3" >> $logpath/fmpd_pid_$pids3.log
        ./leaks_Leopard $pids3 >> $logpath/fmpd_pid_$pids3.log
        echo "The above leaks output was taken at:" >> $logpath/fmpd_pid_$pids3.log
        date >> $logpath/fmpd_pid_$pids3.log
        echo " " >> $logpath/fmpd_pid_$pids3.log

        echo "Running the leaks commmand on appProtd with pid :$pids4" >> $logpath/appProtd_pid_$pids4.log
        ./leaks_Leopard $pids4 >> $logpath/appProtd_pid_$pids4.log
        echo "The above leaks output was taken at:" >> $logpath/appProtd_pid_$pids4.log
        date >> $logpath/appProtd_pid_$pids4.log
        echo " " >> $logpath/appProtd_pid_$pids4.log

        echo "Running the leaks commmand on FWService with pid :$pids5" >> $logpath/FWService_pid_$pids5.log
        ./leaks_Leopard $pids5 >> $logpath/FWService_pid_$pids5.log
        echo "The above leaks output was taken at:" >> $logpath/FWService_pid_$pids5.log
        date >> $logpath/FWService_pid_$pids5.log
        echo " " >> $logpath/FWService_pid_$pids5.log

        echo "Running the leaks commmand on Menulet with pid :$pids6" >> $logpath/Menulet_pid_$pids6.log
        ./leaks_Leopard $pids6 >> $logpath/Menulet_pid_$pids6.log
        echo "The above leaks output was taken at:" >> $logpath/Menulet_pid_$pids6.log
        date >> $logpath/Menulet_pid_$pids6.log


fi

sleep $delay
#echo " Sleeping for $delay seconds"
else
	echo " Leaks Binary is not present at the directory where this script is located. "
fi
