/*
 *  Created by jayaram  on 18/04/10.
 *  Copyright (C) 2010 McAfee Inc. All rights reserved.
 *
 */

#ifndef TESTNODEDETAILS_H
#define TESTNODEDETAILS_H
#include<TestNode.h>
#include <boost/archive/text_oarchive.hpp>
#include <boost/archive/text_iarchive.hpp>
#include <boost/serialization/vector.hpp>
namespace TestAutomationFramework
{
using namespace std;
class TestNodeDetails
{
public:
	TestNodeDetails(){}
	TestNodeDetails (char *pBuf)
	{
		stringstream oss;
		oss<<pBuf;
		boost::archive::text_iarchive ia(oss);
		ia>>(*this);
	}
    const char* getStreamDataTestNodeDetails()
	{
		stringstream oss;
		boost::archive::text_oarchive oa(oss);
        oa<<(*this);
		stringbuf *pbuf;
		pbuf=oss.rdbuf();
		return pbuf->str().c_str();
	}
	
	void SetTestNode(TestNode tetNode){m_testNodeList.push_back(tetNode);}
	
	vector<TestNode> &getTestNodeList(){return m_testNodeList;}
	
	

private:
	vector<TestNode>m_testNodeList; 
	friend class boost::serialization::access;
	template<class Archive>
	void serialize(Archive & ar, const unsigned int version)
	{
		ar & m_testNodeList;
		
	};
	
};
}; //end of name space

#endif