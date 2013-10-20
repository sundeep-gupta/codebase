/* This class demonstrates the example for copy constructor
 * 
 */
#include <iostream>
using namespace std;
class MyClass {
private :
    int m_var;
public :
    MyClass(int val) : m_var(val) { 
        std::cout << "In the derived class " << m_var << endl;
    }
    MyClass(const MyClass& obj) {
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
