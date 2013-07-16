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
def getValidDMGPath(urlName, buildNum, flavour) :
    Fullsuite_url_Nightly = "http://192.168.215.135/Builds/Nightly Builds/MSC/" + "McAfee%20Security%20for%20Mac-1.0-RTW-" + buildNum + ".dmg" 
    AVOnly_url_Nightly = "http://192.168.215.135/Builds/Nightly Builds/MSC/" + "McAfee%20Security%20for%20Mac-Anti-malware-1.0-RTW-" +  buildNum + ".dmg"
    if flavour == 'Suite-BVT' :
        try:
            _fileOnWeb = urllib2.urlopen(urlName)
            return urlName
        except :
            return Fullsuite_url_Nightly
    else:
        try:
            _fileOnWeb = urllib2.urlopen(urlName)
            return urlName
        except:
            return AVOnly_url_Nightly

# Perform the test and populate the results...
def performTest() :

    _product = 'MSC'
    _buildDetails = []
    _fullSuiteRetVal = 'FAIL'
    _antiMalwareRetVal = 'FAIL'

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
    _tmpLogFilePtr.write("===DESC:Running Suite BVT for build : " + _buildNum + "\n")

    print " ====== Running Suite BVT for build : " + _buildNum + " ========" 
    sys.stdout.flush()

    # Max. iterations to try = 3 in case of harness Server crashes...
    _iterCnt = 0
    _runCntMax = 3

    while _iterCnt != _runCntMax :

        try:
            # Suite Type is BVT
            _suiteType = '1'

            # Installer dmg URL...
            _testURL = "http://192.168.215.135/Builds/TOPS/MSC/" + _buildNum + "/McAfee%20Security%20for%20Mac-1.0-RTW-" + _buildNum + ".dmg"
            _testURL = getValidDMGPath(_testURL, _buildNum, 'Suite-BVT')
            _testSuiteName = 'Suite-BVT'

            # Now, run the suite with above inputs...
            _retVal = CommonBuildbotFns.runSuite(_suiteType, _testURL, _buildNum, _testSuiteName, _svnURL)

            # If BVT script fails, try another time...
            if _retVal != 0 :
                print "Test for Suite BVT returned %d." % (_retVal)
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
        _outputZipFile = "Suite-BVT-" + _buildNum + "-logs.zip"
        CommonBuildbotFns.uploadOutputFiles(_runPath, _outputZipFile)

        # runSuite output file is ready for reading...
        _fullSuiteRetVal = CommonBuildbotFns.readOutputFile(_runPath, _tmpLogFilePtr)
        break

    _tmpLogFilePtr.write("\n\n===DESC:Running Anti-malware BVT for build : " + _buildNum + "\n")

    print " ====== Running Anti-malware BVT for build : " + _buildNum + " ========" 
    sys.stdout.flush()

    # Now, perform AntiMalware BVT processing...
    _iterCnt = 0
    while _iterCnt != _runCntMax :

        try:
            # Suite Type is BVT
            _suiteType = '1'

            # Installer DMG URL...
            _testURL = "http://192.168.215.135/Builds/TOPS/MSC/" + _buildNum + "/McAfee%20Security%20for%20Mac-Anti-malware-1.0-RTW-" + _buildNum + ".dmg"
            _testURL = getValidDMGPath(_testURL, _buildNum, 'AntiMalware-BVT')
            _testSuiteName = 'AntiMalware-BVT'

            # Now, run the suite with above inputs...
            _retVal = CommonBuildbotFns.runSuite(_suiteType, _testURL, _buildNum, _testSuiteName, _svnURL)

            # If BVT script fails, try another time...
            if _retVal != 0 :
                print "Test for Anti-malware BVT returned %d." % (_retVal)
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
        _outputZipFile = "AntiMalware-BVT-" + _buildNum + "-logs.zip"
        CommonBuildbotFns.uploadOutputFiles(_runPath, _outputZipFile)

        # runSuite output file is ready for reading...
        _antiMalwareRetVal = CommonBuildbotFns.readOutputFile(_runPath, _tmpLogFilePtr)

        if _fullSuiteRetVal == 'PASS' and _antiMalwareRetVal == 'PASS' :
            _tmpLogFilePtr.write("\n===RESULT:ABVT_RESULT:PASS\n")
        else :
            _tmpLogFilePtr.write("\n===RESULT:ABVT_RESULT:FAIL\n")
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
