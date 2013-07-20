#include <iostream>

int void main() {
    int num = 100;
    int prev = 0;
    int current = 1;
    if (num <= current) {
        return(0);
    }
    do {
        next = prev + current;
        cout << next << ', ';
        prev = current;
        current = next;
    } while ( next <= num);
}
