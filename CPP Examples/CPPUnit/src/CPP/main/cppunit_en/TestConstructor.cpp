#include <iostream>
using namespace std;

class MyClass {
public :
    MyClass(const int num) : 
	    m_num(num) {
		}
	int get_num() { return m_num; }
private:
    int m_num;

};

int main(int argc, char* argv[]) {
    MyClass* mc = new MyClass(100);
	int n = mc->get_num();
	cout << n << endl;
    return 0;
}
