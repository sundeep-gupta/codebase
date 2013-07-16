#include "LinkListReverseTestSuite.h"
namespace linklist {
/*
 * Suite registration.
 */
CPPUNIT_TEST_SUITE_REGISTRATION (LinkListReverseTestSuite);

/*
 * Setup the variables to be used in testing.
 */
void LinkListReverseTestSuite :: setUp(void) {
    reverser = new Reverse();

	n1 = new Node(100);
	n2 = new Node(234);
	n3 = new Node(4567);
	nullNode = NULL;
	nodeToReverse = n1; nodeToReverse->next = n2;
}

/*
 * Free those variables once done.
 */
void LinkListReverseTestSuite :: tearDown(void) {
    delete n1;
	delete n2;
	delete n3;
	delete nodeToReverse;
	delete nullNode;
	delete reverser;
}

/*
 * Test if the reverse is working properly with giving 2 node list.
 */
void LinkListReverseTestSuite :: reverseTest () {
    Node* reversedNodes = reverser->reverse(nodeToReverse);
    CPPUNIT_ASSERT ( reversedNodes->num ==  (n2->num) ); 
}

/*
 * Test reverse by passing the NULL node (zero element list).
 */
void LinkListReverseTestSuite :: nullTest () {
    Node* reversed = reverser->reverse(nullNode);
    CPPUNIT_ASSERT ( reversed == NULL );
	delete reversed;
}
}
