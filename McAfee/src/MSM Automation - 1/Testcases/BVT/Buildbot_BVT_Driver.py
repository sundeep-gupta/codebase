#!/usr/bin/python
# Copyright (C) 2009 McAfee, Inc.  All rights reserved.
import subprocess
import sys
import os
import re
import time
scriptDir   = os.path.dirname(os.path.abspath(sys.argv[0]))
askpass     = scriptDir + '/passwd'
build_dir   = scriptDir + "/builds"
bvtoutput   = scriptDir + "/bvtoutput"
logdir      = scriptDir + "/../Logs"
testcaseDir = scriptDir + "/../../Testcases"
testAutomationDir = testcaseDir + "/.."
tmpfile     = logdir + "/Buildbot_BVT_Driver.log"
product     = 'MSC'
result_file = "<Product>.<BuildNum>.<PackNum>.RES"
unzip_cmd   = 'unzip'
archive     = product + '.zip'
_regex      = "===RESULT:(.*):(.*)$"
_regex_zip  = product + "\.(\d+)\.(.*)\.zip"
description = "Running scripts in snowleopard machine"
username    = 'svcacct-maclnx'
password    = 'eT9Di@5Fz;)2OeRh'
suites      = []
uri         = "TestAutomation/Testcases"
url         = "https://bngsvn/srcRepo/TOPS"
bvtresult   = "PASS"

