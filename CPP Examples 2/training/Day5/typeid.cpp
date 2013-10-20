#include <iostream>
#include <typeinfo>
using namespace std;
class myclass1 { 
public :
    virtual void dummy() { cout << "Myclass1 method\n";}
};
class myclass2 : public myclass1 { 
float m, n, o, p, q, r, s, t; 
public:
    void dummy() { cout << "myclas2 method \n";}
};


int main() {
    int **i;
    myclass1 ob1;
    myclass2 ob2;
    myclass1 *obj3 = &ob2;
    exception e;

    cout << "myclass2   " << typeid(ob2).name() << endl;
    cout << "myclass1   " << typeid(ob1).name() << endl;
    cout << "test before " << typeid(ob2).before(typeid(ob1)) << endl;
    cout << "test before " << typeid(*obj3).before(typeid(obj3)) << endl;
    cout << "test before " << typeid(obj3).before(typeid(*obj3)) << endl;
    cout << "myclass * " << typeid(obj3).name() << endl;
    cout << "myclass1 *   " << typeid(*obj3).name() << endl;
    cout << "int** " << typeid(i).name() << endl;

    cout << "int " << typeid(**i).name() << endl;
    cout << "cout " << typeid(cout).name() << endl;

    cout << "exception " << typeid(e).name() << endl;

}
