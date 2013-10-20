#include <iostream>

void fibo(int prev, int curr, int max) {
    if (max <= curr) {
        cout << endl;
        return;
    }
    if (prev == 0) {
        cout << prev << ', ';
    cout << curr << ', ';
    fibo(curr, prev + curr, max);
}
int main() {
    fibo(0, 1, 100);
}
