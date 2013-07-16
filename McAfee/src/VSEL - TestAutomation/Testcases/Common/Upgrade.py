#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: lsh-12345
# TestcaseDescription:  Upgrade product from one version to another.
import sys
import logging
import shutil
import re
# Add common folder into the sys path for module importing
sys.path.append("../Common")
sys.path.append('../Antimalware')
import commonFns
import commonAntiMalwareFns
# Import CommonTest module into current namespace
from CommonTest import *
from commonAntiMalwareFns import VALID_VSEL_KEYS
# Get testcase name
testcaseName = sys.argv[0][:-3]
class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : Upgrade")
        logging.info("Description : Testcase to upgrade the product from one version to another")

    def init(self, upgradeVersion):
        logging.info("Initializing testcase %s" % testcaseName)
        # TODO : Modify isProductInstalled for LinuxShield 1.5 and 1.6.1
        
        # Call the common initialization check
        #_retval = BaseTest.init(self)
        #if _retval != 0 :
        #    return _retval

        self._products = upgradeVersion
        #logging.debug("Checking if product is installed")
        #if commonAntiMalwareFns.isProductInstalled() :
        #    logging.error("Could not continue as product is not installed")
        #    return 1
        productVersion = commonAntiMalwareFns.getProductInfo()
        productVersion = productVersion['version']
        logging.debug("Existing product version is " + productVersion)
        if productVersion == '1.5.0' :
            productVersion = VALID_VSEL_KEYS[0]
        elif productVersion == '1.5.1' :
            productVersion = VALID_VSEL_KEYS[1]
        elif productVersion == '1.6.0' :
            productVersion = VALID_VSEL_KEYS[2]
        elif productVersion == '1.7.0' :
            productVersion = VALID_VSEL_KEYS[3]
        else :
            logging.error("Invalid product version %s" % productVersion)
            return 1
        if VALID_VSEL_KEYS.index(productVersion) >= VALID_VSEL_KEYS.index(sys.argv[2]) :
            print("Cannot upgrade from %s to %s " % (productVersion, sys.argv[2]))
            logging.debug("Cannot upgrade from %s to %s " % (productVersion, sys.argv[2]))
            usage()
            sys.exit(1)
        # Get the location of products based on the versions
        
        self._current_version = productVersion
        payload_path = self.getConfig('PAYLOAD_PATH')
        if not payload_path :
            logging.error("Failed to read the key PAYLOAD_PATH from config file")
            return 1
        
        self._extract_dir = os.path.abspath(os.path.dirname(sys.argv[0])) + '/data/upgrade'
        if not os.path.exists(self._extract_dir) :
            logging.debug("Creating directory " + self._extract_dir)
            os.mkdir(self._extract_dir)
        
        self._upgrade_version = sys.argv[2]
        self._upgrade_loc = payload_path + '/upgrade/' + self._upgrade_version
        self._package_files = self._getPackageFile()
        if not self._package_files or len(self._package_files) == 0 :
            logging.error("Could not find package file in %s " % self._extract_dir)
            return 1
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
        # If we are upgrading to 1.5.1, then silent install file for cma must be placed
        if self._upgrade_version == VALID_VSEL_KEYS[1] :
            logging.debug("Creating the silent install file for the ma")
            
        logging.debug("Now running upgrade with package file %s " % self._package_files)
        if not commonAntiMalwareFns.upgradeTo(self._package_files, self._current_version) :
            logging.error("Failed to upgrade")
            return 1
        return 0

    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        logging.debug("Performing the BOM check for verification")
        if not commonAntiMalwareFns.compareMD5(commonAntiMalwareFns.getMD5Dict()) :
            logging.error("MD5 Check failed. Upgrade will fail")
            return 1
        return 0

    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        # Copy logs and clean them.
        foundCrash = 0
        foundCrash = commonFns.copyLogs()
        commonFns.cleanLogs()
        
        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")
        if os.path.isdir(self._extract_dir) :
            logging.debug("Deleting the extract directory")
            shutil.rmtree(self._extract_dir)  
        return foundCrash

    def __del__(self):
        pass

    def _getPackageFile(self) :
        ################################################################################
        # FIX : Due to space issues we removed the extraction of tar.gz files.
        #gz_file = commonAntiMalwareFns.getBuildFileName(self._upgrade_loc, self._upgrade_version)
        #if not gz_file :
        #    logging.error("No matching file found in %s" % self._upgrade_loc)
        #    return None
        #if not commonFns.extractArchive(gz_file, self._extract_dir) :
        #    logging.error("tar file extraction failed")
        #    return None
        #################################################################################
        # Now read the directory and find the rpm or deb file based on OS & based on bits
        osDetails = commonFns.getOSDetails()
        a_regex = ['^MFErt.+', '^MFEcma.+', '^McAfeeVSEForLinux-\d\.\d\.\d-\d+\.noarch']
        # For 1.5.0 and 1.5.1 there is no ubuntu .. so it is rpm always
        # But there are different package for 64 and 32
        if VALID_VSEL_KEYS.index(self._upgrade_version) < 2 :
            a_regex = ['^MFErt.+', '^MFEcma.+']
            if VALID_VSEL_KEYS.index(self._upgrade_version) == 0 :
                a_regex = ['^NWA-\d\.\d\.\d-.+\.rpm']
            a_regex = a_regex + '^LinuxShield-\d\.\d\.\d-\d+-release\.i386'
            if re.search('64', os.uname()[4]) :
                a_regex = a_regex + '^LinuxShield-\d\.\d\.\d-\d+-release\.x86_64'
        # For 1.6.0 and above we suport Ubuntu.. so check the OS here
       
        for i in xrange(0, len(a_regex)) :
            if osDetails['os_name'] is 'Ubuntu' :
                a_regex[i] = a_regex[i] + '\.deb$'
            else :
                a_regex[i] = a_regex[i] + '\.rpm$'
        # Finally we have valid regex.. now see if there is a package file with that name.
        entries = os.listdir(self._upgrade_loc)
        # FIX : Due to space issues we removed the extraction of gz files.
        # entries = os.listdir(self._extract_dir)
        packages = []
        for regex in a_regex :
            # FIX : Due to space issues, we removed the extraction of gz files.
            packages = packages + [self._upgrade_loc + '/' + x for x in entries if re.search(regex, x) ]
        logging.debug("Packages that will be installed are " + ' '.join(packages))
        return packages


