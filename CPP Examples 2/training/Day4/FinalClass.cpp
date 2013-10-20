#include <iostream>
using namespace std;
// This fail as const can't be used for class
const class FinalClass {
    public :
        FinalClass() { cout << "Const" << endl; }
};

int main() {
    FinalClass fc;
    cout << "Done" << endl;
}
