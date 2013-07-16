#ifndef employee_h
#define employee_h 1
#include <iostream>
using namespace std;
class Employee {
    char *name, *dept;
    float salary;
public :
    int emp_no;
    Employee() {}
    Employee(int eno, char* n, char *d, float s);
    Employee(const Employee& cp);
    void print();
    int getEmpno();
    char* getName();
    char* getDept();
    float getSalary();
    Employee& operator =(const Employee& rhs);
    bool operator ==(const Employee& e);
    friend ostream& operator <<(ostream& cout, const Employee& e);

};
#endif

