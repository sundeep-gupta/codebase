#include <iostream>
using namespace std;
void swap(int &x, int &y) {
    x = x + y;
    y = x - y;
    x = x - y;
}

int main() {
    int x = 10, y = 20;
    swap(x, y);
    cout << x  << " " << y << endl;
}
