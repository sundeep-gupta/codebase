#include <stdio.h>
#include <string.h>

int main() {
    char *p1;
    char str[80];
    do {
        p1 = str;
        printf("\nEnter the String [enter 'done' to quit] :");
        gets(str);
        if (! strcmp(str,"done")) {
            break;
        }
        while(*p1) {
            printf("%d ", (*p1++)++);
        }
    } while (strcmp(str,"done"));




}
