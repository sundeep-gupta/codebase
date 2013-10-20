#include <iostream>
using namespace std;

class Base {
private :
    int m_base;
public :
    Base() {
        cout << "Entered Base" << endl;
        m_base = 100;
        cout << "Exiting Base" << endl;
    }

    void print() {
        std::cout << m_base << endl;
    }

};

class Derived : public Base {
private :
    int m_der;
public :
    Derived() {
        cout << "Entered Derived "<< endl;
        m_der = 10;
        cout << "Exiting Derived" << endl;
    }
    void print() {
        this->Base::print();
        std::cout << m_der << endl;
    }
};


int main() {
    Base *pBase = new Derived();
    std::cout << "Printing using Base pointer ";
    pBase->print();
    std::cout << "Printing by type conversion to Derived * : ";
    ((Derived *)pBase)->print();
}
