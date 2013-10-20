#include <iostream>
using namespace std;

int myfunc(int a) { return a; }
int myfunc(int a, int b = 23) { return a*b; }

int main() {
    int (*fp1) (int);
    int (*fp2)(int , int);

    fp1 = myfunc;
    fp2 = myfunc;
    cout << fp1(3) << endl;
    cout << fp2(4,4) << endl;
    cout << myfunc(20) << endl;


}
