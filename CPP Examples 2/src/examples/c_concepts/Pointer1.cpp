#include <iostream>
using namespace std;
int main() {
    /*qq */
    int x = 100, y;
    int *p;
    p =  &x;
    y = *p;
    std::cout << sizeof(y) << endl << sizeof(int) << endl;
    std::cout << y << endl;
    std::cout << x << endl;

}
