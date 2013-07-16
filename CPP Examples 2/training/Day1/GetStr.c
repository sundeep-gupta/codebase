#include <stdio.h>
#include <string.h>
#include <malloc.h>
void mygets(char *s) {
    int t;
    for(t=0; t < 80 ; t++) {
        s[t] = getchar();
        switch(s[t]) {
        case '\n' :
            s[t] = '\0';
            return;
        case '\b' :
            t--;
            break;
        }
    }
    s[79] = '\0';
}

char * my_upper(char *string) {
    int t = 0;
    char *up = malloc(strlen(string));
    for(; string[t]; ++t) {
        up[t] = toupper(string[t]);
    }
    return up;
}

void main() {
    char s[80];
    printf("Enter the string : ");
    mygets(s);
    printf("%s is now uppercase %s\n", s, my_upper(s));
}


