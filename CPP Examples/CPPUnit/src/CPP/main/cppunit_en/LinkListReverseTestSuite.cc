#include "LinkListReverseTestSuite.h"

CPPUNIT_TEST_SUITE_REGISTRATION (LinkListReverseTestSuite);

void LinkListReverseTestSuite :: setUp(void) {
    reverser = new Reverse();

	n1 = new Node(100);
	n2 = new Node(234);
	n3 = new Node(4567);
	nullNode = NULL;
	nodeToReverse = n1; nodeToReverse->next = n2;
}

void LinkListReverseTestSuite :: tearDown(void) {
    delete n1;
	delete n2;
	delete n3;
	delete nodeToReverse;
	delete nullNode;
	delete reverser;
}

void LinkListReverseTestSuite :: reverseTest () {
    Node* reversedNodes = reverser->reverse(nodeToReverse);
    CPPUNIT_ASSERT ( reversedNodes->num ==  (n2->num + 1) ); 
}

void LinkListReverseTestSuite :: nullTest () {
    Node* reversed = reverser->reverse(nullNode);
    CPPUNIT_ASSERT ( reversed == NULL );
}

