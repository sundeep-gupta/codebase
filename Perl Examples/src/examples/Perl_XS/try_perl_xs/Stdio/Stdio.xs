#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <stdio.h>

#include "const-c.inc"

MODULE = Stdio		PACKAGE = Stdio		

INCLUDE: const-xs.inc
