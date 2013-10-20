#include <Employee.h>
#include <Queue.h>
using namespace std;

int main() {
    
    Queue<Employee> cl;
    
    cl.enqueue(Employee(1, "Sundeep", "QA", 23423));
    cl.enqueue(Employee(2, "JD", "Dev", 234234));
    cl.enqueue(Employee(3, "Anand", "QA", 24124312));
    cl.print();
    cl.dequeue();
    cl.enqueue(Employee(4, "Devender", "Director", 23423));
    cl.print();
    cl.dequeue();
    cl.print();
    cl.dequeue();
    cl.print();
    cl.dequeue();
    cl.print();
}


