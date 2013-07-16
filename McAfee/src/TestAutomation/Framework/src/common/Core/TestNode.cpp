/************************************************************************
* TestNode.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
* Copyright (C) 2010 McAfee Inc. All rights reserved. 
************************************************************************/

#include "TestNode.h"
namespace TestAutomationFramework
{

// Constructors/Destructors
//  


TestNode::~TestNode ( ) { }
bool 
TestNode::operator==(TestNode node)
{
    return  (  
			(node.m_hostname==m_hostname) &&
			(node.m_hostIp==m_hostIp) &&
			(node.m_osName==m_osName) &&
			(node.m_osVersion==m_osVersion)&&
			(node.m_nodeType==m_nodeType)
			);
	
}



}; // End of namespace
