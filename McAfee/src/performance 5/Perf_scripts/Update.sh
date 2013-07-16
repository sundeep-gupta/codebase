#!/bin/bash 
########################################### Update the product DATS #############################################
#                                                                                                               #
# Description : This script is used to update the DATS                                                          #
# AUTHOR      : Sunil Shetty                                                                                    #
# DATE        : 4-Sep-2009                                                                                      #
#                                                                                                               #
########################################### Update the product DATS #############################################

#Cleanup Function 
cleanup ()
{ 
 `rm temp* > /dev/null`;
  `rm -rf /Volumes/DATA/ssm_perf/DATS/$version/*.dat`;
  `rm -rf /Volumes/DATA/ssm_perf/DATS/$version/*.txt`;
} 

if [ "$(id -u)" != "0" ]
then 
  echo -e "\nError : Only ROOT user can run this script\n";
  exit 1;
fi

datpath=$PWD/DATS;
   
if [ ! -e /usr/local/McAfee/AntiMalware/ ] 
then 
  echo -e "\nError : Product is not installed\n"; 
  exit 1;
elif [ ! -e /usr/local/McAfee/Antimalware/dats ] 
then 
  `sudo mkdir /usr/local/McAfee/AntiMalware/dats > /dev/null 2>&1`; 
fi;

while [ 1 ]
do 
  echo -e "\nEnter the DAT version to which upgrade needs to be done : ";
  read version;
  if [ -z $version ] 
  then 
    echo -e "\nNot a valid Input...Please re-enter\n";
  else 
    break;  
  fi 
done

if [ ! -e $datpath/$version  ]
then
  echo -e "\nError : Wrong DAT version, DAT '$version' directory not found in '$datpath/'\n";
  exit 1;
fi

var=`ls $datpath/$version/` ; echo $var > temp ; 
grep avvdat-$version.zip temp > /dev/null 2>&1;
 
if [ $? -eq 1 ]
then
  echo -e "\nError : DAT file avvdat-$version.zip not found in '$datpath/$version/'\n";
  cleanup;
  exit 1;
fi

line="";
last="";

`sudo plutil -convert xml1 /Library/Preferences/com.mcafee.ssm.antimalware.plist > /dev/null 2>&1`;

while read line 
do
   `echo $line | grep "Update_DATVersion" > /dev/null 2>&1`;
   if [ $? -eq 0 ] 
   then 
       read line;
       last=`echo $line | cut -c 9-12`; 
   fi;
done < /Library/Preferences/com.mcafee.ssm.antimalware.plist

`sudo plutil -convert binary1 /Library/Preferences/com.mcafee.ssm.antimalware.plist > /dev/null 2>&1`;

if [ $last -eq $version ] 
then 
   echo -e "\nCurrent Product DAT is Up-to-date\n"; 
   exit 1; 
fi

prevdir=$PWD;

cd /usr/local/McAfee/AntiMalware/dats > /dev/null 2>&1;
set -- *;
count=$#;
ind=0;

if [ $count -ge 3 ]
then
   shift;
   ind=2;

   while [ $ind -le `echo $count|bc` ]
   do
     if [ $1 -ne $last ] 
     then  
       rm -rf $1 > /dev/null 2>&1;
     fi 
     ind=`echo $ind+1 | bc`;
     shift;
   done
fi
   
cd $prevdir;

#extract <.dat> files
junk=`sudo /usr/bin/unzip -d $datpath/$version/ $datpath/$version/avvdat-$version.zip`;

if [ ! -e /usr/local/McAfee/AntiMalware/dats/$version ]
then
  `sudo mkdir /usr/local/McAfee/AntiMalware/dats/$version > /dev/null 2>&1`;
fi;

`sudo cp $datpath/$version/avv*.dat /usr/local/McAfee/AntiMalware/dats/$version/ > /dev/null 2>&1`;
`sudo chmod 644 /usr/local/McAfee/AntiMalware/dats/$version/* > /dev/null 2>&1`;
`sudo chmod 755 /usr/local/McAfee/AntiMalware/dats/$version/ > /dev/null 2>&1`;
`sudo plutil -convert xml1 /Library/Preferences/com.mcafee.ssm.antimalware.plist > /dev/null 2>&1`;

#empty the temprory plist file
` > temp.plist`;

while read line 
do
 
   `echo $line | grep "Update_DATVersion" > /dev/null 2>&1`;
 
   if [ $? -eq 0 ] 
   then 
       `echo $line >> temp.plist`;   
       read line; 
       `echo "<string>$version.0000</string>" >> temp.plist`;   
   else 
       `echo $line >> temp.plist`;  
   fi;

done < /Library/Preferences/com.mcafee.ssm.antimalware.plist

`sudo cp temp.plist /Library/Preferences/com.mcafee.ssm.antimalware.plist > /dev/null 2>&1`;
`sudo plutil -convert binary1 /Library/Preferences/com.mcafee.ssm.antimalware.plist > /dev/null 2>&1`;
`sudo launchctl unload /Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist > /dev/null 2>&1`;
sleep 15;
`sudo launchctl load /Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist > /dev/null 2>&1`;
sleep 15;
`sudo /usr/local/McAfee/fmp/bin/fmp restart > /dev/null 2>&1`;

cleanup;


sleep 30; 
