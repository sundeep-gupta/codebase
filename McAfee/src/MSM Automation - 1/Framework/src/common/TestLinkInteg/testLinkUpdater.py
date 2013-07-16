#! /usr/bin/python
# Copyright (C) 2010 McAfee, Inc. All rights reserved.
# Created by Arjun on 22/04/2010
"""
Testlink API Sample Python Client implementation
"""
import xmlrpclib
import sys 
import optparse
import xml.dom.minidom
from xml.dom.minidom import parse

class TestlinkAPIClient:        
	def __init__(self):
		# Open XML document using minidom parser
		DOMTree = xml.dom.minidom.parse("/usr/local/TAF/config/ServerConfig.xml")
		serverPort = DOMTree.getElementsByTagName("ServerPort")[0].firstChild.data
		SERVER_URL = DOMTree.getElementsByTagName("TestLinkURL")[0].firstChild.data
		devKey = DOMTree.getElementsByTagName("DevKey")[0].firstChild.data
		self.server = xmlrpclib.Server(SERVER_URL)
		self.devKey = devKey 
		
	def getInfo(self):
		return self.server.tl.about()

	def getProjects(self):
		data = {"devKey":self.devKey}
		return self.server.tl.getProjects(data)

	def getProjectTestPlans(self,tpid):
		data = {"devKey":self.devKey, "testprojectid":tpid}
		return self.server.tl.getProjectTestPlans(data)

	def getTestCasesForTestPlan(self, tpid, buildid):
		data = {"devKey":self.devKey, "testplanid":tpid, "buildid":buildid}
		return self.server.tl.getTestCasesForTestPlan(data)

	def createBuild(self, tpid , buildname):
		data = {"devKey" :self.devKey,  "testplanid" :tpid, "buildname":buildname}
		return self.server.tl.createBuild(data)

	def reportTCResult(self, tcid, tpid, status, buildid):
		data = {"devKey":self.devKey, "testcaseid":tcid, "testplanid":tpid, "status":status, "buildid":buildid}
		return self.server.tl.reportTCResult(data)

def main():
	client = TestlinkAPIClient()
	parser = optparse.OptionParser(description="*** A Standalone tool which integrate with Testlink ***",
					version="*** AUTHOR - Arjun ***"'\n'
                                   		 "%prog version-1.0",
                                  	usage='%prog  arguments')
	parser.add_option("--getProjects",action="store", nargs=0, dest="gproj",
			help = "List all the projects in the Testlink")
	parser.add_option("--getProjectTestPlans",action="store", type="int", dest="tpid",
			help = "List all the projects Test plans given a testproject id as argument")
	parser.add_option("--createBuild", action="store", nargs=2, dest="buildName",
			help = "Create a New build for a specific test plan")
	parser.add_option("--getTestCasesForTestPlan",action="store",nargs=2, dest="tplanid",
			help = "Get all the Test cases given a TestPlan id")
	parser.add_option("--updateResult", action="store", nargs=4, dest="tcResult",
			help = "Update the results for Test cases")
	options, arguments = parser.parse_args()
 	if options.tpid:
		print "In getProjectTestPlans" 
		result = client.getProjectTestPlans(options.tpid)
		print result
		sys.exit(0)		
	if options.tplanid:
		print "In getTestCasesForTestPlan" 
		result = client.getTestCasesForTestPlan(tpid=options.tplanid[0],buildid=options.tplanid[1])
		print result
		sys.exit(0)		
	if options.buildName:
		result = client.createBuild(tpid=options.buildName[0],buildname=options.buildName[1])
		# The return type is mixed structure i.e this API will return a dictionary nested in a list data type.
		resultDict = result[0]
		if len(resultDict) == 4:
			print resultDict['id']
			sys.exit(resultDict['id'])
		else:
			print "Error"
			sys.exit(-1) 
	if options.tcResult:
		result = client.reportTCResult(tcid=options.tcResult[0], tpid=options.tcResult[1], status=options.tcResult[2], buildid=options.tcResult[3])
		# The return type is mixed structure i.e this API will return a dictionary nested in a list data type.
		resultDict = result[0]
		if len(resultDict) == 4: 
			sys.exit(0);
		else:
			print "Error"
			sys.exit(-1);
	if len(options.gproj) == 0:
		print "In getProjects"
		result = client.getProjects()
		print result
		sys.exit(0)		
main()	
