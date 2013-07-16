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
     * getBuildDmgPath
     */
	const string getBuildDmgPath() const {return m_buildDmgPath;}

	/**
     * getBuildNo
     */
	const int getBuildNo() const {return m_buildNo;}
	
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
     * setBuildDmgPath
     */
	
	void setBuildDmgPath( string buildDmgPath){ m_buildDmgPath=buildDmgPath;}
	
	/**
     * setBuildNo
     */
	int setBuildNo(int buildNo){ m_buildNo=buildNo;}
	
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
		 
        stream << endl << "\tBuildNo = "<<ter.m_buildNo<< endl;
        return stream;
     }

private:
	vector<string> m_testNames;
	vector<string> m_hostNames;
	string m_buildDmgPath;
	int m_buildNo;
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
		ar & m_buildDmgPath;
		ar & m_buildNo;
		ar & m_svnPath;
		ar & m_outputFileName;
        ar & m_emailId;
		ar & m_testType;
	};

};
}; // End of namespace

#endif // TESTEXECUTIONREQUEST_H
