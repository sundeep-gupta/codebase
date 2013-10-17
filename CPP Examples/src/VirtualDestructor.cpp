#include <iostream.h>
class Base
{
public:
Base(){ cout<<"Constructor: Base"<<endl;}
virtual ~Base(){ cout<<"Destructor : Base"<<endl;}
};
class Derived: public Base
{
//Doing a lot of jobs by extending the functionality
public:
Derived(){ cout<<"Constructor: Derived"<<endl;}
~Derived(){ cout<<"Destructor : Derived"<<endl;}
};
int main(int argc, char *argv[])
{
Base *Var = new Derived();
delete Var;
}
