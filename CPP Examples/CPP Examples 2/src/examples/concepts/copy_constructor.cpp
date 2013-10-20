#include <iostream>
using namespace std;

class array {
    int *p;
    int size;
public :
    array(int sz) {
        try {
            p = new int[sz];
            size = sz;
        } catch (bad_alloc ba) {
            cout << "Bad alloc error" << endl;
        }
    }
    array(const array &a) {
        try {
            p = new int[a.size];

        } catch (bad_alloc ba) {
            cout << "Bad allocation\n";
        }
        for (int i = 0; i < a.size; i++ ) {
            p[i] = a.p[i];
            cout << p[i] << " " << a.p[i] << endl;
        }
        size = a.size;
    }
    void put(int i, int j) {
        if(i >= 0  && i < size) p[i] = j;   
        cout << p[i] << endl;
    }
    int get(int i) {
        if (i >= 0  && i < size) return p[i];
        return 0;
    }
    void put(long i, int j) {
        cout << "Calling long " << endl;
        put(0,j);
    }
};

int main() {
    array a(4);
    a.put(0,3); a.put(1L,34); a.put(2, 34); a.put(3, 241);
    array b = a;
    cout << b.get(0) << endl;
    cout << a.get(0) << endl;

}
