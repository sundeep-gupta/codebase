/**
 * Copyright (C) 2010 McAfee Inc., All Rights Reserved.
 * author - SGupta6
 * version 1.0
 * created - 03 May 2010
 *
 */
#include <cppunit/TextOutputter.h>
#include <cppunit/CompilerOutputter.h>
#include <cppunit/extensions/TestFactoryRegistry.h>
#include <cppunit/TestResult.h>
#include <cppunit/TestResultCollector.h>
#include <cppunit/TestRunner.h>
#include <cppunit/BriefTestProgressListener.h>
#include <cppunit/XmlOutputter.h>

int main (int argc, char* argv[]) {
	// informs test-listener about testresults
	CppUnit::TestResult testresult;

	// register listener for collecting the test-results
	CppUnit::TestResultCollector collectedresults;
	testresult.addListener (&collectedresults);

	// register listener for per-test progress output
	CppUnit::BriefTestProgressListener progress;
	testresult.addListener (&progress);

	// insert test-suite at test-runner by registry
	CppUnit::TestRunner testrunner;
	testrunner.addTest (CPPUNIT_NS :: TestFactoryRegistry :: getRegistry ().makeTest ());
	testrunner.run (testresult);

	// output results in compiler-format
	//CppUnit::CompilerOutputter compileroutputter (&collectedresults, std::cerr);
	//compileroutputter.write ();
    //CppUnit::TextOutputter textoutputter (&collectedresults, std::cerr);
	//textoutputter.write();
	CppUnit::XmlOutputter outputter (&collectedresults, std::cerr);
	outputter.write();
	// return 0 if tests were successful
	return collectedresults.wasSuccessful () ? 0 : 1;
}
