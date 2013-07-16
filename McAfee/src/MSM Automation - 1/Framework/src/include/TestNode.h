/************************************************************************
* TestNode.h - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/


#ifndef TESTNODE_H
#define TESTNODE_H
#include <string>
#include <vector>
#include <iostream>
#include <sstream>
#include <boost/archive/text_oarchive.hpp>
#include <boost/archive/text_iarchive.hpp>
#include <boost/serialization/vector.hpp>
using namespace std;
namespace TestAutomationFramework
{

/**
  * class TestNode
  * This class represents a test node. It will encapsulate all the data pertaining
  * to a test node like
  * * Node host name
  * * Node IP
  * * Architecture
  * * Operating System name
  * * Operating System version
  * * Status of Node ( Offline,Free,Busy)
  * 
  */

enum eNodeType
{
	ePublicNode=0,
	ePrivateNode
};
enum eNodeStatus
{
	eOffline=0,
	eFree=1,
	eBusy=2
};
class TestNode
{
public:

    // Constructors/Destructors
    //  

    TestNode():
        m_nodeid(-1),
        m_nodeType(ePublicNode),
        m_nodeStatus(eFree)
    {}
    /**
     * Empty Constructor
     */
    TestNode (int nodeid){m_nodeid=nodeid;}
	
	/**
     * Constructor passing char pointer
     */
    TestNode (char *pBuf)
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
    const char* getStreamDataTestNode()
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
     * Empty Destructor
     */
    virtual ~TestNode ( );
	/**
     * getHostName
     */
	string getHostName(){return m_hostname;}
	
	/**
     * getHostIp
     */
	string getHostIp(){return m_hostIp;}
	
    /**
     * getOsName
     */
	string getOsName(){return m_osName;}
	
	/**
     * getOsVerison
     */
	string getOsVerison(){return m_osVersion;}
	
	/**
     * getNodeType
     */
	eNodeType getNodeType(){return m_nodeType;}
	
	/**
     * getNodeStatus
     */
	eNodeStatus getNodeStatus(){return m_nodeStatus;}
	/**
     * getNodeId
     */
	int getNodeId(){return m_nodeid;}
	
	/**
     * setNodeId
     */
	void setNodeId(int nodeId){m_nodeid=nodeId;}
	/**
     * setNodeHostName
     */
	
	void setNodeHostName( string hostName){m_hostname=hostName;}
	
	/**
     * setNodeHostIp
     */
	
	void setNodeHosIp( string hostIp){m_hostIp=hostIp;}
 	/**
     * setOsName
     */
	void setOsName( string osName){m_osName=osName;}
	/**
     * setOsVersion
     */
	void setOsVersion( string osVesrion){m_osVersion=osVesrion;}
	/**
     * setNodeType
     */
	void setNodeType(eNodeType nodeType){m_nodeType=nodeType;}
	
	/**
     * setNodeStatus
     */
	void setNodeStatus(eNodeStatus nodeStatus){m_nodeStatus=nodeStatus;}
	
    bool operator==(TestNode node);
    
    friend ostream & operator<<(ostream & stream,TestNode &t)
    {
        string status;
        switch (t.m_nodeStatus)
        {
            case eOffline:
                status="Offline";
                break;
            case eBusy:
                status="Busy";
                break;
            case eFree:
                status="Free";
                break;
            default:
                status="Invalid";
                break;
        }
        stream << t.m_nodeid << "\t"
               << t.m_hostname << "\t\t"
               << t.m_hostIp << "\t"
               << t.m_osName << "\t"
               << t.m_osVersion << "\t"
               << ((t.m_nodeType==ePublicNode) ? "Public": "Private") << "\t"
               << status <<endl;
            return stream;
    }
	
 private:
	int m_nodeid;
	string m_hostname;
	string m_hostIp;
	string m_osName;
	string m_osVersion;
    eNodeType m_nodeType;
	eNodeStatus m_nodeStatus;
	friend class boost::serialization::access;
	template<class Archive>
	void serialize(Archive & ar, const unsigned int version)
	{
		ar & m_nodeid;
		ar & m_hostname;
		ar & m_hostIp;
		ar & m_osName;
		ar & m_osVersion;
		ar & m_nodeType;
		ar & m_nodeStatus;
	};
	



};

}; // End of namespace
#endif // TESTNODE_H
