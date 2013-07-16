#ifndef LINKLIST_REVERSE_H
#define LINKLIST_REVERSE_H

#include <iostream>

using namespace std;

class Node {
public:
    int num;
	Node* next;
    Node();
	Node(int ip);
};

class Reverse {
public :
    Node* reverse(Node* node);
};

#endif
