// polymorphic classes - calcuate salary for following types
/*
sales
finance
enggr
vp
*/
#include <iostream>

class Salary {
protected 
    int base;

public :
    Salary(int base) : base(base) {}
    virtual float getSalary() = 0;
}

class BaseSalary : public Salary {
    
}

class EngineerSalary : public Salary {

public :
    EngineerSalary(int base) : Salary(base) {}
    float getSalary() {
        
    }
}

int main() {
    
}
