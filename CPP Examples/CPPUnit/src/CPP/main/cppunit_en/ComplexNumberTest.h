
#include <cppunit/TestFixture.h>
#include <cppunit/extensions/HelperMacros.h>
#include "Complex.h"

using namespace std;
 
class ComplexNumberTest : public CPPUNIT_NS :: TestFixture
{
    CPPUNIT_TEST_SUITE (ComplexNumberTest);
	CPPUNIT_TEST (complexTest);
	CPPUNIT_TEST_SUITE_END ();
public:
    void complexTest();
};
