/*
 * This file was generated automatically by xsubpp version 1.9508 from the
 * contents of Mytest.xs. Do not edit this file, edit Mytest.xs instead.
 *
 *	ANY CHANGES MADE HERE WILL BE LOST!
 *
 */

#line 1 "Mytest.xs"
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"


#line 18 "Mytest.c"

XS(XS_Mytest_hello); /* prototype to pass -Wmissing-prototypes */
XS(XS_Mytest_hello)
{
    dXSARGS;
    if (items != 0)
	Perl_croak(aTHX_ "Usage: Mytest::hello()");
    {
#line 13 "Mytest.xs"
printf("Hello Sunny\n");
#line 29 "Mytest.c"
    }
    XSRETURN_EMPTY;
}

#ifdef __cplusplus
extern "C"
#endif
XS(boot_Mytest); /* prototype to pass -Wmissing-prototypes */
XS(boot_Mytest)
{
    dXSARGS;
    char* file = __FILE__;

    XS_VERSION_BOOTCHECK ;

        newXS("Mytest::hello", XS_Mytest_hello, file);
    XSRETURN_YES;
}

