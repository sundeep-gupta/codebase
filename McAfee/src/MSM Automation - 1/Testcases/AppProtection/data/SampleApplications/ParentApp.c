/*  
 *  Copyright (C) 2010 McAfee, Inc.  All rights reserved.
 */
#include "stdio.h"
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc , char *argv[])
{
        pid_t pID = fork();

        if (pID == 0) {
                const char* exe = argv[1];
                execv(exe, argv);
                printf("execv() failed\n");
                return 1;
        }
        else if (pID < 1)  {
                printf("fork() failed\n");
                return 1;
        }
        else {
                printf("Parent process running with pid: %d\n",getpid());
        }

        int status = 0;

        pid_t childPID = wait(&status); 

        printf("Child with pid: %d quit\n", childPID);       

        return 0;
}
