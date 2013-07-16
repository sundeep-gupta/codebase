#include <iostream>
using namespace std;
class myclass {
    int i;
    public:
    myclass(int j):i(j) {};
    int getI() { return i; }

};
int main() {
    myclass c1[] = {1, 3, 5};
    myclass c2[3] = { myclass(4), myclass(3), myclass(56) };
    myclass *c3[] = {new myclass(5), new myclass(434), new myclass(545) };
    for(int i = 0; i < sizeof(c1)/ sizeof(myclass); i++ ) {
        cout << (*c3 + sizeof(myclass)*i)->getI() << endl;

    }

}
