#include <sys/vfs.h>
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"


MODULE = Mytest6		PACKAGE = Mytest6		

SV *
multi_statfs(paths)
	SV* paths
INIT:
	AV* results;
	I32 numpaths = 0;
	int i, n;
	struct statfs buf;
	if ((!SvROK(paths)) 
	|| (SvTYPE(SvRV(paths)) != SVt_PVAV)
	|| ((numpaths = av_len((AV *) SvRV(paths))) < 0)) {
	   XSRETURN_UNDEF;
	}
	results = (AV*) sv_2mortal((SV *)newAV());
CODE:
	for(n=0;n<=numpaths;n++) {
		HV * rh;
		STRLEN l;
		char * fn = SvPV(*av_fetch((AV *)SvRV(paths), n, 0), l);
		i = statfs(fn, &buf);
		if (i != 0) {
		    av_push(results, newSVnv(errno));
		    continue;
		}
		rh = (HV *)sv_2mortal((SV *)newHV());
		hv_store(rh, "f_bavail", 8, newSVnv(buf.f_bavail), 0);
		hv_store(rh, "f_bfree",  7, newSVnv(buf.f_bfree),  0);
		hv_store(rh, "f_blocks", 8, newSVnv(buf.f_blocks), 0);
		hv_store(rh, "f_bsize",  7, newSVnv(buf.f_bsize),  0);
		hv_store(rh, "f_ffree",  7, newSVnv(buf.f_ffree),  0);
		hv_store(rh, "f_files",  7, newSVnv(buf.f_files),  0);
		hv_store(rh, "f_type",   6, newSVnv(buf.f_type),   0);
		av_push(results, newRV((SV *)rh));
        }
        RETVAL = newRV((SV *)results);
OUTPUT:
    RETVAL
