#include <iostream>
using namespace std;
class Fibo {
    private :
        int max;
    protected :
        /* private method to print fibo series using loop */
        void printLoop() {
            int prev = 0;
            int current = 1;
            int next = 0;
            if (max <= current) {
                return;
            }
            cout << prev << ", " << current << ", ";
            do {
                next = prev + current;
                cout << next << ", ";
                prev = current;
                current = next;
            } while ( prev + current <= max);
            cout << endl; 
        }
        /** Protected method to print fibo series using
         * recursion. 
         */
        void printRecursive(int prev, int curr) {
            if (this->max <= curr) {
                cout << endl;
                return;
            }
            if (prev == 0) {
                cout << prev << ", ";
            }
            cout << curr << ", ";
            printRecursive(curr, prev + curr);
            
        }
    public :
        Fibo(int num):max(num) {}
        void printSeries(bool recursive = false) {
            if (recursive) {
                this->printRecursive(0, 1);
            } else {
                this->printLoop();
            }
        }
};


int main() {
    Fibo fiboR(100), fiboL(200);
    fiboR.printSeries();
    fiboL.printSeries(true);
}
