
#include <iostream>
#include <String.h>
using namespace std;
int main() {
    String s("Sundeep"), s2("Gupta");
    String plus = s + s2;
    cout << "Add done\n";
    cout << plus << endl;
    cout << "Testing out of order index" << endl;
    cout << "Index is " << plus.getOutOfOrderIndex() << endl;
    cout << "Index is " << s2.getOutOfOrderIndex() << endl;
    cout << s2.reverse() << endl;
}
