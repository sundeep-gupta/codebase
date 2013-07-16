#Description : This script was written as work around for HF408995. This script will unload the scanmanager and kills all VShieldScanners and reloads the scanners again.
#Date: 24-06-2008
#Written by : Anand Pandit.

echo " Unloading the VShieldScanManager Process"
echo " "
sudo launchctl unload /Library/LaunchDaemons/com.mcafee.virusscan.ScanManager.plist  2>/dev/null
 
echo " Getting the pid of the VShieldScanManager process "
pid=`ps -a -U root -o "pid" -o "command" | awk -F " " '{ if ( $2 == "/usr/local/vscanx/VShieldScanManager" ) {print $1}  }'`
echo " The VShieldScanManager pid :" $pid
echo "Shutting down VirusScan Daemons..."
sudo kill -1 ${pid} 2>/dev/null

echo " Sleeping for one minute..."
sleep 60;

echo " Loading VShieldScanManager..."
sudo launchctl load /Library/LaunchDaemons/com.mcafee.virusscan.ScanManager.plist
echo " "
pid=`ps -a -U root -o "pid" -o "command" | awk -F " " '{ if ( $2 == "/usr/local/vscanx/VShieldScanManager" ) {print $1}  }'`
echo "VShieldScanManger has now pid as :"$pid
echo " "
sleep 30;
 
pid2=`ps -ax -o "pid" -o "command" | awk -F " " '{ if ( $2 == "/usr/local/vscanx/VShieldScanner" ) {print $1}  }'`
echo " VShieldScanner pid's are :"$pid2
echo " "

