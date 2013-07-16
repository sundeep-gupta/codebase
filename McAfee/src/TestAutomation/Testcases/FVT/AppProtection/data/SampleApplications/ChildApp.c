/*  
 *  Copyright (C) 2010 McAfee, Inc.  All rights reserved.
 */
#include "stdio.h"
#include <unistd.h> 
#include <sys/wait.h>

int main(int argc , char *argv[])
{
        printf("Child Process Running with pid: %d\n", getpid());       
	
        return 0;
}
