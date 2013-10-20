#include <iostream>
using namespace std;

template <class T>
void swapargs(T& a, T& b) {
    T temp = a;
    a = b;
    b = temp;
}
template <class A>
void f(A& a, int b) {
    cout << "In A int " << endl;
}
template <class A, class B>
void f(A& a, B& b) {
    cout << "In A  B"<< endl;
}
int main() {
    int a = 10, b = 12;
    char c = 'a', d = 'b';
    swapargs(a,b);
    cout << a << " " << b<< endl;
    swapargs(c,d);
    cout << c << " " << d << endl;
    f(a,b);
    f(c,"Sundeep");
}
