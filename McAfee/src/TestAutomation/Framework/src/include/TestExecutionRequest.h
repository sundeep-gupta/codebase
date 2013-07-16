/************************************************************************
* TestExecutionRequest.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/


#ifndef TESTEXECUTIONREQUEST_H
#define TESTEXECUTIONREQUEST_H
#include <string>
#include <vector>
#include<sstream>
#include <boost/archive/text_oarchive.hpp>
#include <boost/archive/text_iarchive.hpp>
#include <boost/serialization/vector.hpp>
using namespace std;
namespace TestAutomationFramework
{
enum eSuiteType
{
	eUnitTest=0,
	eBVT,
	eFVT,
	eWhiteBox
};
enum eTestType
{
	ePrivateTest=0,
	ePublicTest
};
enum TEST_RUN_STATUS
{
    STARTING=1,
    RUNNING,
    STOPPED,
    COMPLETED,
    INVALID
};
class TestExecutionRequest
{
public:

    // Constructors/Destructors
    //  


    /**
     * Empty Constructor
     */
    TestExecutionRequest ( );

    /**
     * Empty Destructor
     */
    virtual ~TestExecutionRequest ( );
  
	
	TestExecutionRequest (char *pBuf)
	{
		try
		{
			stringstream oss;
			oss<<pBuf;
			boost::archive::text_iarchive ia(oss);
			ia>>(*this);
		}
		catch(...)
		{
			
		}
	}
    const char* getStreamDataForTestExecutionRequest()
	{
		try
		{
			stringstream oss;
			boost::archive::text_oarchive oa(oss);
			oa<<(*this);
			stringbuf *pbuf;
			pbuf=oss.rdbuf();
			return pbuf->str().c_str();
		}
		catch(...)
		{
			return NULL;
		}
	}
   
	/**
     * getTestNames
     */
	vector<string> getTestNames() const {return m_testNames;}
	
	/**
     * getHostNames
     */
	vector<string> getHostNames() const {return m_hostNames;}
	
	/**
     * getSuiteType
     */
	const eSuiteType getSuiteType() const {return m_suiteType;}
	
	/**
     * getTestURLPath
     */
	const string getTestURLPath() const {return m_testURLPath;}

	/**
     * getBuildNum
     */
	const int getBuildNum() const {return m_buildNum;}
	
	/**
     * getSvnPath
     */
	const string getSvnPath() const {return m_svnPath;}
		
	/**
     * getOutFileName
     */
	const string getOutFileName() const {return m_outputFileName;}
	
	/**
     * getEmailId
     */
	const vector<string>& getEmailId() const {return m_emailId;}
	
	/**
     * getTestType
     */
	const eTestType getTestType() const {return m_testType;}
	
	/**
     * setTestNames
     */
	void setTestNames( string  testNames){m_testNames.push_back(testNames);}
	
	/**
     * setHostNames
     */
	void setHostNames( string  hostNames){m_hostNames.push_back(hostNames);}
	
	/**
     * setSuiteType
     */
	void setSuiteType( eSuiteType suiteType){m_suiteType=suiteType;}

	/**
     * setTestURLPath
     */
	
	void setTestURLPath( string testURLPath){ m_testURLPath=testURLPath;}
	
	/**
     * setBuildNum
     */
	int setBuildNum(int buildNum){ m_buildNum=buildNum;}
	
	/**
     * setSvnPath
     */
	
	void setSvnPath( string svnPath){m_svnPath=svnPath;}
	
 	/**
     * setOutputFileName
     */
	void setOutputFileName( string outputFileName){m_outputFileName=outputFileName;}
	/**
     * setemailId
     */
	void setEmailId( string  emailId){m_emailId.push_back(emailId);}
	/**
     * setTestType
     */
	void setTestType( eTestType testType){m_testType=testType;}
	
	/** 
     * ostream operator
     */
     friend ostream & operator<<(ostream & stream,TestExecutionRequest &ter)
     {
        stream<<endl <<"\tTestNames = ";
        for(int i=0 ; i < ter.m_testNames.size();i++)
        {
            stream<<ter.m_testNames[i]<<" ";
        }
        
        stream <<endl<<"\tTest Hosts = ";
        for(int i=0 ; i < ter.m_hostNames.size();i++)
        {
            stream<< ter.m_hostNames[i]<<" ";
        }
		 
        stream << endl << "\tBuildNum = "<<ter.m_buildNum<< endl;
        return stream;
     }

private:
	vector<string> m_testNames;
	vector<string> m_hostNames;
	eSuiteType m_suiteType;
	string m_testURLPath;
	int m_buildNum;
	string m_svnPath;
	string m_outputFileName;
	vector<string>m_emailId;
	eTestType m_testType;
	
	friend class boost::serialization::access;
	template<class Archive>
	void serialize(Archive & ar, const unsigned int version)
	{
		ar & m_testNames;
		ar & m_hostNames;
		ar & m_suiteType;
		ar & m_testURLPath;
		ar & m_buildNum;
		ar & m_svnPath;
		ar & m_outputFileName;
		ar & m_emailId;
		ar & m_testType;
	};

};
}; // End of namespace

#endif // TESTEXECUTIONREQUEST_H
