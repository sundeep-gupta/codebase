#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc. All rights reserved
import subprocess
import os
import re
import sys
import zipfile
import shutil

os.unsetenv("TMPDIR")

scriptDir       = os.path.dirname(os.path.abspath(sys.argv[0]))
rootDir         = os.path.abspath(scriptDir + "../../..")
buildDir        = scriptDir + '/builds'
zipFile         = 'LSH.zip'
zipFilePath     = buildDir + '/' + zipFile
bbBvtDriverPath = "Testcases/BVT/Buildbot_BVT_Driver.py"
# SVN Details
svnServer  = "bngsvn"
baseSVNDir = "/srcRepo/LSH"
userName   = "svcacct-maclnx"
password   = 'eT9Di@5Fz;)2OeRh'

# Map for branch
branchMap = {"HEAD" :'trunk',
             }

# Step 1 : Extract the zip file to find product and build.
def extractZipFile():
    try :
        file = zipfile.ZipFile(zipFilePath, "r")
        filesInZip = file.namelist();
        os.chdir(buildDir)
        retVal = subprocess.call(['unzip', zipFile])
        if retVal != 0 :
            print "Failed to unzip " + zipFile
            return 0
    except :
        print "Failed to unzip with exception " + zipFile
        return 0
    finally :
        os.chdir(scriptDir)
    return 1

def getBuildInfo():
    buildInfo = dict()
    try :
        zFile = zipfile.ZipFile(zipFilePath, "r")
        filesInZip = zFile.namelist()
        buildZipFile = filesInZip[0]
        regexBuildInfo = '(.*?)\.(\d+)\.\d+\.(.*?)\.zip'
        match = re.search(regexBuildInfo, buildZipFile)
        if match is not None :
            buildInfo["name"] = match.group(1)
            buildInfo['build'] = match.group(2)
            buildInfo['branch'] = match.group(3)
    except :
        print "Failed [ Exception occured while fetching info from zipFile ]"
        return None
    return buildInfo

def svnCheckout(branch):
    url = "https://" + svnServer + baseSVNDir + "/" + branch + "/TestAutomation"
    print "Now doing a checkout of the files from " + url
    print "cd to %s for checkout" % branchDir
    try :
        os.chdir(branchDir)
        cmd = ["svn", "co", "--username", userName, "--password", password, url]
        retVal = subprocess.call(cmd)
        if retVal != 0:
            print "svn checkout returned error code %d."  % retVal
            return 0
    except :
        print "Checkout failed with exception"
        return 0
    finally :
        os.chdir(scriptDir)
    return 1

def svnUpdate(branchDir):
    print "cd to %s for update" % branchDir
    try :
        os.chdir(branchDir + '/TestAutomation')
        cmd = ["svn", "update", "--username", userName, "--password", password]
        retVal = subprocess.call(cmd)
        if retVal != 0:
            print "svn update returned error code %d."  % retVal
            return 0
    except :
        print "Update failed with exception"
        # TODO : Remove the directory as cleanup
        return 0
    finally :
        os.chdir(scriptDir)
    return 1

