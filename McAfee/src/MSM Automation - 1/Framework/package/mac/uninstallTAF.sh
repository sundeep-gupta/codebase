#!/bin/bash
# Copyright (C) 2010 McAfee, Inc. All rights reserved
if [ -f /Library/LaunchDaemons/com.mcafee.taf.harnessserver.plist ]
then
sudo launchctl unload /Library/LaunchDaemons/com.mcafee.taf.harnessserver.plist
sudo rm /Library/LaunchDaemons/com.mcafee.taf.harnessserver.plist
fi
sudo launchctl unload /Library/LaunchDaemons/com.mcafee.taf.staf.plist
sudo rm /Library/LaunchDaemons/com.mcafee.taf.staf.plist
sudo /usr/local/TAF/STAF/STAFUninst
sudo rm -rf /usr/local/TAF
sudo rm -rf /Library/staf
sudo rm -rf /Library/Receipts/TAF-Client-*.pkg
sudo rm -rf /Library/Receipts/TAF-Server-*.pkg
echo "TestAutomationFramework uninstalled. "
