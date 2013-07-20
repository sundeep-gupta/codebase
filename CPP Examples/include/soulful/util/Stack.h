#include <iostream>
#include <malloc.h>
#include <List.h>
using namespace std;

template <class T>
class Stack : public List<T> {

public :

    ~Stack() {
        Node<T> *node;
        while(node = this->head) {
            this->head = this->head->getNext();
            delete node;
        }
    }

    void push(const T& element) {
        Node<T> *n = new Node<T>(element);
        if (this->head == NULL) {
            this->head = n;
            return;
        }
        n->setNext(this->head);
        this->head = n;
    }

    T pop() {
        int error = -1;
        if (this->head == NULL) {
            return error;
        }
        Node<T> *node = this->head;
        this->head = this->head->getNext();
        T val = node->getVal();
        delete node;
        return val;
    }
};


