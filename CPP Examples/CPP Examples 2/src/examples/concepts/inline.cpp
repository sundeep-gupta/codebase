#include <iostream>
using namespace std;
class myclass {
    int m_i;
public :
    myclass(int i) : m_i(i) {};
    inline int getI() { return m_i; }
};
int main() {

    myclass mc = 200;
    cout << mc.getI() << endl;
}
