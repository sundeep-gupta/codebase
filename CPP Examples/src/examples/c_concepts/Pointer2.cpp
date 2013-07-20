#include <iostream>
#include <stdio.h>
using namespace std;
int main() {
    int i = 10;
    int *p1, *p2;
    p1 = &i;
    p2 = p1;
    printf("%d", *p2);
    cout << endl;
}
