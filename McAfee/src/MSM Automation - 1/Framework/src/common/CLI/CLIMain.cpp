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
    cout<<"1--> NodeAdditionRequest <ServerIP> <ServerPort> <hostname> <hostIp>  <osName> <osVersion> <nodeType[private: 0/public: 1]>" << endl
	<<"2 --> NodeDelitionRequest <ServerIP> <ServerPort> <hostname>" << endl
	<<"3 --> NodeListRequest <ServerIP> <ServerPort>" << endl
	<<"4 --> StartTestRequest <ServerIP> <ServerPort> <testSuiteName1,testSuiteName2> <hostName1,hostName2>  <BuildDmgURL> <BuildNum> <SVNBranch> <emailId1,emailId2>  <testType> " << endl
	<<"5 --> StopTestRequest <ServerIP> <ServerPort> <runId>" << endl
	<<"6 --> ListTestRuns <ServerIP> <ServerPort>"<<endl;
	
}

int NodeAdditionRequest(int argc,char**argv)
{
   if(argc<9)
   {
	   printf("NodeAdditionRequest  <ServerIP> <ServerPort> <hostname> <hostIp>  <osName> <osVersion> <nodeType[private: 0/public: 1]>\n");
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
	    printf(" NodeDelitionRequest <ServerIP> <ServerPort> <hostname>\n");
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
	if(argc<11)
	{
		printf("StartTestRequest  <ServerIP> <ServerPort> <testSuiteName1,testSuiteName2> <hostName1,hostName2>  <BuildDmgURL> <BuildNum> <SVNBranch> <emailId1,emailId2>  <testType>\n ");
		return 0;
	}
	
	TestExecutionRequest testExecRequest;

	char *ptr;
	ptr=strtok(argv[4],DELIMITER);
	while(ptr!=NULL)
	{
		testExecRequest.setTestNames(ptr);
		ptr=strtok(NULL,DELIMITER);
	}
	ptr=strtok(argv[5],DELIMITER);
	while(ptr!=NULL)
	{
		testExecRequest.setHostNames(ptr);
		ptr=strtok(NULL,DELIMITER);
	}
	
	testExecRequest.setBuildDmgPath(argv[6]);
	testExecRequest.setBuildNo(atoi(argv[7]));
    
    string branch(argv[8]);
    string svnpath("https://192.168.215.127/srcRepo/TOPS/");
    
    if(branch == string("HEAD") || branch == string("head") || branch == string("TRUNK") || branch == string("trunk") )
    {
        svnpath = svnpath + "trunk/TestAutomation";
    }
    else 
    {
        svnpath = svnpath + "branches/" + argv[8] + "/TestAutomation";
    }

	testExecRequest.setSvnPath(svnpath);
	ptr=strtok(argv[9],DELIMITER);
	while(ptr!=NULL)
	{
		testExecRequest.setEmailId(ptr);
		ptr=strtok(NULL	,DELIMITER);
	}
	testExecRequest.setTestType((eTestType)atoi(argv[10]));
	
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
        Usage();
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


