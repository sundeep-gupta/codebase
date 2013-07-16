#!/bin/sh
# ##################################################################
# A shell Script to load network volumes 			   
# Copyright-McAfee Software Pvt Ltd				   
# Date : 17-Apr-2007
# Written By: Anand pandit
# ##################################################################  




echo '\n\n\n'
echo "ENTER YOUR OPTION TO MOUNT WHICH VOLUME ON HOGWARTS OR SMB SHARE"
echo '\n\n'
echo "1.FTProot\n"
echo "2.Users\n"
echo "3.Mac\n"
echo "4.NetBootClients1\n"
echo "5.OS_images\n"
echo "6.NetbootSP1\n"
echo "7.SMB/McAfee/Virex(192.168.215.112)\n"


echo "Enter your options from 1-7 to mount the selected volume\n"
read num

case $num in

"1") echo "YOU HAVE SELECTED OPTION 1 TO MOUNT FTProot\n"
   echo "Mounting FTProot \n"
   echo "\n\n\n Creating Mount point as FTProot\n"
   mkdir /Volumes/FTProot
   mount_afp volume "afp://mac:Sat1n@172.16.222.23:548/FTProot" /Volumes/FTProot
   echo "Mounted volume FTProot....\n";;

"2") echo "YOU HAVE SELECTED OPTION 2 TO MOUNT Users\n"
   echo "Mounting Users \n"
   echo "\n\n\n Creating Mount point as Users\n"
   mkdir /Volumes/Users
   mount_afp volume "afp://mac:Sat1n@172.16.222.23:548/Users" /Volumes/Users
   echo "Mounted volume Users....\n";;

"3") echo "YOU HAVE SELECTED OPTION 3 TO MOUNT Mac\n"
   echo "Mounting volume Mac \n"
   echo "\n\n\n Creating Mount point as Mac\n"
   mkdir /Volumes/Mac
   mount_afp volume "afp://mac:Sat1n@172.16.222.23:548/Mac" /Volumes/Mac
   echo "Mounted volume mac....\n";;

"4") echo "YOU HAVE SELECTED OPTION 4 TO MOUNT VOLUME : NetBootClients1\n"
   echo "Mounting NetBootClients1 \n"
   echo "\n\n\n Creating Mount point as NetBootClients\n"
   mkdir /Volumes/NetBootClients1
   mount_afp volume "afp://mac:Sat1n@172.16.222.23:548/NetBootClients1" /Volumes/NetBootClients1
   echo "Mounted volume : NetBootClients1....\n";;

"5") echo "YOU HAVE SELECTED OPTION 5 TO MOUNT VOLUME : OS_images\n";
   echo "Mounting OS_images \n"
   echo "\n\n\n Creating Mount point as OS_images\n"
   mkdir /Volumes/OS_images
   mount_afp volume "afp://mac:Sat1n@172.16.222.23:548/OS_images" /Volumes/OS_images
   echo "Mounted volume OS_images....\n";;

"6") echo "YOU HAVE SELECTED OPTION 6 TO MOUNT VOLUME: NetBootSP1\n"
   echo "Mounting NetBootSP1 \n"
   echo "\n\n\n Creating Mount point as NetBootSP1\n"
   mkdir /Volumes/NetBootSP1
   mount_afp volume "afp://mac:Sat1n@172.16.222.23:548/NetBootSP1" /Volumes/NetBootSP1
   echo "Mounted volume : NetBootSP1....\n";;

"7") echo "YOU HAVE SELECTED OPTION 7 TO MOUNT VOLUME: SMB://192.168.215.112/McAfee\n"
   echo "Mounting SMB://192.168.215.112/McAfee\n"
   echo "\n\n\n Creating Mount point as SMB://192.168.215.112/McAfee\n"
   mkdir /Volumes/McAfee
   mount -t smbfs //naibec:naibec@192.168.215.112/McAfee /Volumes/McAfee/
   echo "Mounted volume : McAfee....\n";;



*) echo "Invalid Selection\n Select in the range of 1-7"
esac
