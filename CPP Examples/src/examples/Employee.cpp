#include "Employee.h"
#include <iostream>
using namespace std;
Employee::Employee(int eno, char* n, char* d, float s) {
    emp_no = eno;
    name = n;
    dept = d;
    salary = s;
}
void Employee::print() {
    cout << emp_no << "\t" << name << "\t" << dept <<"\t" << salary << endl;
}

int Employee::getEmpno() { return this->emp_no; }
char* Employee::getName() { return this->name; }
char* Employee::getDept() { return this->dept; }
float Employee::getSalary() { return this->salary; }


Employee& Employee::operator = (const Employee& rhs) {
    emp_no = rhs.emp_no;
    name = rhs.name;
    dept = rhs.dept;
    salary = rhs.salary;
    return *this;
}
Employee::Employee (const Employee& rhs) {
    emp_no = rhs.emp_no;
    name = rhs.name;
    dept = rhs.dept;
    salary = rhs.salary;
}

bool Employee::operator ==(const Employee& e) { return e.emp_no == emp_no; }

ostream& operator <<(ostream& cout, const Employee& e) {
    cout << e.emp_no << " " << e.name << " " << e.dept << " " << e.salary;
    return cout;
}
