#include <stdio.h>
void main(){
FILE *fp = fopen("IRIS.dat","r");
double dou = 29;
clrscr();
if(fp == NULL)
    exit(0);
fscanf(fp,"%f",&dou);
printf("%f",dou);
fclose(fp);
}
