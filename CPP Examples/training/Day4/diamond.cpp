#include <iostream>
using namespace std;
class base {
public :
    void show() { cout << "0" << endl; }
};

class base_1 : public virtual base {
public:
/*
    void show() {
        cout <<"base_1" << endl;
    }
    */
};
class base_2 : public virtual base {
public:
    void show() { cout << "base_2" << endl; }
};
class derive : public base_1, public base_2 {};

int main() {
    derive().base_1::show();
    derive().show();
}
