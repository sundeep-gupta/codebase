#include "LinkListReverseTestSuite.h"

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

void LinkListReverserTestSuite :: reverseTest () {
    Node* reversedNodes = reverser->reverse(nodeToReverse);
    CPPUNIT_ASSERT ( reversedNodes->num ==  n2->num ); 
}

void LinkListReverserTestSuite :: nullTest () {
    Node* reversed = reverser->reverse(nullNode);
    CPPUNIT_ASSERT ( reversed == NULL );
}

