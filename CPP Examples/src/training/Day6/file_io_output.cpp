#include <iostream>
#include <fstream>
#include <malloc.h>
using namespace std;

class myclass {
    int i, j;
    char *name;
public :
    myclass() { i = 10, j = 20; name = "Sundeep";}

    void print() { cout << i << endl << j << endl << name << endl; }
    friend ostream& operator<< (ostream& out, myclass& obj);
    friend istream& operator>> (istream& in, myclass& obj);
};
ostream& operator<< (ostream& out, myclass& obj) {
    out << obj.i*2 << endl;
    out << obj.j*2 << endl;
    out << obj.name << endl;
    cout << obj.name << endl;
}

istream& operator >> (istream& in, myclass& obj) {
    char *str = (char *)malloc(sizeof(char) * 7);
    in >> obj.i;
    obj.i++;
    in >> obj.j;
    obj.j++;
    in >> str;
    obj.name = str;
}

int main() {
    myclass obj;
    myclass obj2;
    ofstream out("MyClass");
    out << obj;
    cout << "Written successfully\n";
    out.close();

    ifstream in("MyClass");
    in >> obj2;
    in.close();

    obj2.print();

}
