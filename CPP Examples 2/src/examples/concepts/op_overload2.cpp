#include <iostream>
using namespace std;
class loc {
    int lat;
public :
    loc(int l): lat(l) {}
    loc(const loc& l) { lat = l.lat; }

    loc operator =(const loc& l) { this->lat = l.lat; return *this; }
    loc * operator =(const loc* l) { this->lat = l->lat; return this; }
    void print() { cout << lat << endl; }
    loc operator ++() { lat++; return *this ;}
};
int main() {
    loc ob1(4), ob2(45);
    loc *ob3 = &ob2;
    loc *ob4;
    ob3 = ob4 = &ob2;
    ++ob2;
    ob3->print();
    ob4->print();
    ob2.print();
    
}

