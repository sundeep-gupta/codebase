#include <iostream>
using namespace std;


class Parent {
public :
    Parent() {
        std::cout << "Called implicitly" << endl;
    }
    Parent(int val) {
        std::cout << "Called explicitly" << endl;
    }
};
class MyClass : public Parent {
private :
    int m_var;
public :
    MyClass(int val) : m_var(val) , Parent(10) { 
        std::cout << "In the derived class " << m_var << endl;
    }
    MyClass(const MyClass& obj) : Parent(100) {
        this->m_var = obj.m_var + 1;
    }
    void print() {
        std::cout << this->m_var << std::endl;
    }
};
int main() {
    MyClass c = MyClass(10);
    MyClass c1 = c;
    c1.print();
    c.print();
}
