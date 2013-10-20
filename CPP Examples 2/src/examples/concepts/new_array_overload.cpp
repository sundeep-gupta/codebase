#include <iostream>
#include <malloc.h>
using namespace std;

class new_overload {
    int i;
public  :
    new_overload() { 
    }
    ~new_overload() { cout << "Destructor called" << endl; }

    void* operator new(size_t s) {
        cout << "In the size_t new" << endl;
        void *p = malloc(s);
        if (p == NULL) {
            throw "Unable to allocate memory";
        }
        return p;
    }
     void* operator new[](size_t s) {
        cout << "In the size_t new[] " << endl;
        void *p = malloc(s);
        if (p == NULL) {
            throw "Unable to allocate memory";
        }
        return p;
    }

    void operator delete(void* s) {
        cout << "Called delete" << endl;
        free(s);
        s = NULL;
        return;
    }
    void operator delete[] (void* s) {
        cout << "Called delete[] " << endl;
        free(s);
        s = NULL;
        return;
    }
    void print() { cout << "Method called\n"; }
    void getI() { cout << "Print i " << i << endl; }
};

int main() {
    new_overload *o = new new_overload();
    new_overload *oa = new new_overload[4];
    oa[0] = new_overload();
    oa[1] = new_overload();
    oa->print();
}
