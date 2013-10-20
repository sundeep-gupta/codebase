#include <iostream>
/* This example demonstrate the multiple inheritance.
 */
class Mother {

public :
    Mother() {
        std::cout << "Mother came first" << endl;
    }

};

class Father {
public :
    Father() {
        std::cout <<"Then comes the father" << endl;
    }
};

class Child : public Mother, public Father {
public :
    Child() {
        std::cout << "Child came now" << endl;
    }
};

int main() {
    Child child = Child();

}