def usage() :
    print """
    Usage : Upgrade.py loglevel PRODUCT_VERSION
    
    logleve is one of debug, info, error
    PRODUCT_VERSION is one of LYNXSHLD1501, LYNXSHLD1600, LYNXSHLD1700
    
    Upgrades the linuxshield to the given version. The previous version of the product must be
    already installed for the upgrade. Normally this script is called by driver script which
    handles the installing of the initial version. 

    The build archives must be placed in <PAYLOAD_PATH>/upgrade/<PRODUCT_VERSION>
"""
if __name__ == "__main__":

    if len(sys.argv) < 3 :
        usage()
        sys.exit(1)
    if sys.argv[2] not in VALID_VSEL_KEYS :
        usage()
        sys.exit(1)
    # Setup testcase
    setupTestcase(sys.argv)

    testObj = TestCase()

    # Perform testcase operations
    retVal = testObj.init(sys.argv[2])

    # Perform execute once initialization succeeds...    
    if(retVal == 0):
        retVal = testObj.execute()

    # Once execution succeeds, perform verification...
    if(retVal == 0):
        retVal = testObj.verify()

    # Perform testcase cleanup
    retVal = retVal + testObj.cleanup()

    if(retVal == 0):
        resultString = "PASS"
    else:
        resultString = "FAIL"
        
    logging.info("Result of testcase %s: %s" % (testcaseName, resultString) )
    sys.exit(retVal)

