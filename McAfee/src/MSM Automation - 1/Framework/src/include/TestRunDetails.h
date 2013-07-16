/*
 *  Created by jayaram  on 18/04/10.
 *  Copyright (C) 2010 McAfee Inc. All rights reserved.
 *
 */
#ifndef TESTRUNDETAILS_H
#define TESTRUNDETAILS_H
#include <string>
#include <vector>
#include <iostream>
#include <sstream>
#include <boost/archive/text_oarchive.hpp>
#include <boost/archive/text_iarchive.hpp>
#include <boost/serialization/vector.hpp>
namespace TestAutomationFramework
{

/** This class will provide details of a single test Run and it's status  */
class TestRunStatus
{

public:
	
    TestRunStatus(){}
    
	~TestRunStatus(){}
	
    friend class boost::serialization::access;
	
    template<class Archive>
	void serialize(Archive & ar, const unsigned int version)
	{
		ar & m_runId ;
		ar & m_status;
        ar & m_request;
	};
    
    int getRunId()
    {
        return m_runId;
    }
    
    void setRunId(int runid)
    {
        m_runId =runid;
    }
    
    TEST_RUN_STATUS getRunStatus()
    {
        return m_status;
    }
    
    void setRunStatus(TEST_RUN_STATUS status)
    {
        m_status = status;
    }
    
    void setTestRequest(TestExecutionRequest &tReq)
    {
        m_request = tReq;
    }
    
    TestExecutionRequest & getTestRequest()
    {
        return m_request;
    }
    
    friend ostream & operator<<(ostream & stream,TestRunStatus &trs)
    {   
        string status;
        switch (trs.m_status) {
            case STARTING:
                status="Starting";
                break;
            case RUNNING:
                status="Running";
                break;
            case STOPPED:
                status="Stopped";
                break;
            case COMPLETED:
                status="Completed";
                break;
            default:
                status="Invalid";
                break;
        }
        stream<<endl<<"RunID="<<trs.getRunId()<<" Status="<<status<<endl<<"TestRequestDetails"<<endl;
        stream<<trs.m_request;
        return stream;
    }
private:
    /** \brief Id of the run */
	int m_runId;
    /** \brief status of the run */
	TEST_RUN_STATUS m_status;
    /** \brief The request which triggered this run */
    TestExecutionRequest m_request;

};

/** \brief This class will provide data about all the Test runs which are in progress in the Test Rig */
class TestRunDetails
{
    public:
	
	TestRunDetails(){}
	~TestRunDetails(){}
	TestRunDetails (char *pBuf)
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
	const char* getStreamDataForRunStats()
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
	void addTestRunStatus(TestRunStatus runStats){m_testRunVector.push_back(runStats);}
	
    vector<TestRunStatus>& getAllTestRuns(){return m_testRunVector; }
	
    friend ostream & operator<<(ostream & stream, TestRunDetails & trd)
    {
        for (int i = 0 ; i < trd.m_testRunVector.size() ;i++)
        {
            stream << trd.m_testRunVector[i];
        }
        if(trd.m_testRunVector.size() == 0)
        {
            stream << "There are no runs"<<endl;
        }
        return stream;
    }
private:
	vector<TestRunStatus>    m_testRunVector;
	
	friend class boost::serialization::access;
	template<class Archive>
	void serialize(Archive & ar, const unsigned int version)
	{
		ar & m_testRunVector;
	};
};
};// End of namespace
#endif