#ifndef _QUEUE_H
#define _QUEUE_H
#include <iostream>
#include <malloc.h>
#include <List.h>
using namespace std;

template <class T>
class Queue : public List<T> {
public :
    void enqueue(const T& element) {
        Node<T> *n = new Node<T>(element);

        if (this->tail == NULL) {
            this->head = this->tail = n;
            return;
        }
        this->tail->setNext(n);
        this->tail = n;
    }

    T dequeue() {
        // Good if found first;
        if (this->head == NULL) {
            throw "Empty Queue\n";
        }
        Node<T> *new_head = this->head->getNext();
        T val = this->head->getVal();
        delete this->head;
        this->head = new_head;
        return val;
    }
};

#endif
