#!/usr/bin/python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.

import sys
import os
import time
import CommonBuildbotFns

scriptDir   = os.path.dirname(os.path.abspath(sys.argv[0]))
outputDir   = scriptDir + "/bvtoutput"

# Perform the test and populate the results...
def performTest() :

    _product = 'APPPROTECTION'
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
    _tmpLogFilePtr.write("===DESC:Running AppProtection UT for build : " + _buildNum + "\n")

    print " ====== Running AppProtection UT for build : " + _buildNum + " ========" 
    sys.stdout.flush()

    # Max. iterations to try = 3 in case of harness Server crashes...
    _iterCnt = 0
    _runCntMax = 3

    while _iterCnt != _runCntMax :

        try:
            # Suite Type is UT
            _suiteType = '0'

            # tar.gz URL where the UT binaries are available...
            _testURL = "http://192.168.215.135/Builds/TOPS/APPPROTECTION/" + _buildNum + "/AppProtection-UT-" + _buildNum + ".tar.gz"
            _testSuiteName = 'AppProtection-UT'

            # Now, run the suite with above inputs...
            _retVal = CommonBuildbotFns.runSuite(_suiteType, _testURL, _buildNum, _testSuiteName, _svnURL)

            # If UT script fails, try another time...
            if _retVal != 0 :
                print "Test for AppProtection UT returned %d." % (_retVal)
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
        _outputZipFile = "AppProtection-UT-" + _buildNum + "-logs.zip"
        CommonBuildbotFns.uploadOutputFiles(_runPath, _outputZipFile)

        # runSuite output file is ready for reading...
        _retVal = CommonBuildbotFns.readOutputFile(_runPath, _tmpLogFilePtr)

        _tmpLogFilePtr.write("\n===RESULT:UT_RESULT:"+ _retVal + "\n")
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
