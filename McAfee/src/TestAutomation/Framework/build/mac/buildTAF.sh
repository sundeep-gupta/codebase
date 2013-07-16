#!/bin/bash
# Copyright (C) 2010 McAfee, Inc. All rights reserved
XCODEBUILD=`whereis xcodebuild`
SDKROOT="/Developer/SDKs/MacOSX10.5.sdk"
if [ ! -d $SDKROOT ]
then
SDKROOT="/Xcode2.5/SDKs/MacOSX10.5.sdk"
fi
GCC_VERSION="4.0"
BUILD_STYLE="Release"
usage()
{
   echo "Usage $0 <TOPS> <BuildNum>" 
}


buildTAF()
{
    pushd $PROJECT_HOME/build/mac
    echo "Entered buildTAF" 
    # Clean App Protection builds
    ${XCODEBUILD} -project TestAutomationFramework.xcodeproj -alltargets clean
    # Build back end 
    ${XCODEBUILD} -project TestAutomationFramework.xcodeproj SDKROOT=${SDKROOT} GCC_VERSION=${GCC_VERSION} -alltargets -configuration "${BUILD_STYLE}"
    if [ $? -ne 0 ]
    then
        echo "Backend Build Failed"
        rm -rf STAF-SDK
        popd
        exit -1
    fi
    rm -rf STAF-SDK
    popd
}
createBuiltTar()
{
    pushd $PROJECT_HOME/build/mac
    echo "Entered createBuiltTar"
    rm -rf $PROJECT_HOME/TAFOutput
    mkdir $PROJECT_HOME/TAFOutput
    pushd $PROJECT_HOME/build/mac/build/$BUILD_STYLE
    echo "Build Details $BUILD_NUM" > TAF_VersionDetails.txt
    cp $PROJECT_HOME/src/common/Server/*.xml . 
    cp $PROJECT_HOME/src/common/TestLinkInteg/testLinkUpdater.py  .
    cp /usr/local/boost/lib/libboost_thread-1_32.dylib .
    cp /usr/local/boost/lib/libboost_filesystem-1_32.dylib .
    tar -cvf $PROJECT_HOME/TAFOutput/TAFBuilt.tar\
        *.dylib \
        *.xml \
        *.txt \
        *.py \
        harnessServer\
        harnessCLI
    popd
    popd
    
}


if [ $# -lt 2 ]
then
    usage
    exit -1
fi
TOPS_HOME=$1
PROJECT_HOME=$TOPS_HOME/TestAutomation/Framework
BUILD_NUM=$2
buildTAF
createBuiltTar