def get_details() :
    _operating = ""
    _arch = ""
    _p = subprocess.Popen(["sw_vers"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    _p.wait();
    lines = _p.stdout.readlines()
    for line in lines :
        _m = re.search("ProductVersion.*10\.(\d)\.\d", line)
        if _m is not None:
            if _m.group(1) == "5" :
                _operating = "Leopard" 
            elif _m.group(1) == "6":
                _operating = "Snow Leopard"
            else :
                _operating = "Unsupported OS Version : " + _m.group(1)
    _p = subprocess.Popen(["uname", "-m"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    _p.wait()
    _lines = _p.stdout.read()
    if re.search("Power", _lines) is not None:
        _arch = "Power PPC"
    elif re.search("i386", _lines) is not None:
        _arch = "Intel - 32 bit"
    else :
        _arch = "Intel 64 bit"
    return "Running scripts on " + _operating + " - " + _arch

# Extract the archive and skip if it fails
def _cleanup(exit = True):
    # Remove all the files in the build directory
    os.chdir(scriptDir)
    list = os.listdir(build_dir)
    for file in list :
        if file not in ['.svn', product +'.zip' ]:
            print "Deleting %s" % file
            subprocess.call(['rm', '-rf', build_dir + '/' + file])

    # Remove the tmp directory if present.
    if os.path.exists(testAutomationDir + "/tmp") :
        subprocess.call(["rm", "-rf", testAutomationDir + "/tmp"])

    if exit :
        sys.exit(0)
    return 0

def get_builds() :
    global url
    global build_dir
    global result_file
    # Go to the buid directory where <product>.zip is available
    os.chdir(build_dir)
    print "Extracting archive to get the dmg files."
    sys.stdout.flush()
    # Unzip the first level of zip to get <product>.<build>.zip
    retval = subprocess.call([unzip_cmd, archive])            
    if retval != 0:
        print "Failed to extract the archive\n"
        _cleanup();

    # Read the directory to see if there is another zip file
    files = os.listdir(build_dir)
    build = ""
    for file in files :
        _m = re.search(_regex_zip, file)
        if _m is not None :
            build = _m.group(1)
            branch = _m.group(2)
            if (branch == "HEAD") :
                url = url + "/trunk"
            else :
                url = url + "/branches/" + branch
            result_file = product + '.' + build + '.RES'
            break
    else :
        print "There was no file with the template that match %s" % _regex_zip
        _cleanup();

    # Now second level of unzipping
    new_archive = product + '.' + build + '.' + branch + '.zip'
    print "Extracting %s" % new_archive
    sys.stdout.flush()
    retval = subprocess.call([unzip_cmd, new_archive])
    if retval != 0 :
        print "Failed to extract the archive"
        _cleanup()

    # If extaction is successful, then get the dmg files in the directory
    print "Now looking the dmg files for installation."
    sys.stdout.flush()
    files = os.listdir(build_dir)
    suites = []
    for file in files :
        print file
        if re.search('\.dmg$', file) is not None :
            suites.append({
                    'name': file,
                    'path': os.path.abspath(file)})

    return suites

def checkout() :
    # Go to the test automation dir and remove the testcases directory
    os.chdir(testAutomationDir)
    print "Performing svn co";
    retval = subprocess.call(["rm", "-rf", testcaseDir])
    if retval != 0 :
        print "Failed to remove the directory"
        sys.exit(1)
    # Now check out the testcases directory with the branchname obtained.
    retval = subprocess.call(["svn", "co", "--username" , username , "--password", password, url + "/" + uri, testcaseDir],
            stdout=subprocess.PIPE)
    if retval != 0 :
        print "Failed to checkout"
        sys.exit(1)
    # Change back to script directory.
    os.chdir(scriptDir)
    print "Changing permission of AppProtection/data"
    subprocess.call(["chmod", "-R", "755", testcaseDir+"/AppProtection/data"])
    return 0


def run_suite(suite, fh_tmp) :
    global bvtresult
    try:
        os.chdir(scriptDir)
        print ("Running BVT for %s" % suite['name'])
        sys.stdout.flush()
        fh_tmp.write("===DESC:Running BVT for %s\n" % suite['name'])
        cmd = ['python', 'BVTDriver.py', '--loglevel=debug','--install=' + suite['path']]
        
        # Check if it is antimalware only package
        if re.search('Anti-malware', suite['name']):
            print "Running with --av_only option."
            cmd.append('--av_only')
        retval = subprocess.call(cmd)
        
        # If BVT script fails, we simply skip it to next step.
        if retval != 0 :
            print "Test %s returned %d." % (suite['name'], retval)
    except:
        print "Exception occured while running %s" % suite['name']

    print "Reading the script's log file to parse result."
    sys.stdout.flush()
    fh_bvt = open("../Logs/BVTDriver.log",'r')
    _lines = fh_bvt.readlines()
    fh_bvt.close()

    for _line in _lines :
        _line.rstrip("\n")
        _match = re.search(_regex, _line)
        if _match is not None:
            _tc_desc = _match.group(1)
            _tc_res = _match.group(2)
            if _tc_res == "FAIL" :
                bvtresult = "FAIL"
            fh_tmp.write("===RESULT:%s:%s\n" %(_tc_desc, _tc_res))
    # Copy all logs to bvtoutput location.
    # print "Copying the Logs to " + bvtoutput + "/" + suite['name']
    # os.mkdir(bvtoutput + "/" + suite['name'], 0777)
    # subprocess.call(["mv", logdir + "/", bvtoutput + "/" + suite['name']])

    return 0

def update() :
    os.chdir(testAutomationDir)
    print "Running svn update to update the scripts\n"
    sys.stdout.flush()
    retval = subprocess.call(['svn','update', '--username', username, '--password', password])
    os.chdir(scriptDir)
    return 0

#########################
# MAIN CODE STARTS HERE
#########################
os.unsetenv("TMPDIR")
descr  = get_details()
suites = get_builds()

#########################################################################################
# THIS CODE IS COMMENTED NOW AS WITH THESE CHANGES BUILDBOT OUTPUT IS HANG [ NO OUTPUT ]
# For now Proceeding with the previous option of doing 'svn update'
#
######################################################################################### 
# Save the zip file created by buildbot to some temporary location.
#if os.path.exists(testAutomationDir + "/tmp") :
#    subprocess.call(["rm", "-rf", testAutomationDir + "/tmp"])
#
#os.mkdir(testAutomationDir + "/tmp")
#time.sleep(5)
#subprocess.call([ "mv", build_dir + "/", testAutomationDir + "/tmp"])

## Perform an svn checkout    
#checkout()

## Now move back the file from temporary location to buildbot directory.
#subprocess.call(["rm", "-rf", build_dir])
#os.rename(testAutomationDir + "/tmp/builds", scriptDir + "/builds")
#######################################################################################

# Perform svn update.
# NOTE: Remove this code once the 'svn co' [above] part is working good.
update()

# Now we have the latest test scripts and the dmg with us. Run the tests on each dmg.
fh_tmp = open(tmpfile, 'w')
fh_tmp.write("===DESC:%s\n" % descr)
for suite in suites :
    run_suite(suite, fh_tmp)
fh_tmp.write("===RESULT:BVT Result:"+ bvtresult)
fh_tmp.close()

print "Performing cleanup."
_cleanup(False)
    
# Move to RES file.
print "Moving the result file to actual location."
if os.rename(tmpfile, bvtoutput + '/' + result_file) == 0 :
    print "Failed to copy the file to res file\n"
else :
    print "Script completed successfully."


