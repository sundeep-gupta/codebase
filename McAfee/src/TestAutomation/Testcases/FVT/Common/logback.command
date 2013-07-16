#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc. All rights reserved
"""
Please enter the username and passwd for the current user before running the Driver script
"""
import commonFns
import subprocess
import logging
import time

try:
    Cmd = "open " + "/Applications/Safari.app" 
    retval = subprocess.call(Cmd, shell=True)
    if(retval != 0):
        loggin.error("Unable to launch Safari")
except:
    logging.error("Exception occured in launching Safari")

time.sleep(3)

if commonFns.removeLoginItem() == False:
    logging.error("Error occured while removing the login Item")

time.sleep(5)
try:
    Cmd = "osascript -e 'tell application \"System Events\" to log out'"
    retval = subprocess.call(Cmd, shell=True)
    if(retval != 0):
        loggin.error("Unable to logOut")
except:
    logging.error("Exception occured in logOut")

time.sleep(3)
commonFns.fastUserSwitching("","")
