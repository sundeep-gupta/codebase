/*
 *  Copyright (C) 2010 McAfee, Inc.  All rights reserved.
 */

#include <stdio.h>
#include <dlfcn.h>

void (*func1P)();
void (*func2P)();

int main()
{
	void *libSample1H = dlopen("/usr/local/lib/libSample1.dylib", RTLD_LAZY);

	if(libSample1H == NULL) {
		printf("\n Not able to load libSample1.dylib");
	}
	else {
		printf("\n");
		func1P = dlsym(libSample1H, "func1");
		(*func1P)();
	}
	dlclose(libSample1H);

	void *libSample2H = dlopen("/usr/local/lib/libSample2.dylib", RTLD_LAZY);

	if(libSample2H == NULL) {
		printf("\n Not able to load libSample2.dylib");
	} 
	else {
		printf("\n");
		func2P = dlsym(libSample2H, "func2");
		(*func2P)();
	}

	dlclose(libSample2H);

	return 0;
}
