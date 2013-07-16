#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc.  All rights reserved.
# TestcaseID: 2278 
# TestcaseDescription: Product Uninstallation  from Epo 

import time
import sys
import os
from socket import gethostname
import commands
import logging
from Tasks import *

# Add common folder into the sys path for module importing
sys.path.append("../Common")
import commonFns
sys.path.append("../Antimalware")
import commonAntiMalwareFns
import commonEpoFns

# Import CommonTest module into current namespace
from CommonTest import *

# Get testcase name
testcaseName = sys.argv[0][:-3]

class TestCase(BaseTest):
    def __init__(self):
        logging.info("TestcaseID : 2278")
        logging.info("Description : Product Uninstallation from Epo")
    
    def init(self):
        logging.info("Initializing testcase %s" % testcaseName)
        # Call the common initialization check

        _retval = BaseTest.init(self)
        if _retval != 0 :
            return _retval
        return 0

    def execute(self):
        logging.info("Executing testcase %s" % testcaseName)
	if not commonEpoFns.EPODeleteAllTasks(gethostname()):
            logging.error("Not able to delete the task")
            return 1
        logging.info("All tasks deleted")
        
	taskSched = EPOTaskSchedule
        deployTask = AgentDeploymentTask("Deploy Product on " + gethostname())
        deployTask.addProduct('LYNXSHLD1600', '1.6.0', "Remove", "Current", AgentDeploymentTask.LANG_ENGLISH)
        taskSchedule = EPOTaskSchedule(EPOTaskSchedule.SCHED_TYPE_RUN_IMMEDIATELY)

        if not commonEpoFns.EPOCreateAgentTask(gethostname(), deployTask, taskSchedule):
       	    FailTestCase("Failed to create Deployment Task")
            return 1
        
	logging.info("Deployment Task Created")
        if not commonEpoFns.EPOAgentWakeup(gethostname(), False): 
            logging.error("Not able to send the agent wake up call")
            return 1
        logging.info("Agent wake up call sent successfully")
	time.sleep(90)
        while True :
       	    output =commands.getoutput('ps -A')
       	    if 'Mue_InUse' not in  output: 
                break
        return 0
        


    def verify(self):
        logging.info("Verifying testcase %s" % testcaseName)
        if commonAntiMalwareFns.isProductInstalled() == True:
            logging.error("isProductInstalled True")
            return 1
        return 0


    def cleanup(self):
        logging.info("Performing cleanup for testcase %s" % testcaseName)
        foundCrash = 0
        foundCrash = commonFns.copyLogs()

        commonFns.cleanLogs()
        if foundCrash != 0:
            logging.error("copylogs returned failure status.  Maybe a product crash")

        return foundCrash



    def __del__(self):
        pass

if __name__ == "__main__":
    # Setup testcase
    setupTestcase(sys.argv)

    testObj = TestCase()

    # Perform testcase operations
    retVal = testObj.init()
    # Perform execute once initialization succeeds...    
    if(retVal == 0):
        retVal = testObj.execute()

    # Once execution succeeds, perform verification...
    if(retVal == 0):
        retVal = testObj.verify()

    # Perform testcase cleanup
    retVal += testObj.cleanup()

    if(retVal == 0):
        resultString = "PASS"
    else:
        resultString = "FAIL"
        
    logging.info("Result of testcase %s: %s" % (testcaseName, resultString) )
    sys.exit(retVal)
