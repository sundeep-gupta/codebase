#include <iostream>

struct Record {
    int val;
    struct Records *next;
    struct Records *prev;
};
struct Record *current = NULL;

void add_node(int i){
    struct Records *p = (struct Records *) malloc(sizeof(struct Records *));
    p->val = i;
    p->next = NULL;
    p->prev = NULL;
    
    if(current == NULL) {
        current = p;
        return;
    }

    current->next = p;
    p->next = current;
    p->prev = current;
    current->prev = p
}

void del_node(int i) {

}
void search_node(int i){

}

int main() {
    add_node(2);
}
