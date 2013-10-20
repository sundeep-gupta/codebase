#include <stdio.h>
#include <string.h>
char *p = "Hello world";

int main() {
    int i;
    printf("%s\n", p);
    
    for( i = strlen(p) - 1; i >= 0; i--) {
        printf("%c", *(p + i));
    }
    printf("\n");

}
