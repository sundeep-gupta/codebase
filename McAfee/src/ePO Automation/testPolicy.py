import logging
import datetime
import string
import sys
import urllib
import os
import time
import urllib2
import ConfigParser
from socket import gethostname
from stat import *

g_strEPOVer = "4.5"

g_strEPOSvr      = "172.16.193.110"
g_strEPOUser     = "admin"
g_strEPOPass     = "nai123"

from EPOFuncs import *
def main():
    res = EPOAssignPolicy("EEMacPro-C2D.local", "My Default", "EEADMIN_1000MACX", "EEADMIN_1000MACX")
    res = EPOAgentWakeup("EEMacPro-C2D.local")

if __name__ == "__main__":
    main()

