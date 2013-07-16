#!/bin/bash
# Copyright (C) 2009, McAfee Inc. All rights reserved.
sudo mkdir /usr/local/McAfee/fmp/config/FirewallTestTool
sudo mv FirewallTestToolFMConfig.xml /usr/local/McAfee/fmp/config/FirewallTestTool/FMConfig.xml
sudo chown root:wheel /usr/local/McAfee/fmp/config/FirewallTestTool/FMConfig.xml
sudo chmod 700 /usr/local/McAfee/fmp/config/FirewallTestTool/FMConfig.xml

sudo /usr/local/McAfee/fmp/bin/fmp reload
