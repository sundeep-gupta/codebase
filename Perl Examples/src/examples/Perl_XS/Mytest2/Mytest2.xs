#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"


MODULE = Mytest2		PACKAGE = Mytest2		

int
is_even(input)
	int input
CODE:
	RETVAL = (input%2 == 0);
OUTPUT:
	RETVAL