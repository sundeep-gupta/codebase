#!/bin/bash
# Copyright (C) 2010 McAfee, Inc. All rights reserved.

usage()
{
   echo "Usage: $0 <TOPS_HOME> <BUILD_NUM> <PACKAGE_NUM>"
   exit -1;
}
if [ $# -lt 3 ]
then
    usage
fi

TOPS_HOME=$1
PROJECT_HOME=$TOPS_HOME/TestAutomation/Framework
BUILD_NUM=$2
PACKAGE_NUM=$3
TAF_BUILD_FILE=$PROJECT_HOME/TAFOutput/TAFBuilt.tar
SIMULATED_INSTALL_PATH_BASE=$PROJECT_HOME/TAFOutput/InstallPath
SIMULATED_INSTALL_PATH_ACTUAL=$SIMULATED_INSTALL_PATH_BASE/usr/local/TAF/
SIMULATED_INSTALL_PATH_LAUNCHD=$SIMULATED_INSTALL_PATH_BASE/Library/LaunchDaemons
SERVER_PACKAGE_NAME=TAF-Server-$BUILD_NUM-$PACKAGE_NUM.pkg
CLIENT_PACKAGE_NAME=TAF-Client-$BUILD_NUM-$PACKAGE_NUM.pkg
BIN_DIR=$SIMULATED_INSTALL_PATH_ACTUAL/bin
LIB_DIR=$SIMULATED_INSTALL_PATH_ACTUAL/lib
CONFIG_DIR=$SIMULATED_INSTALL_PATH_ACTUAL/config   
STAF_DIR=$SIMULATED_INSTALL_PATH_ACTUAL/STAF   
if [ ! -f $TAF_BUILD_FILE ]
then
    echo "Built file $TAF_BUILD_FILE not found"
    exit -1
fi

createServerDirStructure()
{
    
    rm -rf $BIN_DIR $LIB_DIR $CONFIG_DIR ${STAF_DIR} ${SIMULATED_INSTALL_PATH_LAUNCHD}
    mkdir -p $BIN_DIR $LIB_DIR $CONFIG_DIR ${STAF_DIR}
    mkdir -p $PROJECT_HOME/TAFOutput/built_files
    mkdir -p ${SIMULATED_INSTALL_PATH_LAUNCHD}
    pushd $PROJECT_HOME/TAFOutput/built_files
    tar -xvf $TAF_BUILD_FILE
    echo "Package Number : $PACKAGE_NUM" >> TAF_VersionDetails.txt
    echo "Package Type : SERVER" >> TAF_VersionDetails.txt
    cp *.dylib $LIB_DIR
    cp *.xml $CONFIG_DIR
    cp $TOPS_HOME/CommonUtils/3rd-party/other/STAF/STAFInstallableFiles.tar.gz  $STAF_DIR
    cp $TOPS_HOME/CommonUtils/3rd-party/other/STAF/STAFEMail.jar  ${LIB_DIR}
    cp harnessServer $BIN_DIR
    cp harnessCLI $BIN_DIR
    cp *.py $BIN_DIR
    cp *.txt $SIMULATED_INSTALL_PATH_ACTUAL
    cp ${PROJECT_HOME}/package/mac/com.mcafee.taf.harnessserver.plist $SIMULATED_INSTALL_PATH_LAUNCHD
    cp ${PROJECT_HOME}/package/mac/com.mcafee.taf.staf.plist $SIMULATED_INSTALL_PATH_LAUNCHD
    cp ${PROJECT_HOME}/package/mac/uninstallTAF.sh $BIN_DIR
    popd

}
createClientDirStructure()
{
    rm -rf $BIN_DIR $LIB_DIR $CONFIG_DIR ${STAF_DIR} ${SIMULATED_INSTALL_PATH_LAUNCHD}
    mkdir -p $BIN_DIR $LIB_DIR $CONFIG_DIR ${STAF_DIR}
    mkdir -p $PROJECT_HOME/TAFOutput/built_files

    mkdir -p ${SIMULATED_INSTALL_PATH_LAUNCHD}
    pushd $PROJECT_HOME/TAFOutput/built_files
    echo "Package Number : $PACKAGE_NUM" >> TAF_VersionDetails.txt
    echo "Package Type : CLIENT" >> TAF_VersionDetails.txt
    tar -xvf $TAF_BUILD_FILE  
    cp *.txt $SIMULATED_INSTALL_PATH_ACTUAL
    cp $TOPS_HOME/CommonUtils/3rd-party/other/STAF/STAFInstallableFiles.tar.gz  $STAF_DIR
    cp ${PROJECT_HOME}/package/mac/uninstallTAF.sh $BIN_DIR
    cp ${PROJECT_HOME}/package/mac/com.mcafee.taf.staf.plist $SIMULATED_INSTALL_PATH_LAUNCHD
    popd

}
createServerPackage()
{
     # remove the client resources and rename server resources
     cp -Rf ${PROJECT_HOME}/package/mac/resources ${PROJECT_HOME}/package/mac/resources.original
     mv ${PROJECT_HOME}/package/mac/resources/server_postflight ${PROJECT_HOME}/package/mac/resources/postflight
     mv ${PROJECT_HOME}/package/mac/resources/server_preflight ${PROJECT_HOME}/package/mac/resources/preflight
     rm ${PROJECT_HOME}/package/mac/resources/client_*
     rm -rf ${PROJECT_HOME}/package/mac/resources/.svn

     mkdir ${PROJECT_HOME}/package/mac/tmp
     mv ${PROJECT_HOME}/package/mac/resources/Info.plist ${PROJECT_HOME}/package/mac/tmp/Info.plist
     cat  ${PROJECT_HOME}/package/mac/tmp/Info.plist  | sed -e s/__BUILD_NUM__/$BUILD_NUM/g > ${PROJECT_HOME}/package/mac/resources/Info.plist
     # Give execute permissions to the preflight and post flight scripts
     chmod +x ${PROJECT_HOME}/package/mac/resources/preflight
     chmod +x ${PROJECT_HOME}/package/mac/resources/postflight
    /Developer/Applications/Utilities/PackageMaker.app/Contents/MacOS/PackageMaker  -build \
            -p ${PROJECT_HOME}/TAFOutput/$SERVER_PACKAGE_NAME -f ${SIMULATED_INSTALL_PATH_BASE} \
            -r ${PROJECT_HOME}/package/mac/resources -i ${PROJECT_HOME}/package/mac/resources/Info.plist\
            -d ${PROJECT_HOME}/package/mac/server_Description.plist

    pushd ${PROJECT_HOME}/TAFOutput

   chmod +x ${PROJECT_HOME}/TAFOutput/$SERVER_PACKAGE_NAME/Contents/Resources/preflight
   chmod +x ${PROJECT_HOME}/TAFOutput/$SERVER_PACKAGE_NAME/Contents/Resources/postflight

    #restore original Info.plist and resource dir
    mv ${PROJECT_HOME}/package/mac/tmp/Info.plist ${PROJECT_HOME}/package/mac/resources/Info.plist
    rm -rf ${PROJECT_HOME}/package/mac/tmp
    rm -rf ${PROJECT_HOME}/package/mac/resources
    mv ${PROJECT_HOME}/package/mac/resources.original ${PROJECT_HOME}/package/mac/resources
    rm -rf ${PROJECT_HOME}/package/mac/resources/tmpInfo.plist 
    popd
}
createClientPackage()
{
     # remove the server resources and rename client resources
     cp -Rf ${PROJECT_HOME}/package/mac/resources ${PROJECT_HOME}/package/mac/resources.original
     mv ${PROJECT_HOME}/package/mac/resources/client_postflight ${PROJECT_HOME}/package/mac/resources/postflight
     mv ${PROJECT_HOME}/package/mac/resources/client_preflight ${PROJECT_HOME}/package/mac/resources/preflight
     rm ${PROJECT_HOME}/package/mac/resources/server_*
     rm -rf ${PROJECT_HOME}/package/mac/resources/.svn

     mkdir ${PROJECT_HOME}/package/mac/tmp
     mv ${PROJECT_HOME}/package/mac/resources/Info.plist ${PROJECT_HOME}/package/mac/tmp/Info.plist
     cat  ${PROJECT_HOME}/package/mac/tmp/Info.plist  | sed -e s/__BUILD_NUM__/$BUILD_NUM/g > ${PROJECT_HOME}/package/mac/resources/Info.plist
     # Give execute permissions to the preflight and post flight scripts
     chmod +x ${PROJECT_HOME}/package/mac/resources/preflight
     chmod +x ${PROJECT_HOME}/package/mac/resources/postflight
    /Developer/Applications/Utilities/PackageMaker.app/Contents/MacOS/PackageMaker  -build \
            -p ${PROJECT_HOME}/TAFOutput/$CLIENT_PACKAGE_NAME -f ${SIMULATED_INSTALL_PATH_BASE} \
            -r ${PROJECT_HOME}/package/mac/resources -i ${PROJECT_HOME}/package/mac/resources/Info.plist\
            -d ${PROJECT_HOME}/package/mac/client_Description.plist

    pushd ${PROJECT_HOME}/TAFOutput

   chmod +x ${PROJECT_HOME}/TAFOutput/$CLIENT_PACKAGE_NAME/Contents/Resources/preflight
   chmod +x ${PROJECT_HOME}/TAFOutput/$CLIENT_PACKAGE_NAME/Contents/Resources/postflight

    #restore original Info.plist and resource dir
    mv ${PROJECT_HOME}/package/mac/tmp/Info.plist ${PROJECT_HOME}/package/mac/resources/Info.plist
    rm -rf ${PROJECT_HOME}/package/mac/tmp
    rm -rf ${PROJECT_HOME}/package/mac/resources
    mv ${PROJECT_HOME}/package/mac/resources.original ${PROJECT_HOME}/package/mac/resources
    rm -rf ${PROJECT_HOME}/package/mac/resources/tmpInfo.plist 
    popd
}
wrapup()
{
    set -x
    pushd ${PROJECT_HOME}
    mkdir ${PROJECT_HOME}/TAFOutput_new
    pushd ${PROJECT_HOME}/TAFOutput_new 
    mv $PROJECT_HOME/TAFOutput/$SERVER_PACKAGE_NAME $PROJECT_HOME/TAFOutput/$CLIENT_PACKAGE_NAME .
    cp $PROJECT_HOME/docs/TAF-InstallationGuide.pdf .
    tar -zcvf TestAutomationFramework-$BUILD_NUM-$PACKAGE_NUM.tar.gz $SERVER_PACKAGE_NAME $CLIENT_PACKAGE_NAME  TAF-InstallationGuide.pdf
    rm -rf $SERVER_PACKAGE_NAME $CLIENT_PACKAGE_NAME TAF-InstallationGuide.pdf
    popd   
    rm -rf ${PROJECT_HOME}/TAFOutput
    mv ${PROJECT_HOME}/TAFOutput_new ${PROJECT_HOME}/TAFOutput 
    popd
}
createServerDirStructure
createServerPackage
createClientDirStructure
createClientPackage
wrapup