def main() :
    global branchDir
    files_in_builddir = os.listdir(buildDir)
    for file in files_in_builddir :
        if file not in ['LSH.zip', '.svn'] :
            shutil.rmtree(buildDir + '/' + file)
    # Unzip the archive and exit if failed.
    print "Retreiving build number and branch from zip file ... ",
    buildInfo = getBuildInfo()
    if buildInfo is None :
        print "Could not get build information from zip file."
        return 0
    print "done"
    result_file = buildInfo['name'] + '.' + buildInfo['build'] + '.' + buildInfo['branch'] + '.RES'
    
    # Now we know the branch.
    # a. Create the tmp directory below the TestAutomation directory
    # b. Do an svn checkout of that branch.
    branch = buildInfo["branch"]
    if branchMap.has_key(buildInfo["branch"]) :
        branch = branchMap[buildInfo["branch"]]

    branchDir = rootDir + "/" + branch

    if branch in ['HEAD', 'trunk']:
        branch = 'trunk'
    else :
        branch = "branches/" + branch
    # Extract the zip file to get tar.gz
    print "Now extracting " + zipFilePath + " ... ",
    sys.stdout.flush()
    zipFile = zipfile.ZipFile(zipFilePath)
    buildZipFile = zipFile.namelist()
    if len(buildZipFile) != 1 :
        print "We expected only one zip file out of given zip file"
        return 0
    os.chdir(buildDir)
    retval = subprocess.call(['unzip', zipFilePath])
    if retval != 0 :
        print "Failed to extract " + zipFilePath
        return 0
    os.chdir(scriptDir)
    print "done"

    buildZipFilePath = "builds/" + buildZipFile[0]
    print "Now we will extract " + buildZipFilePath + "...",
    sys.stdout.flush()
    zipFile = zipfile.ZipFile(buildZipFilePath)
    files = zipFile.namelist()
    if len(files) != 1 :
        print "We expected only one tar.gz file in the zip file."
        return 0
    os.chdir(buildDir)
    retval = subprocess.call(['unzip', buildZipFile[0]])
    if retval != 0 :
        print "Failed to extract " + buildZipFile[0]
        return 0
    os.chdir(scriptDir)
    #zipFile.extract(files[0], "builds", pwd=scriptDir)
    print "done"
    vsel_package = scriptDir + '/builds/' + files[0]

    
    # If path exist and there is a '.svn' directory, we assume that the files are already
    # available and we do a 'svn update' instad of 'svn co'
    print "Now we will checkout / update here ..." + branchDir
    if os.path.exists(branchDir + '/TestAutomation/.svn' ):
        print "Directory %s exists, thus performing 'svn update' ..." % branchDir,
        if svnUpdate(branchDir) != 1 :
            print "SVN Update failed."
            return 0
        print "done"
    else :
        print "Directory %s does not exist. Checking out the code ... " % branchDir
        if not os.path.exists(branchDir) :
            os.mkdir(branchDir, 0777)
        # Do the checkout
        if svnCheckout(branch) != 1 :
            print "SVN checkout failed."
            return 0
        print "done"


    bbBvtDriver = branchDir + "/TestAutomation/Testcases/BVTDriver.py"
    # Now run the Buildbot driver script of the actual branch.
    cmd =['python', bbBvtDriver, '--install=' + vsel_package, '--loglevel=debug'] 
    print cmd
    retVal = subprocess.call(cmd)
    if retVal != 0 :
        print "BVT Script returned %s" % retVal

    # Take the result file from the branch and create RES file.
    bvtDriverLog = branchDir + '/Testcases/Logs/BVTDriver.log'
    print "Generating result file from : " + bvtDriverLog + ' ... ',
    _lines = []
    if not os.path.exists(bvtDriverLog) :
        print "Log not found"
    else :
        _fh = open(bvtDriverLog, 'r')
        _lines = [line for line in _fh.readlines() if re.search('^===RESULT', line) ]
        _fh.close()

    _desc = 'Not yet Implemented'
    _fh = open(buildDir + '/' + result_file, 'w')
    _fh.write('===DESC:' + _desc + "\n")
    for _line in _lines :
        _fh.write(_line + "\n")
    _fh.close()
    print "done"
    # Move to RES file.
    print "Now moving the file to destination . . . ",
    os.rename(scriptDir + '/builds/'+result_file , scriptDir + '/bvtoutput/' + result_file)    
    print 'done'
    
    filesInBuildDir = os.listdir(buildDir)
    for f in filesInBuildDir :
        if f not in ['.svn', 'LSH.zip'] :
            if os.path.isdir(buildDir + '/' + f) :
                shutil.rmtree(buildDir + '/' + f)
            else :
                os.remove(buildDir + '/' + f)
    return 0


def cleanup(exit = True):
    # Remove all the files in the build directory
    os.chdir(scriptDir)
    list = os.listdir(build_dir)
    for file in list :
        if file not in ['.svn', product +'.zip' ]:
            print "Deleting %s" % file
            subprocess.call(['rm', '-rf', build_dir + '/' + file])

    return 0
# Run main
main()
