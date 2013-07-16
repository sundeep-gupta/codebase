#include <iostream>
using namespace std;

int main() {
    char *str = "ABCDE";
    int len = strlen(*str);
    if (len <= 2) {
        cout << "Could not determine the order as len is " << len << endl;
    }
    order = *(str) - *(str + 1);
    for(int i = 1; i < strlen(*str) - 1; i++) {
        // if order is descending, then it must be descending...
        if (order && ( !( *(str) - *(str + 1)) )) {
            cout << "Out of order at " << i << endl;
        } else if ( *(str) - *(str + 1)) {
            cout << "Out of order at " << i << endl;
        }
        cout << *(str + i) << " ";
    }
}
