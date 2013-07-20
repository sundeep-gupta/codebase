#include <iostream>
using namespace std;
void f() {

    class myclass {
        public :
            myclass() { cout << "Con called" << endl; }
    }ob;

}
int main() {
    f();
}
