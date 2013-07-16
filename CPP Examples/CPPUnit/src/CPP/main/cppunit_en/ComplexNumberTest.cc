
#include "ComplexNumberTest.h"

CPPUNIT_TEST_SUITE_REGISTRATION (ComplexNumberTest);

//ComplexNumberTest :: ComplexNumberTest( std::string name ) :  CPPUNIT_NS :: TestFixture( name ) {}

void ComplexNumberTest :: complexTest() {
        CPPUNIT_ASSERT( Complex (10, 1) == Complex (10, 1) );
        CPPUNIT_ASSERT( !(Complex (1, 1) == Complex (2, 2)) );
}


