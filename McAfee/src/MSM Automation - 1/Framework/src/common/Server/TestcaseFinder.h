/*
 *  TestcaseFinder.h
 *  TestAutomationFramework
 *
 *  Created by Anil Kumar on 4/19/10.
 *  Copyright (C) 2010 McAfee, Inc.  All rights reserved.
 *
 */

#include <iostream>
#include <map>
#include <boost/thread/mutex.hpp>
#include <boost/filesystem/operations.hpp>
#include <boost/filesystem/path.hpp>

using namespace std;

#define TEST_CASES_DIR "Testcases"
#define TEST_PLANS_DIR "Testplans"
#define XML_EXT ".xml"

namespace TestAutomationFramework 
{
	
enum testType
{
	TESTPLAN,
	TESTCASE
};

/** The objects of the class can be used to load all file entries given 
 svn checkout path.  This information can be used to check for existence of file
 and also to get the full path.
 */
class TestcaseFinderObj
{
public:
	/** \brief Construct to create finder object.
	 */
	explicit TestcaseFinderObj(const string &svnCheckoutPath);
	
	/** \brief Empty destructor.
	 */
	virtual ~TestcaseFinderObj() {};
	
	/** \brief Method to return full path given test name.
	 Returns true if successful, otherwise return false.
	 */
	bool getFullPath(const string &testName, testType testFileType, string& fullPath) const;
	
private:
	/** \brief Making empty constructor private.
	 */
	TestcaseFinderObj();
	
	/** \brief Making assignment operator private.
	 */
	TestcaseFinderObj& operator=(const TestcaseFinderObj&);
	
	/** \brief Making copy constructor private.
	 */
	TestcaseFinderObj(const TestcaseFinderObj& rhs);
	
	/** \brief Method to enumerate svn checkout directory and load all the files in the directory.
	 This information will be used to get full path given file name.
	 */
	void enumerateSvnDir(const boost::filesystem::path &svnPath, map<string, string> &pathsMap);
	
	/** \brief Map containing testcases entries as <leaf-name, full-path> */
	map<string, string> m_testcasesMap;
	
	/** \brief Map containing testplans entries as <leaf-name, full-path> */
	map<string, string> m_testplansMap;
};


/** This singleton-like class provides interface to create single object
 for each SVN checkout path.  The idea is to provide interface for other parts
 of the code to check for existence of testcases/testplans in the svn path and
 also to get full paths.  This is made singleton-like so that the object will be
 created only once for each SVN checkout path and so, loading all the file entries
 for a given path will be one-time processing.
 We will get different SVN checkout paths scenario when there are two test runs
 with different SVN paths.
 */
class TestcaseFinder
{
public:
    /** \brief Static method to access the methods of this class
     * Returns a pointer to the object of TestcaseFinderObj class
     */
	static TestcaseFinderObj* getTestcaseFinderObject(const string &svnCheckoutPath);
	
    /** \brief Static method to release any memory held by the TestcaseFinder class.
	 */
	static void releaseTestcaseFinderObject(const string &svnCheckoutPath);
	
private:
	
	/** \brief Making default constructor private.
	 */
	TestcaseFinder();
	
	/** \brief Making assignment operator private.
	 */
	TestcaseFinder& operator=(const TestcaseFinder&);
	
	/** \brief Making copy constructor private.
	 */
	TestcaseFinder(const TestcaseFinder& rhs);
	
	/** \brief Making empty destructor private.
	 */
	virtual ~TestcaseFinder();
	
	/** \brief mutex to guard our instance */
	static boost::mutex m_instanceMutex;
	
	/** \brief container with finder objects for multiple
	 svn checkout paths.
	 */
	static map<string, TestcaseFinderObj*> m_testCaseFinderObjs;
};
	
}; // end of package namespace
