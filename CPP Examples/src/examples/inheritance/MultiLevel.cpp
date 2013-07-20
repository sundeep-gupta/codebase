/*
 * This file is for example of diamond - inheritance.
 * Points to learn are that :
 * 1. You MUST use scope resolution order to remove ambiguity.
 * 2. In this example it is demonstrated that when MyClassObj.Parent1::setI() is called, it must call
 * MyClassObj.Parent1::getI() to get the value and NOT MyClassObj.Parent2::getI();
 *
 */
#include <iostream>
using namespace std;
class Base {
private :
    int i;
public :
    void setI(int val) {
        this->i = val;
    }
    int getI() { return i; }
};

class Parent1 : public Base {
private :
    int d;
public :
    void setD(int d) {
        this->d = d;
    }
    int getD() { return this->d;}
};

class Parent2 : public Base {
private :
    int s;
public :
    void setS(int s) {
        this->s = s;
    }
    int getS() { return s ; }
};

class MyClass : public Parent1, public Parent2  {
private :
    int p;
public :
    void setP(int p) { this->p = p;}
    int getP() { return this->p; }
    void print() { 
        cout << getP() << ", " << getS() << ", " << getD() << ", " << Parent1::getI() << endl;
    }

};
int main() {
    MyClass mc = MyClass();
    mc.setP(1); mc.setD(2); mc.setS(3); mc.Parent2::setI(4);
    mc.print();

}
