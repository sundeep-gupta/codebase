#ifndef LINKLIST_REVERSE_SUITE_H
#define LINKLIST_REVERSE_SUITE_H

#include <cppunit/TestFixture.h>
#include <cppunit/extensions/HelperMacros.h>
#include "LinkListReverse.h"

namespace linklist {

class LinkListReverseTestSuite : public CppUnit::TestCase {
    CPPUNIT_TEST_SUITE (LinkListReverseTestSuite);
	CPPUNIT_TEST (reverseTest);
	CPPUNIT_TEST (nullTest);
	CPPUNIT_TEST_SUITE_END();
 public:
    void setUp (void);
 	void tearDown (void);
protected :
    void reverseTest();
	void nullTest();
public :
    // Object to perform reverse operation.
    Reverse* reverser;
	Node *n1, *n2, *n3;
	Node *nullNode;
	Node *nodeToReverse;
};

};
#endif
