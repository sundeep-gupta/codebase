#include <iostream>
using namespace std;
class Static {
    static int a;
public :
    Static() {  };
    static void print() { cout << a << endl; }
    
};
int Static::a = 3;
int main() {
    Static s1, s2, s3;
    s1.print(); s2.print(); s3.print();
}
