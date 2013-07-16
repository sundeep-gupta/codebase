/*
 *  TestcaseFinder.cpp
 *  TestAutomationFramework
 *
 *  Created by Anil Kumar on 4/19/10.
 *  Copyright (C) 2010 McAfee, Inc.  All rights reserved.
 *
 */

#include "TestcaseFinder.h"
#include "trace.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables()
namespace bfs = boost::filesystem;

namespace TestAutomationFramework
{
	
TestcaseFinderObj::TestcaseFinderObj(const string &svnCheckoutPath) 
{
	trace(serverTrace,1,"TestcaseFinderObj::TestcaseFinderObj - Invoked");

	m_testcasesMap.clear();
	m_testplansMap.clear();
	
	/** All the testcases will exist in Testcases folder inside
	the TestAutomation folder. */
	string testCasesDir = svnCheckoutPath + "/" + TEST_CASES_DIR;
	trace(serverTrace,1,"TestcaseFinderObj::TestcaseFinderObj - TestcaseDir:%s",testCasesDir.c_str());
	/** All the testplan related information will exist in Testplans
	 folder inside the TestAutomation folder. */
	string testPlansDir = svnCheckoutPath + "/" + TEST_PLANS_DIR;
	
	trace(serverTrace,1,"TestcaseFinderObj::TestcaseFinderObj - TestplanDir:%s",testPlansDir.c_str());
	/** Check for existence of Testplans and Testcases folders.  Return
	 if any of them do not exist. */
	bfs::path svnTestcasePath = bfs::initial_path();
	bfs::path svnTestplanPath = bfs::initial_path();
	
	try
	{
		svnTestcasePath = bfs::path(testCasesDir, bfs::native);
		svnTestplanPath = bfs::path(testPlansDir, bfs::native);
	}
	catch ( const std::exception & ex )
	{
		return;
	}
	catch (...)
	{
		return;
	}
	
	/** Enumerate Testcases folder and load all file entries */
	enumerateSvnDir(svnTestcasePath, m_testcasesMap);
	
	/** Enumerate Testplans folder and load all file entries */
	enumerateSvnDir(svnTestplanPath, m_testplansMap);
}	

TestcaseFinderObj::~TestcaseFinderObj()
{
	map<string, string*>::iterator bIter = m_testcasesMap.begin();
	map<string, string*>::iterator eIter = m_testcasesMap.end();
	
	for(bIter; bIter != eIter; bIter++)
		delete bIter->second;
	m_testcasesMap.clear();
	
	bIter = m_testplansMap.begin();
	eIter = m_testplansMap.end();
	
	for(bIter; bIter != eIter; bIter++)
		delete bIter->second;
	m_testplansMap.clear();
}

void TestcaseFinderObj::enumerateSvnDir(const bfs::path &svnPath, map<string, string*> &pathsMap)
{
	try
	{
		/** Check if directory. */
		if (bfs::is_directory(svnPath))
		{
			/** Iterate thru directory. */
			bfs::directory_iterator end_iter;
			for ( bfs::directory_iterator dir_itr( svnPath );
				 dir_itr != end_iter;
				 ++dir_itr )
			{
				/** Get current path. */
				bfs::path currPath = *dir_itr;
				
				/** Check whether directory entry exists and also is not symbolic link. */
				if(bfs::exists(currPath) && !bfs::symbolic_link_exists(currPath))
				{
					if(bfs::is_directory(currPath))
					{	
						/** Sub-directory found.  Recursively iterate thru sub-directory. */
						enumerateSvnDir(currPath, pathsMap);
					}
					else
					{
						/** File found.  Add pair of leaf and full path into the map. */
						string *currPathStr = new string(currPath.string());
						/** Use dynamic memory allocation for second argument but try to avoid dynamic allocation for 
						 first argument by using second argument as base.  This is done so that I can make use of
						 find function on normal string but can't use find function on string pointer. **/
						pathsMap.insert(make_pair(currPathStr->substr(currPathStr->find_last_of('/')+1), currPathStr));
					}
				}
			}
		}
		else
		{
			/** Not directory entry.  So, add pair of leaf and full path into the map. */
			string *svnPathStr = new string(svnPath.string());
			/** Use dynamic memory allocation for second argument but try to avoid dynamic allocation for 
			 first argument by using second argument as base.  This is done so that I can make use of
			 find function on normal string but can't use find function on string pointer. **/
			pathsMap.insert(make_pair(svnPathStr->substr(svnPathStr->find_last_of('/')+1), svnPathStr));
		}
	}
	catch ( const std::exception & ex )
	{
		trace(serverTrace,1,"TestcaseFinderObj:: Exception occured");
	}
	catch (...)
	{
		trace(serverTrace,1,"TestcaseFinderObj:: Exception occured");
	}
};

bool TestcaseFinderObj::getFullPath(const string &testName, testType testFileType, string &fullPath) const
{
	trace(serverTrace,1,"TestcaseFinderObj::getFullPath- Invoked %s", testName.c_str());
	string testPath("");
	
	if(testFileType == TESTPLAN)
	{
		/** Search in Testplans folder for file. */
		map<string, string*>::const_iterator findIter = m_testplansMap.find(testName);
		
		if(findIter != m_testplansMap.end())
			/** Found file.  Store the file path. */
			testPath = *(findIter->second);
		else
			/** File not found.  Return false to indicate failure. */
			return false;
	}
	else
	if(testFileType == TESTCASE)
	{
		/** Search in Testcases folder for file. */
		map<string, string*>::const_iterator findIter = m_testcasesMap.find(testName);
		
		if(findIter != m_testcasesMap.end())
			/** Found file.  Store the file path. */
			testPath = *(findIter->second);
		else
			/** File not found.  Return false to indicate failure. */
			return false;
	}
	
	fullPath = testPath;
	return true;
};


boost::mutex TestcaseFinder::m_instanceMutex;
map<string, TestcaseFinderObj*> TestcaseFinder::m_testCaseFinderObjs;

TestcaseFinderObj* TestcaseFinder::getTestcaseFinderObject(const string &svnCheckoutPath)
{
	trace(serverTrace,1,"TestcaseFinder::getTestcaseFinderObject");
	boost::mutex::scoped_lock lock(m_instanceMutex);
	
	/** Check whether finder object for given svn checkout path is already created. */
	map<string, TestcaseFinderObj* >::iterator findIter = m_testCaseFinderObjs.find(svnCheckoutPath);
	
	if(findIter != m_testCaseFinderObjs.end())
	{
		/** Finder object found.  Return the same. */
		TestcaseFinderObj* finderObj = findIter->second;
		
		if(!finderObj)
			m_testCaseFinderObjs.erase(svnCheckoutPath);
		
		return finderObj;
	}
	else
	{
		/** Finder object not found.  Create new finder object for given svn checkout path. */
		TestcaseFinderObj *newObj = new TestcaseFinderObj(svnCheckoutPath);
		
		/** Finder object created.  Add this object into the map for later use. */
		if(newObj)
			m_testCaseFinderObjs.insert(make_pair(svnCheckoutPath, newObj));
		
		return newObj;
	}
	
	return NULL;
};

void TestcaseFinder::releaseTestcaseFinderObject(const string &svnCheckoutPath)
{
	trace(serverTrace,1,"TestcaseFinder::releaseTestcaseFinderObject");
	boost::mutex::scoped_lock lock(m_instanceMutex);
	
	/** Get finder object and release/delete the finder object given svn checkout path. */
	map<string, TestcaseFinderObj* >::iterator findIter = m_testCaseFinderObjs.find(svnCheckoutPath);
	
	if(findIter != m_testCaseFinderObjs.end())
	{
		TestcaseFinderObj* finderObj = findIter->second;
		
		if(finderObj)
			delete finderObj;
		
		/** Finder object deleted.  Remove the entry from the map. */
		m_testCaseFinderObjs.erase(svnCheckoutPath);
	}
};
	
};
