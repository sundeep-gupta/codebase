/************************************************************************
 * CLIMain.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/
#include <UDPClient.h>
#include <TestNode.h>
#include <TestExecutionRequest.h>
#include  <TestNodeDetails.h>
#include  <TestRunDetails.h>
#include <stdio.h>
#include <MSGHeader.h>
#include <iostream>
#include <stdlib.h>

#define DELIMITER ","

using namespace TestAutomationFramework ;

void Usage()
{
	cout <<"***** USAGE *****"<<endl;
	cout<<"1--> NodeAdditionRequest <ServerIP> <ServerPort> <hostName> <hostIp>  <osName> <osVersion> <nodeType>" << endl
	<<"2 --> NodeDeletionRequest <ServerIP> <ServerPort> <hostName>" << endl
	<<"3 --> NodeListRequest <ServerIP> <ServerPort>" << endl
	<<"4 --> StartTestRequest <ServerIP> <ServerPort> <hostName1,hostName2> <suiteType> <testURL> <BuildNum> <testSuiteName1,testSuiteName2> <SvnURL> <emailId1,emailId2> <testType>" << endl
	<<"5 --> StopTestRequest <ServerIP> <ServerPort> <runId>" << endl
	<<"6 --> ListTestRuns <ServerIP> <ServerPort>"<<endl
	<< endl
	<< "For more details on any above command, use command \"harnessCLI help <commandNumber>\".  For example, use command \"harnessCLI help 1\" if you need more details about NodeAdditionRequest command" << endl
	<< endl;
	
}

void detailedUsage(int commandHelpOption)
{
	if(commandHelpOption == 1)
	{
		cout << "***** Detailed Usage for 1 --> NodeAdditionRequest <ServerIP> <ServerPort> <hostName> <hostIp>  <osName> <osVersion> <nodeType> *****" << endl
		<< "Comments:  Use this command to add a client node to the test rig" << endl
		<< endl
		<< "<ServerIP> --> Enter Machine IP address where TAF Server is installed" << endl
		<< "<ServerPort> --> Enter port number for TAF server (default is 9000)" << endl
		<< "<hostName> --> Enter TAF client host name to be added" << endl
		<< "<hostIp> --> Enter TAF client host IP address" << endl
		<< "<osName> --> Enter OS name in the TAF client" << endl
		<< "<osVersion> --> Enter OS version in the TAF client" << endl
		<< "<nodeType> --> Private nodeType will be supported in future.  Enter 0 or 1 for now" << endl << endl;
	}
	else
	if(commandHelpOption == 2)
	{
		cout << "***** Detailed Usage for 2 --> NodeDeletionRequest <ServerIP> <ServerPort> <hostName> *****" << endl
		<< "Comments:  Use this command to delete a client node from the test rig" << endl
		<< endl
		<< "<ServerIP> --> Enter Machine IP address where TAF Server is installed" << endl
		<< "<ServerPort> --> Enter port number for TAF server (default is 9000)" << endl
		<< "<hostName> --> Enter TAF client host name to be deleted" << endl << endl;
	}
	else
	if(commandHelpOption == 3)
	{
		cout << "***** Detailed Usage for 3 --> NodeListRequest <ServerIP> <ServerPort> *****" << endl
		<< "Comments:  Use this command to get list of all client nodes in the test rig" << endl
		<< endl
		<< "<ServerIP> --> Enter Machine IP address where TAF Server is installed" << endl
		<< "<ServerPort> --> Enter port number for TAF server (default is 9000)" << endl << endl;
	}
	else
	if(commandHelpOption == 4)
	{
		cout << "***** Detailed Usage for 4 --> StartTestRequest <ServerIP> <ServerPort> <hostName1,hostName2> <suiteType> <testURL> <BuildNum> <testSuiteName1,testSuiteName2> <SvnURL> <emailId1,emailId2> <testType> *****" << endl
		<< "Comments:  Use this command to start a test to be run on multiple clients.  You will get runId after this command is executed" << endl
		<< endl
		<< "<ServerIP> --> Enter Machine IP address where TAF Server is installed" << endl
		<< "<ServerPort> --> Enter port number for TAF server (default is 9000)" << endl
		<< "<hostName1,hostName2> --> Enter TAF client host name/names where this test need to be run" << endl
		<< endl
		<< "<suiteType> --> Enter type of suite tests for this test.  The valid values are below:" << endl
		<< "\t 0 - This test is for Unit Testing" << endl
		<< "\t 1 - This test is for BVT" << endl
		<< "\t 2 - This test is for FVT" << endl
		<< "\t 3 - This test is for WhiteBox" << endl
		<< endl
		<< "<testURL> --> Enter the URL containing the deliverables for which the test need to be run.  Possible values:" << endl
		<< "\t UnitTest:  Provide URL (tar or zip file) containing the UT binaries" << endl
		<< "\t BVT: Provide URL containing the installers (For example, provide dmg URL for Mac)" << endl
		<< "\t FVT: Provide URL containing the installers (For example, provide dmg URL for Mac)" << endl
		<< "\t WhiteBox: " << endl
		<< endl
		<< "<BuildNum> --> Enter the build number for the deliverables being tested.  Possible values:" << endl
		<< "\t UnitTest: Enter the build number for the component (For example, provide build number for AppPro in Mac if AppPro is unit-tested)" << endl
		<< "\t BVT: Enter the build number for the installer (For example, provide build number for MSC in Mac)" << endl
		<< "\t FVT: Enter the build number for the installer (For example, provide build number for MSC in Mac)" << endl
		<< "\t WhiteBox: " << endl
		<< endl
		<< "<testSuiteName1,testSuiteName2> --> Enter plan names which contains the testcases to be tested.  The corresponding <testSuiteName*>.xml should be available in TestAutomation/Testplans folder" << endl
		<< "<SvnURL> --> Provide complete http/https Svn path where testplans/testcases are available.  For example, provide TOPS repository path for Mac" << endl
		<< "<emailId1,emailId2> --> Provide email ids where the result need to be sent.  Note that this will work only when STAF email configuration is done" << endl
		<< "testType> --> Enter 0 if you do not want results to be reported to testlink.  Otherwise, enter 1" << endl << endl;
	}
	else
	if(commandHelpOption == 5)
	{
		cout << "***** Detailed Usage for 5 --> StopTestRequest <ServerIP> <ServerPort> <runId> *****" << endl
		<< "Comments:  Use this command to stop a test request already running by providing runId" << endl
		<< endl
		<< "<ServerIP> --> Enter Machine IP address where TAF Server is installed" << endl
		<< "<ServerPort> --> Enter port number for TAF server (default is 9000)" << endl
		<< "<runId> --> Enter runId for which test need to be stopped.  The runId can be obtained by using command Option 6 --> ListTestRuns" << endl << endl;
	}
	else
	if(commandHelpOption == 6)
	{
		cout << "***** Detailed Usage for 6 --> ListTestRuns <ServerIP> <ServerPort> *****" << endl
		<< "Comments:  Use this command to get list of all test runs in the test rig" << endl
		<< endl
		<< "<ServerIP> --> Enter Machine IP address where TAF Server is installed" << endl
		<< "<ServerPort> --> Enter port number for TAF server (default is 9000)" << endl << endl;
	}
}

int NodeAdditionRequest(int argc,char**argv)
{
	if(argc<9)
	{
		printf("NodeAdditionRequest  <ServerIP> <ServerPort> <hostName> <hostIp>  <osName> <osVersion> <nodeType>\n");
		return 0;
	}
	
	TestNode testnodeObject;
	testnodeObject.setNodeHostName(argv[4]);
	testnodeObject.setNodeHosIp(argv[5]);
	testnodeObject.setOsName(argv[6]);
	testnodeObject.setOsVersion(argv[7]);
	testnodeObject.setNodeType((eNodeType)atoi(argv[8]));
	TestAutomationFramework::UDPClient  uclient(atoi(argv[3]),argv[2]);
	TestAutomationFramework::MessageType t;
	const char *pBuf=testnodeObject.getStreamDataTestNode();
	if(!pBuf)
	{
		cout<<"creation of string stream failed"<<endl;
		return 0;
	}
	MSGHeader hdr;
	hdr.m_type = NODE_ADDITION_REQUEST;
	hdr.m_dataSize=strlen(pBuf);
	uclient.sendDataToServer(sizeof (MSGHeader),(char *)&hdr);
	uclient.sendDataToServer(hdr.m_dataSize,(char *)pBuf);
	size_t dataSize;
	t = uclient.getMessagesFromServer(dataSize);
	if(t == TestAutomationFramework::NODE_ADDITION_RESPONSE)
	{
		bool result=false;
		uclient.getDataFromServer(dataSize, (char *)&result);
		if(result)
		{
			cout << "Node has been added successfully " << endl;
		}
		else 
		{
			cout << "Node addition failed " << endl;
		}
		
	}
	
}
int NodeDeleteRequest(int argc, char**argv)
{
	if(argc<5)
	{
		printf(" NodeDeletionRequest <ServerIP> <ServerPort> <hostName>\n");
		return 0;
	}
	TestAutomationFramework::UDPClient  uclient(atoi(argv[3]),argv[2]);
	TestAutomationFramework::MessageType t;
	string hostName(argv[4]);
	printf("Hostname = %s\n",hostName.c_str());
	MSGHeader hdr;
	hdr.m_type = NODE_DELETION_REQUEST;
	hdr.m_dataSize=strlen(hostName.c_str());
	uclient.sendDataToServer(sizeof (MSGHeader),(char *)&hdr);
	uclient.sendDataToServer(strlen(hostName.c_str()),(char *)hostName.c_str());
	size_t dataSize;
	t = uclient.getMessagesFromServer(dataSize);
	if(t == TestAutomationFramework::NODE_DELETION_RESPONSE)
	{
		bool result=false;
		uclient.getDataFromServer(dataSize, (char *)&result);
		if(result)
		{
			cout << "Node has been deleted successfully " << endl;
		}
		else 
		{
			cout << "Node deletion failed " << endl;
		}    
	}
	
}

int NodeListRequest(int argc ,char **argv)
{
	if(argc<4)
	{
		printf(" NodeListRequest <ServerIP> <ServerPort>\n");
		return 0;
	}
	TestAutomationFramework::UDPClient  uclient(atoi(argv[3]),argv[2]);
	TestAutomationFramework::MessageType t;
	MSGHeader hdr;
	hdr.m_type = NODE_LIST_REQUEST;
	hdr.m_dataSize=0;
	uclient.sendDataToServer(sizeof (MSGHeader),(char *)&hdr);
	size_t dataSize;
	t = uclient.getMessagesFromServer(dataSize);
	if(!dataSize)
	{
		cout<<"data size received is zero"<<endl;
		return 0;
	}
	char *buf=new char [dataSize];
	if(!buf)
		return 0;
	memset(buf,0,dataSize);
	if(t == TestAutomationFramework::NODE_LIST_RESPONSE)
	{
		uclient.getDataFromServer((dataSize), buf);
		TestNodeDetails testnNodeDetails(buf);
		if(testnNodeDetails.getTestNodeList().empty() != true)
		{
			cout << "NodeId\tHostName\tNodeIP\t\tOSName\tOSVersion\tNodeType\tNodeStatus"<<endl;
			for(vector<TestNode> ::iterator itr= testnNodeDetails.getTestNodeList().begin();itr!=testnNodeDetails.getTestNodeList().end();itr++)
			{
				TestNode t = *itr;
				cout << t;
			}
		}
		else {
			cout << "There are no test nodes in the rig" <<endl;
		}
		
	}
	else
	{
		delete [] buf;
		return 0;
	}
	delete [] buf;
}

int StartTestRequest(int argc, char **argv)
{
	if(argc<12)
	{
		printf("StartTestRequest <ServerIP> <ServerPort> <hostName1,hostName2> <suiteType> <testURL> <BuildNum> <testSuiteName1,testSuiteName2> <SvnURL> <emailId1,emailId2> <testType>\n ");
		return 0;
	}
	
	TestExecutionRequest testExecRequest;
	
	char *ptr;
	ptr=strtok(argv[4],DELIMITER);
	while(ptr!=NULL)
	{
		testExecRequest.setHostNames(ptr);
		ptr=strtok(NULL,DELIMITER);
	}
	ptr=strtok(argv[8],DELIMITER);
	while(ptr!=NULL)
	{
		testExecRequest.setTestNames(ptr);
		ptr=strtok(NULL,DELIMITER);
	}
	
	testExecRequest.setSuiteType((eSuiteType)atoi(argv[5]));
	testExecRequest.setTestURLPath(argv[6]);
	testExecRequest.setBuildNum(atoi(argv[7]));
	
	string svnPath(argv[9]);
	svnPath += "/TestAutomation";
	testExecRequest.setSvnPath(svnPath);

	ptr=strtok(argv[10],DELIMITER);
	while(ptr!=NULL)
	{
		testExecRequest.setEmailId(ptr);
		ptr=strtok(NULL	,DELIMITER);
	}
	testExecRequest.setTestType((eTestType)atoi(argv[11]));
	
	TestAutomationFramework::UDPClient  uclient(atoi(argv[3]),argv[2]);
	TestAutomationFramework::MessageType t;
	const char *pBuf=testExecRequest.getStreamDataForTestExecutionRequest();
	if(!pBuf)
	{
		cout<<"creation of string stream failed"<<endl;
		return 0;
	}
	MSGHeader hdr;
	hdr.m_type = START_TEST_REQUEST;
	hdr.m_dataSize=strlen(pBuf);
	
	uclient.sendDataToServer(sizeof (MSGHeader),(char *)&hdr);
	uclient.sendDataToServer(hdr.m_dataSize,(char *)pBuf);
	size_t dataSize;
	t = uclient.getMessagesFromServer(dataSize);
	if(!dataSize)
	{
		cout<<"StartTestRequest Failed"<<endl;
		return 0;
	}
	char *buffer=new char [dataSize];
	if(!buffer)
		return 0;
	if(t == TestAutomationFramework::START_TEST_RESPONSE)
	{
		uclient.getDataFromServer(dataSize, buffer);
	}
	else
	{
		delete [] buffer;
		return 0;
	}
	TestRunDetails trd(buffer);
	cout << trd;
	delete [] buffer;
}

int StopTestRequest(int argc,char **argv)
{
	if(argc<5)
	{
		printf("StopTestRequest <ServerIP> <ServerPort> <runId>");
		return 0;
	}
	TestAutomationFramework::UDPClient  uclient(atoi(argv[3]),argv[2]);
	TestAutomationFramework::MessageType t;
	int runId=atoi(argv[4]);
	MSGHeader hdr;
	hdr.m_type = STOP_TEST_REQUEST;
	hdr.m_dataSize=sizeof(int);
	uclient.sendDataToServer(sizeof (MSGHeader),(char *)&hdr);
	uclient.sendDataToServer(hdr.m_dataSize,(char *)&runId);
	size_t dataSize;
	t = uclient.getMessagesFromServer(dataSize);
	if(t == TestAutomationFramework::STOP_TEST_RESPONSE)
	{
		bool result=false;
		uclient.getDataFromServer(dataSize, (char *)&result);
		if(result)
		{
			cout << "Test Run has been successfully stopped" << endl;
		}
		else 
		{
			cout << "Test Run could not be stopped " << endl;
		}      
	}
}

int ListTestRuns(int argc ,char **argv)
{
	if(argc<4)
	{
		printf("ListTestRuns <ServerIP> <ServerPort>\n");
		return 0;
	}
	TestAutomationFramework::UDPClient  uclient(atoi(argv[3]),argv[2]);
	TestAutomationFramework::MessageType t;
	MSGHeader hdr;
	hdr.m_type = LIST_TESTS_REQUEST;
	hdr.m_dataSize=0;
	uclient.sendDataToServer(sizeof (MSGHeader),(char *)&hdr);
	size_t dataSize;
	t = uclient.getMessagesFromServer(dataSize);
	if(!dataSize)
	{
		cout<<"ListTestRuns is empty"<<endl;
		return 0;
	}
	char *buf=new char [dataSize];
	if(!buf)
		return 0;
	if(t == TestAutomationFramework::LIST_TESTS_RESPONSE)
	{
		uclient.getDataFromServer((dataSize), buf);
	}
	else
	{
		delete [] buf;
		return 0;
	}
	TestRunDetails trd(buf);
	cout << trd;
	delete [] buf;
}

int main(int argc, char ** argv)
{
	if (argc < 2)
	{
		Usage();
		return 1;
	}
	if(!strcmp(argv[1],"help"))
	{
		if(argc == 2)
		{
			cout << "Enter command number as additional argument for which more help is required.  Below are the valid command line options/numbers:" << endl
			<< endl;
			Usage();
		}
		else
			detailedUsage(atoi(argv[2]));
		
		return 1;
	}
	switch(atoi(argv[1]))
	{
		case 1:
			NodeAdditionRequest( argc, argv);
			break;
		case 2:
			NodeDeleteRequest(argc,argv);
			break;
		case 3:
			NodeListRequest(argc,argv);
			break;
		case 4:
			StartTestRequest(argc,argv);
			break;
		case 5:
			StopTestRequest(argc,argv);
			break;
		case 6:
			ListTestRuns(argc,argv);
			break;
		default:
		{
			cout << "Unknown command"<< endl;
			break;	
		}
	}
	
	
}


