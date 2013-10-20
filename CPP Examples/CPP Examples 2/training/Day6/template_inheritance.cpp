#include <iostream>
#include <typeinfo>
using namespace std;

template <class T>
class Num {
protected :
    T val;
public :
    Num(T x) { val = x; }
    virtual T getVal() { return val; }

};

template <class Y>
class Sqr_Num : public Num<Y> {
    public :
        Sqr_Num(Y num) : Num<Y>(num) {}
        Y getVal() { 
            cout << typeid(this->val).name()<< endl;
            return this->val * this->val;
        }
};

int main() {

    Num<int> *p_num_int;
    Num<double> *p_num_double;
    Sqr_Num<int> i_sqr_obj(5);
    Sqr_Num<double> d_sqr_obj(3.0);
    p_num_int = &i_sqr_obj;
    cout << p_num_int->getVal() << endl;
    p_num_int = dynamic_cast< Num<int> *>(&i_sqr_obj);
    if(p_num_int)
        cout << "cast from sqr_num<int> * to num<int> *" << endl;
    
    p_num_double = dynamic_cast< Num<double> *>(&i_sqr_obj);
    if(! p_num_double)
        cout << "cast from sqr_num<int> * to num<double> * failed" << endl;
}
