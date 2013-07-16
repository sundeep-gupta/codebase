#ifndef _LIST_H
#define _LIST_H
#include <iostream>
using namespace std;
/* List data structure add and remove nodes */
template <class T>
    class Node {
        T val;
        Node *next;
    public :
        Node(const T& val) {
            this->val = val;
            next = NULL;
        }
        T getVal() { return val; }
        Node* getNext() { return next; }
        void setNext(Node* next) { this->next = next; }
    };


template<class T>
class List {
protected :
    Node<T> *head, *tail;
public :
    List();
    void append(const T& element);
    void print();
};


/* List data structure add and remove nodes */
template<class T>
List<T>::List() : head(NULL), tail(NULL) { }

template<class T>
void List<T>::append(const T& element) {
    Node<T> *n = new Node<T>(element);
    if(tail == NULL) {
        this->head = this->tail = n;
    } else {
        tail->setNext(n);
        tail = tail->getNext();
    }
}

template<class T>
void List<T>::print() {
    Node<T> *itr = this->head;
    if(itr == NULL) {
        return; // no elements to print
    }
    do {
        cout << itr->getVal() << endl;
        itr = itr->getNext();
    } while(itr != NULL);

}
#endif

