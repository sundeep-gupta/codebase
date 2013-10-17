#include <time.h>
#include <stdio.h>

void main() {
    struct tm *timeinfo;
    time_t mytime;
    time(&mytime);
    timeinfo = localtime(&mytime);
    printf("%d:%d:%d\n", timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec);
}


