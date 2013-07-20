#include <iostream>
using namespace std;
class Factory {
    static Factory *f;
    Factory() {
    }
public :
    static Factory * getInstance() {
        if(f == NULL) {
            f = new Factory();
        }
        return f;
    }
    void printVal() {
        cout << "I'm instance method\n" << endl;
    }
};
Factory *Factory::f = NULL;
int main() {
    Factory *f = Factory::getInstance();
    f->printVal();

}
