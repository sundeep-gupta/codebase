/************************************************************************
 * TestPlan.cpp - Created by  jdivakarla on Thu Apr 15 2010 at 10:31:33
 * Copyright (C) 2010 McAfee Inc. All rights reserved. 
 ************************************************************************/

#include "TestPlan.h"
#include "LibXmlWrapper.h"
#include "TestcaseFinder.h"

#define TP_ID "/Testplan/PlanID"
#define TP_TESTCASES "/Testplan/Testcase"
#define TEST_CASES_DIR "Testcases"

#include "trace.h"
defineExternTraceFlag(serverTrace,"");
defineExternTraceVariables()

namespace TestAutomationFramework
{
	
TestPlan::TestPlan(const string& svnCheckoutPath, const string &testPlanName):
	m_svnCheckoutPath(svnCheckoutPath), 
	m_testPlanName(testPlanName)
{
	trace(serverTrace,1,"TestPlan::TestPlan - Invoked");

	m_planSequence.clear();
	m_testcaseObjMap.clear();
	m_testcaseObjs.clear();
	
	/** Construct XML path. */
	string planName = testPlanName + XML_EXT;
	
	/** Get full plan XML path by quering the TestcaseFinder object given the SVN path. The XML file
	 contains all testPlan related information.
	 */
	string fullPlanPath;
	if(!TestcaseFinder::getTestcaseFinderObject(svnCheckoutPath)->getFullPath(planName, TESTPLAN, fullPlanPath))
		return;
	
	m_planFullPath = fullPlanPath;
	
	trace(serverTrace,1,"TestPlan::TestPlan PATH - %s:",m_planFullPath.c_str());
	try
	{
		/** Get plan ID and list of all testcases comprising this testPlan.  Populate the testcase 
		 data in a map with testcase objects for internal use. */
		LibXmlWrapper xmlObj(fullPlanPath);
		m_testPlanID = xmlObj.getXPathStringValue(TP_ID);
		
		vector<string> testcasesNameVec = xmlObj.getXPathAllElement(TP_TESTCASES);
		for(int i=0; i<testcasesNameVec.size(); i++)
		{
			Testcase *tcObj = new Testcase(svnCheckoutPath, testcasesNameVec[i]);
			
			if(tcObj)
			{
				m_testcaseObjMap.insert(make_pair(testcasesNameVec[i], tcObj));
				m_testcaseObjs.push_back(tcObj);
			}
		}
	}
	catch(...)
	{
	    trace(serverTrace,1,"TestPlan::TestPlane Loading failed path - %s:",fullPlanPath.c_str());
		return;
	}
	
	/** Got required data.  Now, generate the test sequence. */
	generatePlanSequence();
}


/** This constructor will be used to generate a dummy plan object consisting of the testcases provided 
 by the user. 
*/
TestPlan::TestPlan(const string& svnCheckoutPath, const vector<string>& testCaseNames, const string& testPlanName):
	m_svnCheckoutPath(svnCheckoutPath), 
	m_testPlanName(testPlanName)
{
    trace(serverTrace,1,"TestPlan::TestPlan  Dummy Plan object - Invoked");
	m_planSequence.clear();
	m_testcaseObjMap.clear();
	m_testcaseObjs.clear();
	
	/** Dummy TestPlan ID. */
	m_testPlanID = "DummyTestPlan";
	
	/** Populate the testcase data in a map with testcase objects for internal use.  */
	for(int i=0; i<testCaseNames.size(); i++)
	{
		Testcase *tcObj = new Testcase(svnCheckoutPath, testCaseNames[i]);
		
		if(tcObj)
		{
			m_testcaseObjMap.insert(make_pair(testCaseNames[i], tcObj));
			m_testcaseObjs.push_back(tcObj);
		}
	}

	/** Got required data.  Now, generate the test sequence. */
	generatePlanSequence();
}


TestPlan::TestPlan(const TestPlan& rhs):
	m_testPlanName(rhs.m_testPlanName), 
	m_testPlanID(rhs.m_testPlanID), 
	m_svnCheckoutPath(rhs.m_svnCheckoutPath), 
	m_planFullPath(rhs.m_planFullPath)
{
	m_planSequence.clear();
	
	for(int i=0; i<rhs.m_planSequence.size(); i++)
	{
		vector<Testcase*> testVec;
		testVec.clear();
		
		for(int j=0; j<rhs.m_planSequence[i].size(); j++)
		{
			Testcase *srcTcObj = rhs.m_planSequence[i][j];
			Testcase *tcObj = new Testcase(*srcTcObj);
			
			if(tcObj)
				testVec.push_back(tcObj);
		}
		
		if(testVec.size())
			m_planSequence.push_back(testVec);
	}
}


TestPlan::~TestPlan()
{
	map<string, Testcase*>::iterator begin_iter = m_testcaseObjMap.begin();
	map<string, Testcase*>::iterator end_iter = m_testcaseObjMap.end();
	
	for(; begin_iter!=end_iter; begin_iter++)
	{
		Testcase *tcObj = begin_iter->second;
		
		if(tcObj)
			delete tcObj;
	}
	
	m_testcaseObjMap.clear();
	m_testcaseObjs.clear();
	m_planSequence.clear();
}

/** Generates test sequence taking the testcases dependency into consideration.
 For example, we have testcase dependencies as below:
 A -> B [ Meaning, testcase "A" depends on successful completion of "B" ]
 B -> C
 C
 D
 E -> B
 
 The sequence generated should be below:
 A -> B -> C  [ Lets call it as testcase "A" row ]
 B -> C
 C
 D
 E -> B -> C
 
 Each row will then be run in the reverse order which means for above example of
 A -> B -> C, C will be first run and only after successful run, B will be run and
 upon successful completion, A will be run.  If C fails, both A and B will not be run.
 
 Code will be added to make sure that each testcase will be run only once by caching
 the results.  So, while processing a sub-sequence (or row of sequence), if we encounter
 a testcase already run, we will take this result and proceed.
 
 After completion of all testcases run, the sequence will be updated with the testcase
 results.  We just need to go thru first item of each sub-sequence to get the result
 of each testcase [i.e., in the above sequence, the first item of each row are A, B, C, D,
 E, F.
 
 Below is the algorithm to generate the sequence:
 1.  For each testcase, generate a vector with only this testcase [ row creation and initialization ].
 2.  For each testcase, check whether the testcase had already been processed for sub-sequence
 generation.  If no, populate the row with dependency information as below:
	a. For each dependent testcase, check whether the dependent testcase is already in the
 row.  This is needed to check any cycles. [i.e., A->B, B->C, C->A ]
	b. If any cycles exist, empty the row and return so that only that particular sub-set of 
 testcases won't be run.
	c. Check whether this dependent testcase is already processed for sub-sequence generation.
		i.  If yes, copy the sub-sequence of the dependent testcase row into the original testcase
			row and return to the caller.
		ii. If no, repeat the above step 2 assuming dependent testcase as original testcase.
 3.  Once the row is populated, mark this testcase row as already processed so that this need
 not be re-processed for other testcases dependent on this testcase.
 4.  Generate a vector picking all the above rows [ basically vector of vectors ].
 
*/
 
void TestPlan::generatePlanSequence()
{
	trace(serverTrace,1," TestPlan::generatePlanSequence - Invoked");
	
	m_planSequence.clear();
	
	/** Iterate thru each testcase to generate a row.  We must use vector container instead
	 of map container to maintain the testcase sequence as per the testplan XML.
	 */
	for(int i=0; i<m_testcaseObjs.size(); i++)
	{
		vector<Testcase*> tcVec;
		tcVec.clear();
		
		Testcase* tcObj = m_testcaseObjs[i];
		if(!tcObj)
			continue;
		
		/** Row initialization. */
		tcVec.push_back(tcObj);
		
		/** Check whether the row had already been processed if it has
		 dependencies */
		if(!tcObj->getDepCheckComplete())
		{
			string dependsStr;
			if(tcObj->getDepends(dependsStr))
			{
				if(populateDepVec(dependsStr, tcVec))
					/** Sub-sequence generation done.  Mark it as such */
					tcObj->setDepCheckComplete(true);
				
				/** Vector was made empty because of existence of cycle.  Mark it as such. */
				if(!tcVec.size())
					tcObj->setCycleExists(true);
			}
		}
		
		/** Now, push this sub-sequence into the master sequence */
		if(tcVec.size())
			m_planSequence.push_back(tcVec);
		
		/** Print the sequence for debugging */
		string printStr = tcObj->getTestcaseName();
		printStr += "\t:\t\t";
		
		for(int j=0; j<tcVec.size(); j++)
			printStr += tcVec[j]->getTestcaseName() + "\t"; 

		trace(serverTrace,1,"Plan Sequence[%d] : %s", m_planSequence.size()-1, printStr.c_str());
	}
}


/** Populate vector with dependency information given testname.  For more info, refer
 to comments for generateTestSequence function above.
*/
bool TestPlan::populateDepVec(const string& depTestName, vector<Testcase *>& testVec)
{
	trace(serverTrace,1,"  TestPlan::populateDepVec - Invoked");
	map<string, Testcase*>::iterator findIter = m_testcaseObjMap.find(depTestName);
	
	/** Check whether given dependent testcase is valid */
	if(findIter != m_testcaseObjMap.end())
	{
		Testcase* tcObj = findIter->second;
		
		if(!tcObj)
			return true;
		
		vector<Testcase *>::iterator iter = testVec.begin();
		
		/** Iterate thru row to check for cycles in the row.  Pointer comparison is 
		 sufficient since for same testcase object, same pointer address will be maintained
		 in the sequence.
		 */
		for(; iter!=testVec.end(); iter++)
			if(*iter == tcObj)
				break;
		
		/** If cycle exists, empty the sub-sequence and return.  This means that a sub-set
		 of testcases won't be run.
		 If no cycle, just add this testcase to the row.
		 */
		if(iter != testVec.end())
		{
			testVec.clear();
			return true;
		}
		else
			testVec.push_back(tcObj);
		
		/** Now, check whether the dependent testcase has dependency and already processed.
		 If not processed, process recursively for this dependent testcase.
		 */
		if(!tcObj->getDepCheckComplete())
		{
			string dependsStr;

			if(tcObj->getDepends(dependsStr))
				return populateDepVec(dependsStr, testVec);
		}
		else
		{
			/** Check whether the dependent testcase has cyclic dependency.  This 
			 means, the original testcase will also have cycle by virtue of dependent testcase
			 having cycle and so, we should clear the sub-sequence and return.
			 */
			if(tcObj->getCycleExists())
			{
				testVec.clear();
				return true;
			}
			
			/** Sub-sequence already generated for dependent testcase.  Add this sub-sequence 
			 information to the sub-sequence of the testcase dependent on this dependent testcase.
			 In the above example, where B->C and E->B, when we process testcase B,
			 the sub-sequence for B will be filled as B->C.  Now, when we process E, we find
			 that the dependent testcase is B and so we process B.  While processing B, we 
			 find that it had already been processed with sub-sequence of B->C.  So we copy this
			 sub-sequence to the sub-sequence of testcase "E" to get E->B->C.
			 */
			if(m_planSequence.size())
			{
				vector< vector<Testcase*> >::iterator testSeqIter = m_planSequence.begin();
			
				for(; testSeqIter!=m_planSequence.end(); testSeqIter++)
				{
					vector<Testcase *> currTestVec = *testSeqIter;
					string rootTestcaseName = currTestVec[0]->getTestcaseName();
				
					if(tcObj->getTestcaseName() == rootTestcaseName)
					{
						for(int i=1; i<currTestVec.size(); i++)
							testVec.push_back(currTestVec[i]);
					}
				}
			}
		}
	}

	return true;
}	
	
}; // End of namespace
