#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.

import sys
import os
import time
import urllib2
import CommonBuildbotFns

scriptDir   = os.path.dirname(os.path.abspath(sys.argv[0]))
outputDir   = scriptDir + "/bvtoutput"

# Get a valid URL path since we need to to take
# care of the Nightly build as well, which would be sent 
# as a parameter to Install.py script.
# NOTE :- %20 is required for spaces since urllib2.urlopen() would
# throw an exception.
def getValidDMGPath(urlName, buildNum) :
    _urlNightly = "http://192.168.215.135/Builds/Nightly Builds/MSC/" + "McAfee%20Security%20for%20Mac-1.0-RTW-" + buildNum + ".dmg" 
    try:
        _fileOnWeb = urllib2.urlopen(urlName)
        return urlName
    except :
        return _urlNightly

# Perform the test and populate the results...
def performTest() :

    _product = 'MSC'
    _buildDetails = []

    try:
        # Perform initialization...
        CommonBuildbotFns.performInit(_product)

        _buildDetails = CommonBuildbotFns.getBuildDetails(_product)

        if _buildDetails == [] :
            print "Error getting build details..."
            CommonBuildbotFns._cleanup()
    except:
        print "Exception occured during getBuildDetails processing..."
        CommonBuildbotFns._cleanup()

    # Store all the buildDetails values into the specific variables...
    _buildNum = _buildDetails[0]
    _branchName = _buildDetails[1]
    _svnURL = _buildDetails[2]
    _reqId = _buildDetails[3]

    # Generate a .RES file with above info and this is the file that will be picked by buildbot...
    _resultFile = outputDir + '/' + _product + '.' + _buildNum + '.' + _branchName + '.' + _reqId + '.RES'
    _tmpResFile = outputDir + '/' + _product + '.' + _buildNum + '.' + _branchName + '.' + _reqId + '.TMP'

    _tmpLogFilePtr = open(_tmpResFile, 'w')
    _tmpLogFilePtr.write("===DESC:Running FVT for build : " + _buildNum + "\n")

    print " ====== Running FVT for build : " + _buildNum + " ========" 
    sys.stdout.flush()

    # Max. iterations to try = 3 in case of harness Server crashes...
    _iterCnt = 0
    _runCntMax = 3

    while _iterCnt != _runCntMax :

        try:
            # Suite Type is FVT
            _suiteType = '2'

            # Installer DMG URL...
            _testURL = "http://192.168.215.135/Builds/TOPS/MSC/" + _buildNum + "/McAfee%20Security%20for%20Mac-1.0-RTW-" + _buildNum + ".dmg"
            _testURL = getValidDMGPath(_testURL, _buildNum)
            _testSuiteName = 'Suite-FVT'

            # Now, run the suite with above inputs...
            _retVal = CommonBuildbotFns.runSuite(_suiteType, _testURL, _buildNum, _testSuiteName, _svnURL)

            # If FVT script fails, try another time...
            if _retVal != 0 :
                print "Test for FVT returned %d." % (_retVal)
                _iterCnt = _iterCnt + 1
                time.sleep(5)
                continue
            
        except :
            print "Exception occured during runSuite processing..."
            _iterCnt = _iterCnt + 1
            time.sleep(5)
            continue

        # Now, get the current run path...
        _runPath = CommonBuildbotFns.getRunPath()

        # Wait for completion of the run...
        CommonBuildbotFns.sleepAndWakeUp(_runPath)    

        time.sleep(2)

        # If output result file due to above command is not generated, lets try more iterations...
        if CommonBuildbotFns.outputFileExists(_runPath) == False:
            _iterCnt = _iterCnt + 1
            time.sleep(5)
            continue
        
        # Processing done, upload the files zipped to the output folder...
        _outputZipFile = "MSC-FVT-" + _buildNum + "-logs.zip"
        CommonBuildbotFns.uploadOutputFiles(_runPath, _outputZipFile)

        # runSuite output file is ready for reading...
        _retVal = CommonBuildbotFns.readOutputFile(_runPath, _tmpLogFilePtr)

        _tmpLogFilePtr.write("\n===RESULT:FVT_RESULT:"+ _retVal + "\n")
        _tmpLogFilePtr.close()

        # Now, rename the temporary file as RES file for upload trigger from buildbot...
        os.rename(_tmpResFile, _resultFile)

        CommonBuildbotFns._cleanup(False)
        break

    return 0

#########################
# MAIN CODE STARTS HERE
#########################

performTest() 
