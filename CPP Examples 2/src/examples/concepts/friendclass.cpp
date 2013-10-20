#include <iostream>
using namespace std;
class TwoValues {
    int a, b;
public :
    TwoValues(int a, int b) { this->a = a; this->b = b; }

    friend class Min;

};
class Min  {
    public :
    int min(TwoValues tw) {
        return tw.a > tw.b ? tw.b : tw.a;
    }

};
int main() {
    TwoValues tw(3,4);
    Min m;
    cout <<  m.min(tw) << endl;

}

