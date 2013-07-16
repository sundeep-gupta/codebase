#!/usr/bin/env python
# Copyright (C) 2010 McAfee, Inc. All rights reserved
'''Algorithm :
1. Input will be csv file and eit data
2. open csv file
for each line in csv file :
    create a testcase dict and append it to suite dict
close csv file
3. Now we have list of all testcases organized in suite order
For each testcase in each suite :
    init part 
        primary  / seconary action setting - add into csv
        do we need to change the dat 
            *current dat 
        file command on the sample
        
    Run the OAS / ODS test --- do we need to change the setting of OAS for any testcase ??? If yes csv has to say that.
    
    Verify result and mark the status

For each testcase in each suite : 
    Log the result.
'''
import csv
import re
import sys



class EITSample :
    pass


class EIT :
    def __init__(self, csvFileName, eitDataPath):
        if not ( csvFileName and os.path.exists(csvFileName) ) :
            logging.error("Invalid csv path")
            return 0
        if not (eitDataPath and os.path.exists(eitDataPath)) :
            logging.error("Invalid data path ")
            return 0
        self.csvFileName = csvFileName
        self.eitDataPath = eitDataPath
    def execute(self):
        try :
            _parseCSVFile()
        except :
            logging.error("Failed to parse the csv file")
    def _parseCSFFile(self):
        
        eitReader = csv.reader(open(self.csvFileName,'rU'))
        header = eitReader[0]
        eitTest = dict()
        for i in xrange(len(eitReader)) :
            pass
    def generateReport(self):
        pass
    
if __name__ == '__main__' :
    eit = EIT(csvFile, eitData)
    eit.execute()
    eit.generateReport()