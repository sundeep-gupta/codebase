/** This program is to create stack of size SIZE -1 */
#include <stdio.h>
#define SIZE 5

void push(int i);
int pop(void);
int *tos, *pos, stack[SIZE];

int main() {
    int i;
    tos = stack;
    pos = tos;
    do {
        printf("Enter the value :");
        scanf("%d", &i);
        if(i == 0) {
            printf("%d \n", pop());
        } else if( i > 0) {
            push(i);
        } else if ( i < 0) {
            printf("Less than 0.. quitting\n");
        }
    } while (i >= 0);
}

void push(int i) {
    pos++;
    if (pos == stack + SIZE) {
        printf("Size Overflow\n");
        pos--;
        return;
    }
    *pos = i;
}

int pop() {
    if (pos == tos) {
        printf("Stack Underflow\n");
        return -1;
    }
    int val =  *pos;
    pos--;
    return val;

}

