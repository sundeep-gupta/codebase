#include <stdio.h>
#include <string.h>
#include <malloc.h>
int main(void) {
    char *p1, *p2;
    p1 = (char*) malloc(10);

    p2 = p1;
    do {
        // p1 = p2;
        printf("\nEner String :");
        gets(p1);
        while(*p1)
            printf("%d", *p1++);
    } while( strcmp(p2, "done"));





}
