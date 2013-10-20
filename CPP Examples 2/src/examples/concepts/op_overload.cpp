#include <iostream>
using namespace std;
class loc {
    int lon, lat;
public :
    loc() {};
    loc(int a, int b)  { lon = a ; lat = b; }
    loc(const loc& l) { 
        lon = l.lon;
        lat = l.lat;
    }
    loc& operator +(const loc &op2) {
        loc *temp = new loc(lon + op2.lon, lat + op2.lat);
        return *temp;
    }
    int getLat() { return lat; }
    int getLon() { return lon; }
};
int main() {
    loc l1(3,5), l2(4,5);
    loc ob2 = l1 + l2;
    cout << ob2.getLon() << " " << ob2.getLat() << endl;
    cout << l1.getLon() << " " << l1.getLat() << endl;

}
