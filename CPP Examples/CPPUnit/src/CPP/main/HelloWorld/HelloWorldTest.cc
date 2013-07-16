#include <cppunit/TestFixture.h>
#include <cppunit/extensions/HelperMacros.h>
#include <cppunit/CompilerOutputter.h>
#include <cppunit/extensions/TestFactoryRegistry.h>
#include <cppunit/TestResult.h>
#include <cppunit/TestResultCollector.h>
#include <cppunit/TestRunner.h>
#include <cppunit/BriefTestProgressListener.h>
#include "HelloWorld.cc"
/*
 * Suite registration.
 */
class HelloWorldTest : public CppUnit::TestCase {
    CPPUNIT_TEST_SUITE (HelloWorldTest);
	CPPUNIT_TEST (testHelloWorld);
	CPPUNIT_TEST_SUITE_END();
 public:
    void setUp (void) {
        instance = new HelloWorld();
	}
 	void tearDown (void) {
	    delete instance;
	}
protected :
    void testHelloWorld() {
	    std::string expected = "HelloWorld";
        CPPUNIT_ASSERT_EQUAL(expected, instance->sayHello());
	}
public :
    // Object to perform reverse operation.
    HelloWorld* instance;

};

CPPUNIT_TEST_SUITE_REGISTRATION (HelloWorldTest);
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
	CppUnit::CompilerOutputter compileroutputter (&collectedresults, std::cerr);
	compileroutputter.write ();

    // return 0 if tests were successful
	return collectedresults.wasSuccessful () ? 0 : 1;
}
