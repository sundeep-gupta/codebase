#include <iostream>
#include <stdlib.h>
#include <List.h>
using namespace std;

int main() {
    List<int> list = List<int>();
    list.append(12);
    list.append(234);
    list.print();

}
