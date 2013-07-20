#include <stdio.h>
#include <time.h>
#define DELAY 300000000
struct mytime {
    int hour;
    int minutes;
    int seconds;
};

void update(struct mytime *systime) {
    int i;
    systime->seconds++;
    if(systime->seconds == 60) {
        systime->minutes++;
        systime->seconds = 0;
    }
    if(systime->minutes == 60) {
        systime->hour++;
        systime->minutes = 0;
    }
    if(systime->hour == 24) {
        systime->hour = 0;
    }
    for (i = 0; i< DELAY; i++);
}

void display(struct mytime *systime) {
    printf("%d:%d:%d", systime->hour, systime->minutes, systime->seconds);
}

int main() {
    struct mytime systime;
    systime.hour = systime.minutes = systime.seconds = 0;
    for(;;) {
        update(&systime);
        display(&systime);
    }
}
