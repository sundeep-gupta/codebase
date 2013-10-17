#include <iostream>
using namespace std;

class base { 
public :
    virtual void dummy() {}
};
class derived : public base {};

int main() {
    base *bp, b_obj;
    derived *dp, d_obj;

    bp = dynamic_cast<derived *>(&d_obj);
    if(bp) {
        cout << "cast from derived to base *" << endl;
        
    } 
    //bp = dynamic_cast<base *>(&b_obj);
    dp = dynamic_cast<derived *>(bp);
    if(dp) {
        cout << "cast from base * to derived *" << endl;
    }

}
