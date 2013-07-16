#include "LinkListReverse.h"

Node :: Node () {
    next = NULL;
}

Node :: Node (int ip) {
    num = ip;
	next = NULL;
}

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
