/** This is the implementation of queue. 
 * The bug is that the queue has capacity of SIZE - 1 and not SIZE
 */

#include <iostream>
#include <stdio.h>
#define SIZE 5
using namespace std;
void enqueue(int val);
int dequeue(void);

int *p_enQ, *p_deQ, queue[SIZE];

int main() {
    int val;
    p_enQ = queue;
    p_deQ = queue;
    do {
        printf("Enter the value");
        scanf("%d", &val);
        if(val == 0) {
            printf("%d\n", dequeue());
        } else {
            enqueue(val);
        }
    } while ( val >=0);

}

void enqueue(int val) {
    p_enQ++;
    if (p_enQ == queue + SIZE) {
        cout << "Reached end of queue" << endl;
        return;
    }
    *p_enQ = val;

}
int dequeue() {
    p_deQ++;
    if(p_deQ == p_enQ) {
        cout <<  "No element in queue"<< endl;
        return -1;
    }
    return *p_deQ;
}

