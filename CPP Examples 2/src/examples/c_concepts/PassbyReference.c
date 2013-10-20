#include<stdio.h>
void swap(int *x, int *y) {
    *x  = *x + *y;
    *y = *x - *y;
    *x = *x - *y;
}
int (*p)(const char *a, const char *b);

void main() {
    int x = 10, y = 20;
    void (*p_swap)(int *, int *);
    p_swap = swap;
    printf("%d %d\n", x, y);
    (*p_swap)(&x, &y);
    printf("%d %d\n", x, y);
    p_swap(&x, &y);
    printf("%d %d\n", x, y);
}
