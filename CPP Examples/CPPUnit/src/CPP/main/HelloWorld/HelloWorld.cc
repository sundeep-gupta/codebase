#include <iostream>
using namespace std;
/* Hello World Program */
class HelloWorld {
private:
    string hello;
public:
    HelloWorld() { hello = "HelloWorld" ;}
    std::string sayHello() { return hello; }
};
/*
int main() {
    HelloWorld* hw = new HelloWorld();
    cout << hw->sayHello() << endl;
}
*/
