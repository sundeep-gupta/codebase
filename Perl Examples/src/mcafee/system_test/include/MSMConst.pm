##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2009, McAfee Limited. All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################

package MSMConst;
use strict;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = ();

########################################################
#            PRODUCT NAMES                              #
#########################################################
push @EXPORT, qw($MAC_CONSUMER $MAC_ENTERPRISE);
$MSMConst::MAC_CONSUMER    = 'McAfeeSecurity::Mac::Consumer';
$MSMConst::MAC_ENTERPRISE  = 'McAfeeSecurity::Mac::Enterprise';

#######################################################
#        CONSTANTS FOR FRAMEWORK DIRECTORIES          #
#######################################################
push @EXPORT, qw($LOG_DIR $DATA_DIR $INC_DIR $BUILD_DIR $LIB_DIR);
$MSMConst::LOG_DIR         = "logs";
$MSMConst::DATA_DIR        = "data";
$MSMConst::INC_DIR         = "include";
$MSMConst::BUILD_DIR       = "build";
$MSMConst::LIB_DIR         = 'lib';

#######################################################
# Paths of external log files used for parsing        #
#######################################################
push @EXPORT, qw($SYSTEM_LOG $MSM_SECURITY_LOG $KERNEL_LOG $MSM_LOG $MSM_DEBUG_LOG);
$MSMConst::SYSTEM_LOG       = "/var/log/system.log";
$MSMConst::MSM_SECURITY_LOG = "/var/log/McAfeeSecurity.log"; 
$MSMConst::FIREFOX          = "/Applications/Firefox.app/Contents/MacOS/firefox-bin";
$MSMConst::KERNEL_LOG = "/var/log/kernel.log";
$MSMConst::MSM_LOG     = "/var/log/McAfeeSecurity.log";
$MSMConst::MSM_DEBUG_LOG = "/var/log/McAfeeSecurityDebug.log";



#######################################################
#    CONSTANTS FOR TEST CASES                         #
#######################################################
push @EXPORT, qw($OAS_CLEAN_TEST $OAS_MIXED_TEST );
$MSMConst::OAS_CLEAN_TEST  = 'oas_clean';
$MSMConst::OAS_MIXED_TEST  = 'oas_mixed';
$MSMConst::PRODUCT_PATHS   = [ "/usr/local/McAfee/AntiMalware/dats/", "/usr/local/McAfee", "/Library/Preferences/com.mcafee.ssm.antimalware.plist",
                               "/Library/Preferences/com.mcafee.ssm.appprotection.plist","/Library/Preferences/com.mcafee.ssm.firewall.plist",
                               "/Library/Frameworks/AVEngine.framework/", "/Library/Frameworks/SACore.framework",
			       "/Library/Frameworks/MacScanner.framework/","/Library/Frameworks/ScanBooster.framework/",
                               "/Library/Frameworks/VirusScanPreferences.framework/","/Applications/McAfee Security.app",
                               "/Library/Application Support/McAfee","/Library/Receipts/AntiMalware.pkg","/Library/Receipts/AppProtection.pkg","/Library/Receipts/FMP.pkg",
                               "/Library/Receipts/Firewall.pkg","/Library/Receipts/MSCUI.pkg" ];

########################
# CONSTANTS USED FOR REPORTS
#########################
$MSMConst::CPU_USAGE         = 'cpu_usage';
$MSMConst::PROD_REAL_MEMORY = 'prod_real_memory';
$MSMConst::PROD_VIRTUAL_MEMORY = 'prod_virtual_memory';
$MSMConst::PAGE_FAULTS         = 'page_faults';






1;
