#include<stdio.h>
#include<string.h>


int check(char *a, char *b, int (*cmp)(const char *a,const char *b));
int main() {

    char *s1 = "Sundeep";
    char *s2 = "Sundeepasdf";
    int (*p)(const char *a, const char *b);
    p = strcmp;
    check(s1, s2, p);
    check(s1, s1, p);
}
int check(char *a, char *b, int (*cmp)(const char *a,const char *b)) {
    printf("Comparing");
    if( ! (*cmp)(a,b)) {
        printf("Equals\n");
        return 1;
    }
    printf("Not equals\n");
    return 0;
    
}
