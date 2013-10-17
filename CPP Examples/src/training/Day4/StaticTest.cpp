#include <iostream>
using namespace std;

class StaticTest {
     static int i;
     static StaticTest *self;
public :
    StaticTest () {
        cout << "Static to this " << endl;
    }
    void setVal() {
        self = this;
        cout << "Setval" << endl;
    }
};
StaticTest* StaticTest::self = NULL;
int StaticTest::i = 0;

int main() {
    StaticTest st;
    cout << "Done " << endl;
    st.setVal();

}

