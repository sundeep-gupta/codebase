#ifndef _CIRCULAR_LINK_LIST_
#define _CIRCULAR_LINK_LIST_
#include <iostream>
#include <string>
#include <malloc.h>
#include <List.h>
using namespace std;

template<class T>
class CircularList : public List<T> {

public :
    void add(const T& element) {
        Node<T> *n = new Node<T>(element);
        if (this->head == NULL) {
            this->head = this->tail = n;
            // TODO: if one node.. circular reference to same node.
            return;
        }
        n->setNext(this->head);
        this->tail->setNext(n);
        this->tail = n;
    }

    void del(const T& element) {
        // Good if found first;
        if (this->head == NULL) {
            return;
        }

        Node<T> *c = this->head;
        // if element is first node.
        if (c->getVal() == element) {

            // and if the only node, then assign NULL to head and tail.
            if(c->getNext() == NULL) {
                delete c;
                this->head = this->tail = NULL;
                return;
            }
            // If there are other nodes, then change the pointer to head.
            this->head = this->head->getNext();
            this->tail->setNext(this->head);
            delete c;
            return;
        }
        // if no match and only one element .. then we return back.
        else if( this->head == this->tail ) {
            // we only have one node and is not matching.. so return;
            return;
        }

        // we did not find element so far by checking first node.
        do {
            if (c->getNext()->getVal() == element) {
                // delete the node.
                Node<T> *tmp = c->getNext();

                // if only two elements in circular list...
                if (c->getNext()->getNext() == c) {
                    c->setNext(NULL);
                    this->tail = c;
                } else {
                    c->setNext(c->getNext()->getNext());
                }
                delete tmp;
                return;
            }
            c = c->getNext();
        } while (this->head != c);
        return ;
    }
    void print() {
        Node<T> *c = this->head;
        if(this->head == NULL) {
            return;
        }
        do {
            cout << c->getVal() << endl;
            c = c->getNext();
        } while( c != this->head);
    }
};
#endif




