#!/bin/sh

#################################################################
#
# VirusScan for Mac Performance Test Kick-off script
# Copyright (c) 2006 - 2007 McAfee, Inc. All Rights Reserved.
# Author - Sanjeev Gupta
# Contibutory Authors - Harish Garg, <add here>
# These performance scripts will work only with product version 8.6
################################################################
# get the directory for the current script
ScriptPath=`dirname $0`

# cd to the directry for the current script
cd $ScriptPath

# Print directory
pwd

#open scriptsafety.command

# Start performance scripts
perl perf-main.pl



