#include <iostream>
#include <unistd.h>
#include <string.h>
#define PATH "/Library/Application\\ Support/McAfee/MSS/Applications/ActivationWizard.app/Contents/MacOS/ActivationWizard --silent=no &"
#define PARAM1 "--silent=no"
int main()
{
	int iErrorCode					= -1;
	char **commandArgs				= NULL;
	printf("Entering the program");
	commandArgs = (char **)(malloc(2*sizeof(char *)));
	
	*(commandArgs+0) = (char *)(malloc(strlen(PATH)));
	strcpy(*(commandArgs+0),(char *)(PATH));
	
	*(commandArgs+1) = (char *)(malloc(strlen(PARAM1)));
	strcpy(*(commandArgs+1),(char *)(PARAM1));
	
	*(commandArgs+2) = NULL;
	
	pid_t pid = fork();
	
	if(pid == 0) 
	{
                setsid();
		FILE * fp = popen(PATH, "r+");
    		/*! \brief wind up*/
		if(fp != NULL)
		{
			int retVal = pclose(fp);
		}
                printf("In child done popen\n");
		//execvp(PATH, (char * const*)(commandArgs));
	}
	else
	{
		pid_t cPid = pid;
                sleep(10);
                printf("In parent going ou of scope\n");
	         	
		iErrorCode = 0;
	}
	
	return iErrorCode;
}
