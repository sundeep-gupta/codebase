#include <CircularLinkList.h>
#include <Employee.h>
int main() {
    Employee e1(1, "Sundeep", "QA", 23423);
    Employee e2( 2, "JD", "Dev", 234234); 
    Employee e3(3, "Anand", "QA", 24124312);
    Employee e4(4, "Devender", "Director", 23423); 

    CircularList<Employee> cl;
    cl.add(e1);
    cl.add(e2);
    cl.add(e3);
    cl.add(e4);
    cl.print();
    cl.del(e3);
    cl.print();
    cl.del(e2);
    cl.print();
    cl.del(e2);
    cl.print();
    cl.del(e1);
    cl.print();
}
