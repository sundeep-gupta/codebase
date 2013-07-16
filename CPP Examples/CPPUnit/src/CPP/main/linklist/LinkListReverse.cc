/**
 * Copyright (C) 2010 McAfee Inc., All Rights Reserved.
 * author - SGupta6
 * version 1.0
 * created - 03 May 2010
 *
 */
#include "LinkListReverse.h"
namespace linklist {
/*
 * Default constructor. 
 */
Node :: Node () {
    next = NULL;
}

/*
 * Constructor to assign the number /value to the node.
 */
Node :: Node (int ip) {
    num = ip;
	next = NULL;
}


/**
 * method to reverse the given list.
 */
Node* Reverse :: reverse(Node* node) {
    Node *tmp1, *tmp2;
    tmp1 = NULL;
    Node* temp = node;
    while ( temp != NULL ) {
        tmp2 = temp->next;
        temp->next = tmp1;
        tmp1 = temp;
        temp = tmp2;
    }
    return tmp1;
}
}
/**
int main() {
    Node* mynode = new Node(1);
	mynode->next = new Node(2);
	mynode->next->next = new Node(3);
    
	Reverse* rev = new Reverse();
	Node* reversed = rev->reverse(mynode);
	if (reversed != NULL ) {
        cout << reversed->num << endl;
    }
}
*/
