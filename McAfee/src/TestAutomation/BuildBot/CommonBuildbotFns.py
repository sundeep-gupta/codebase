#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.

import subprocess
import sys
import os
import re
import time
import signal
import stat
import random

scriptDir		=  os.path.dirname(os.path.abspath(sys.argv[0]))
tafCLIDir		=  "/usr/local/TAF/bin/" 
buildsDir		=  scriptDir + "/builds"
bvtOutputDir    =  scriptDir + "/bvtoutput"
machinesListFile = scriptDir + "/machinesList.txt"

regexProductZipFile	=  "\.(\d+)\.(.*)\.(-{0,1}\d+).zip"
runPath		=  ''
serverPortNum	=  '9000'

# Perform initialization before actual buildbot script run...
def performInit(product) :
    try:
        os.unsetenv("TMPDIR")
        _cmd = "rm -fr " + bvtOutputDir + "/*.*"
        _retVal = subprocess.call(["/bin/sh", "-c", _cmd], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        _list = os.listdir(buildsDir)
        _zipFileName = product + ".zip"
        for _file in _list :
            # Do not remove the zip file since this came just from the buildbot...
            if _file != _zipFileName :
                os.remove(buildsDir + '/' + _file)

    except:
        print "Exception occurred while performing remove operation"
        _cleanup()

# Get server IP address
# socket.gethostbyname() will return the localhost 
# Hence had to do this circus...
def getServerIPAddress() :
    try:
        _cmd = "ifconfig | grep inet | awk '{print $2}' | grep 172."
        _proc = subprocess.Popen(_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        _output = _proc.communicate()[0]
	_output = _output.strip('\n')
        return _output

    except:
        print "Exception occurred in getting IP address."
        _cleanup()

# Perform cleanup with exit option...
def _cleanup(exit = True):

    try:
        # Remove all the files in the build directory
        _list = os.listdir(buildsDir)
        for _file in _list :
            os.remove(buildsDir + '/' + _file)

        # Change the permission for each file in bvtoutput dir to 777 for buildbot
        # uploading...
        os.chdir(bvtOutputDir)
        _bvtList = os.listdir(bvtOutputDir)
        for _bvtFile in _bvtList :
            os.chmod(_bvtFile, 0777)
        
        if exit :
            sys.exit(0)
            
        return 0

    except:
        print "Exception occurred in _cleanup function"

# Get the build number, branch name, svn URL and req ID from the FILE name 
def getBuildDetails(product) :

    try:
        # Go to the buid directory where <product>.zip is available
        os.chdir(buildsDir)
        sys.stdout.flush()

        _zipFileName = product + ".zip"

        # Unzip the first level of zip to get <product>.<build>.zip
        _unzipRetVal = subprocess.call(['unzip', _zipFileName])            
        if _unzipRetVal != 0:
            print "Failed to extract the archive\n"
            _cleanup()

        _retVal = []
            
        # Read the directory to see if there is another zip file
        _files = os.listdir(buildsDir)

        for _file in _files :
            _m = re.search(product + regexProductZipFile, _file)
            if _m is not None :
                _build = _m.group(1)
                _branch = _m.group(2)
                _reqId = _m.group(3)

                if (_branch == 'HEAD') :
                    _svnUrl = "https://bngsvn/srcRepo/TOPS/trunk"
                else :
                    _svnUrl = "https://bngsvn/srcRepo/TOPS/branches/" + _branch
                    
                _retVal.append(_build)
                _retVal.append(_branch)
                _retVal.append(_svnUrl)
                _retVal.append(_reqId)
                break

        else :
            print "There was no file with the template that match %s" % (product + regexProductZipFile)
            _cleanup()

        return _retVal

    except:
        print "Exception occurred in getBuildDetails function"
        _cleanup()

# Add the host names specified in the machinesList.txt and check whether
# all the host names are added...  Return the host names if successful...
def getHostNames() :
    try:
        _hostNames = ''
        os.chdir(tafCLIDir)

        # Read the machinesList.txt where the hosts data are provided by the user...
        _machinesListFile = scriptDir + "/machinesList.txt"

        _mcFileH = open(_machinesListFile, 'r')
        # Store the machine host names for later processing...
        _mcHostsList = list()

        while True:
            # For each line entry, process the line and add the client host...
            _data = _mcFileH.readline()
            if not _data:
                break

            _m = re.search("(.*):(.*):(.*):(.*):(.*)", _data)
            if _m is not None:
                _hostName = _m.group(1)

                if _hostName == '#HostName' :
                    continue

                _hostIp = _m.group(2)
                _osName = _m.group(3)
                _osVersion = _m.group(4)
                _nodeType = _m.group(5)

                _mcHostsList.append(_hostName)

                _cmd = ['./harnessCLI', '1', getServerIPAddress(), serverPortNum, _hostName, _hostIp, _osName, _osVersion, _nodeType]
                _proc = subprocess.Popen(_cmd, stdout=subprocess.PIPE, stdin=subprocess.PIPE)
		_output = _proc.communicate()[0]

        _mcFileH.close()

        # Now, check whether all the host names are successfully added (or already added)... If any node is missing, return empty...
        _cmd = ['./harnessCLI', '3', getServerIPAddress(), serverPortNum]
        _proc = subprocess.Popen(_cmd,  stdout=subprocess.PIPE, stdin=subprocess.PIPE)

        _output = _proc.communicate()[0]

        _lines = _output.split('\n')

        for _mcHostName in _mcHostsList :
            _foundHost = False

            for _line in _lines:
                _m = re.search(_mcHostName, _line)
                if _m is not None:
                    _foundHost = True
                    break

            if _foundHost == False:
                print "Hostname : " + _mcHostName + " not found in TAF clients list..."
                _cleanup()

        for _mcHostName in _mcHostsList :
            if _hostNames is not '':
                _hostNames = _hostNames + ',' + _mcHostName
            else:
                _hostNames = _mcHostName
            
    except:
        print "Exception occurred in getting hostNames"
        _cleanup()

    return _hostNames

# Get a valid run ID and construct a path for the ResultSummary.log
def getRunPath() :
    try:
        runIdFilePtr = open(tafCLIDir + "../var/runId", 'r')
        runId = runIdFilePtr.readlines()
        # runId is of type list so get the first item
        runIdStr = runId[0]
    except IOError:
        print "Exception occurred in open read at path :" + tafCLIDir + "../var/runId" 
        _cleanup()
    finally:
        runIdFilePtr.close()
		
    return tafCLIDir + '../var/Run_' + runIdStr

# Get the status of the Run and register 
# for a signal handler to come out if harnessCLI
# will not return for unknown reasons.
class TimeoutException(Exception): 
    pass 

def getRunStatus(runPath) :
    def timeout_handler(signum, frame):
        raise TimeoutException()
    old_handler = signal.signal(signal.SIGALRM, timeout_handler)
    signal.alarm(20)

    os.chdir(tafCLIDir)

    try:
        # Get the status of the run Id.
        print "*** Check for the Run Status ***"
        _cmd = ['./harnessCLI', '6', getServerIPAddress(), serverPortNum]
        _proc = subprocess.Popen(_cmd, stdout=subprocess.PIPE, stdin=subprocess.PIPE)
        _output = _proc.communicate()[0]

        _m = re.search("RunID=(.*)\sStatus=(.*)", _output)
		
        if _m is not None :

            # Get the current runID and check the status corresponding to this runID...
            _n = re.search(".*_(\d+)", runPath)

            # Current runID do not exist in the harnessCLI run status.  This means the run
            # is over and so, return 0...
            if _n is None :
                return 0

            # Get the current runID for comparison later...
            _runId = _n.group(1)

            # If runID is same as the one in the harnessCLI status, return the status...
            if _runId == _m.group(1) :
                return _m.group(2)

            return 0
        else:
            print "*** Run is finished *** "
            return 0
    except TimeoutException:
        print 'Exception occurred in getting the run status'
        return "No Runs"
    finally:
        signal.alarm(0)

# BuildBotDriver script would wait for the TAF Server to 
# get the Result from the TAF client machines and write 
# in ResultSummary.log
def sleepAndWakeUp(runPath) :
    try:
        while (getRunStatus(runPath) == 'Running' ):
            print "Waiting for result"
            # Attempting to put random sleep to handle multiple TAF requests
            # at the same time via multiple buildbot requests...
            time.sleep(random.randint(5,20))
            sys.stdout.flush()

        print "*** There are no runs... Check for the logs. ***"

    except:
        print "Exception occurred in sleepAndWakeup function"


# Check whether the ResultSummary.log exists or not
def outputFileExists(runPath) :
    try:
        return os.path.exists(runPath + "/ResultSummary.log")
    except:
        print "Exception occurred in outputFileExists function"
        return False

# Read the ResultSummary.log and convert the log
# file into a format required by the BUIDLBOT.
# Return overall test result...
def readOutputFile(runPath, outputResFilePtr) :
    time.sleep(3)
    _summaryRetVal = 'PASS'
    
    # Atleast one testcase should pass to mark the final result as PASS.  This will
    # ensure that processing of file with no useful data will result in FAIL...
    _foundPassTestcase = False
    sys.stdout.flush()
	
    try:
        _resFilePtr = open(runPath + "/ResultSummary.log", 'r')
        _lines = _resFilePtr.readlines()
    except IOError:
        print "Got exception in Open and Reading of file"
        return 'FAIL'
    finally:
        _resFilePtr.close()

    try:    
        _hostTestcaseResultMap = dict()
        _hostTestcaseList = dict()

        _regexMc = '^\s+:+\s+Test\s+Results\s+For\s+Host\s+:\s+(.*)\s+:+'
        _regexRes = '^\s+Testcase\s+Name\s+:\s+(.*)\s+Result\s+:\s+(.*)'
        _current = None

        for _line in _lines :
            _m = re.search(_regexMc, _line)
            if _m :
                _hostTestcaseResultMap[_m.group(1)] = dict()
                _hostTestcaseList[_m.group(1)] = list()
                _current = _m.group(1)
            else :
                _m = re.search(_regexRes, _line)
                if _m and _current :
                    _hostTestcaseResultMap[_current][_m.group(1)] = _m.group(2)
                    _hostTestcaseList[_current].append(_m.group(1))
    except:
        print "Exception occurred in reading result to Dict()"
        _cleanup()
        
    try:
        for _mc in _hostTestcaseResultMap.keys() :
            outputResFilePtr.write("\n===RESULT FOR MACHINE: %s\n" %_mc)
            for _tc in _hostTestcaseList[_mc] :
                outputResFilePtr.write("===RESULT: %s:%s\n" %(_tc, _hostTestcaseResultMap[_mc][_tc]))
                if _hostTestcaseResultMap[_mc][_tc] == "FAILED" :
                    _summaryRetVal = "FAIL"
                else :
                    if _hostTestcaseResultMap[_mc][_tc] == "PASSED" :
                        _foundPassTestcase = True
    except:
        print 'Exception occurred in Regex match and write to file'
        _cleanup()
	
    if _foundPassTestcase == True :
        return _summaryRetVal
    else :
        return 'FAIL'

# Get Node status.
# If nodes are busy, return 1 else return 0
def getNodeStatus() :
    try:
        os.chdir(tafCLIDir)

        _cmd = "./harnessCLI 3 " + getServerIPAddress() + " " + serverPortNum
        _proc = subprocess.Popen(_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        _retVal = _proc.communicate()[0]
        _statusVal = re.search("Busy", _retVal)

        if _statusVal is not None:
            return 1
        else :
            return 0
    except:
        print "Exception occurred in getNodeStatus"
        # Some exception occurred, no point in caller waiting for free node...
        return 0

# Trigger harnessCLI test command to perform suite test with given inputs...
def runSuite(suiteType, testURL, buildNum, testSuiteName, svnURL) :

    try:
        _hostNames = getHostNames()

        if _hostNames == '':
            return 1

        # Store old run path for later checking...
        _oldRunPath = getRunPath()
    
        # Wait for the nodes to become free...
        _retVal = getNodeStatus()
        while _retVal != 0 :
            print "*** Check for the Node Status ***"
            print "Waiting for the nodes to become FREE"
            # Attempting to put random sleep to handle multiple TAF requests
            # at the same time via multiple buildbot requests...
            time.sleep(random.randint(5,20))
            _retVal = getNodeStatus()
            sys.stdout.flush()

        os.chdir(tafCLIDir)

        _cmd = [ './harnessCLI', '4', getServerIPAddress(), serverPortNum, _hostNames, suiteType, testURL, buildNum, testSuiteName, svnURL, 'mail_id', '1' ]
        _retVal = subprocess.call(_cmd)

        # Now, get the current run path...
        _runPath = getRunPath()

        # If the above harnessCLI command is successful, the runPath should change.  If runPath is same, then the command
        # is not successful and so return false...
        if _oldRunPath == _runPath :
            print "harnessCLI not executed successfully..."
            return 1
        
        return _retVal
    
    except:
        print "Exception occurred while executing cmd in runSuite"
        return 1


# Upload all the logs zipped into the bvtoutput folder so that it will be uploaded to the buildbot page...
def uploadOutputFiles(runPath, zipFileName) :

    try:
        # Once TAF command is successful, the log files will be outputted in the runPath folder...
        # Create a zip file from all the files in the runPath folder...
        os.chdir(runPath)

        _cmd = "zip -r " + bvtOutputDir + '/' + zipFileName + " *"
        _proc = subprocess.Popen(_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        _output = _proc.communicate()[0]
        
    except:
        print "Exception occured in uploadOutputFiles..."
