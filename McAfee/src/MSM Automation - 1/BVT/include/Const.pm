##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################

package Const;
use strict;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = ();

########################################################
#            PRODUCT NAMES                              #
#########################################################
push @EXPORT, qw($MAC_CONSUMER $MAC_ENTERPRISE $MAC_INTEGOX5 $MAC_NORTON11);
$Const::MAC_CONSUMER    = 'Security::McAfee::Mac::Consumer';
$Const::MAC_ENTERPRISE  = 'Security::McAfee::Mac::Enterprise';
$Const::MAC_INTEGOX5    = 'Security::Competitor::Intego';
$Const::MAC_NORTON11    = 'Security::Competitor::Norton';

#######################################################
#        CONSTANTS FOR FRAMEWORK DIRECTORIES          #
#######################################################
push @EXPORT, qw($LOG_DIR $DATA_DIR $INC_DIR $BUILD_DIR $LIB_DIR $TMP_DIR);
$Const::LOG_DIR         = "logs";
$Const::DATA_DIR        = "data";
$Const::INC_DIR         = "include";
$Const::BUILD_DIR       = "build";
$Const::LIB_DIR         = 'lib';
$Const::TMP_DIR         = 'data/tmp';

#######################################################
# Paths of external log files used for parsing        #
#######################################################
push @EXPORT, qw($SYSTEM_LOG $MSM_SECURITY_LOG $KERNEL_LOG $MSM_LOG $MSM_DEBUG_LOG);
$Const::SYSTEM_LOG       = "/var/log/system.log";
$Const::MSM_SECURITY_LOG = "/var/log/McAfeeSecurity.log"; 
$Const::KERNEL_LOG       = "/var/log/kernel.log";
$Const::MSM_LOG          = "/var/log/McAfeeSecurity.log";
$Const::MSM_DEBUG_LOG    = "/var/log/McAfeeSecurityDebug.log";

push @EXPORT, qw($PASS $FAIL $TRUE $FALSE);
$Const::PASS = 'PASS';
$Const::FAIL = 'FAIL';
$Const::TRUE = 1;
$Const::FALSE= 0;


1;
