#include <Stack.h>


int main() {
    Stack<int> s1;
    s1.push(1);
    s1.push(2);
    s1.push(3);
    cout << s1.pop() << "\n";
    s1.push(5);
    cout << s1.pop() << "\n";
    cout << s1.pop() << "\n";
    cout << s1.pop() << "\n";
    cout << s1.pop() << "\n";
    cout << s1.pop() << "\n";
}
