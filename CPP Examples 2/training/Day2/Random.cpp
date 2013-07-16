#include <iostream>
#include <time.h>
using namespace std;
int main() {
    unsigned int min = 100, max = 12232, count = 10;
    for(int i = 0; i< count; i++) 
        cout << ((time(NULL) *(i +1)) % (max - min))  + min  << endl;
}

