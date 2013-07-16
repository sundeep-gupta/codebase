
#include <iostream>
/* Structure that will hold the element */
struct Element {
    int value;
    struct Element *next;
};
typedef struct Element Node;

/* List data structure add and remove nodes */
class List {
  Node *node;
  Node *current;
  public :
    List() {
        this->node = NULL;
        this->current = NULL;
    }
    void append(Node *node) {
        if(current == NULL) {
            this->node = node;
            this->current = node;
        } else {
            current->next = node;
        }
    }
    void printList() {
        Node *tmp = this->node;
        while(tmp != NULL) {
            cout << tmp->value << endl;
            tmp = tmp->next;
        }
    }

}


int main() {
    List list();
    Node *node = NULL;
    node = (Node*)malloc(sizeof(Node));
    list.append(node);
    list.append(node);
    list.printList();

}
