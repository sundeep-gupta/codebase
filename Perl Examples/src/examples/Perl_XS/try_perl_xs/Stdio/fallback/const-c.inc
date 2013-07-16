#define PERL_constant_NOTFOUND	1
#define PERL_constant_NOTDEF	2
#define PERL_constant_ISIV	3
#define PERL_constant_ISNO	4
#define PERL_constant_ISNV	5
#define PERL_constant_ISPV	6
#define PERL_constant_ISPVN	7
#define PERL_constant_ISSV	8
#define PERL_constant_ISUNDEF	9
#define PERL_constant_ISUV	10
#define PERL_constant_ISYES	11

#ifndef NVTYPE
typedef double NV; /* 5.6 and later define NVTYPE, and typedef NV to it.  */
#endif
#ifndef aTHX_
#define aTHX_ /* 5.6 or later define this for threading support.  */
#endif
#ifndef pTHX_
#define pTHX_ /* 5.6 or later define this for threading support.  */
#endif

static int
constant_5 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     __SRD __SRW __SWR stdin */
  /* Offset 4 gives the best switch position.  */
  switch (name[4]) {
  case 'D':
    if (memEQ(name, "__SR", 4)) {
    /*                   D     */
#ifdef __SRD
      *iv_return = __SRD;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'R':
    if (memEQ(name, "__SW", 4)) {
    /*                   R     */
#ifdef __SWR
      *iv_return = __SWR;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'W':
    if (memEQ(name, "__SR", 4)) {
    /*                   W     */
#ifdef __SRW
      *iv_return = __SRW;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'n':
    if (memEQ(name, "stdi", 4)) {
    /*                   n     */
#ifdef stdin
      *iv_return = stdin;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_6 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     BUFSIZ _IOFBF _IOLBF _IONBF __SALC __SAPP __SEOF __SERR __SIGN __SLBF
     __SMBF __SMOD __SNBF __SNPT __SOFF __SOPT __SSTR stderr stdout */
  /* Offset 3 gives the best switch position.  */
  switch (name[3]) {
  case 'A':
    if (memEQ(name, "__SALC", 6)) {
    /*                  ^        */
#ifdef __SALC
      *iv_return = __SALC;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "__SAPP", 6)) {
    /*                  ^        */
#ifdef __SAPP
      *iv_return = __SAPP;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'E':
    if (memEQ(name, "__SEOF", 6)) {
    /*                  ^        */
#ifdef __SEOF
      *iv_return = __SEOF;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "__SERR", 6)) {
    /*                  ^        */
#ifdef __SERR
      *iv_return = __SERR;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'F':
    if (memEQ(name, "_IOFBF", 6)) {
    /*                  ^        */
#ifdef _IOFBF
      *iv_return = _IOFBF;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'I':
    if (memEQ(name, "__SIGN", 6)) {
    /*                  ^        */
#ifdef __SIGN
      *iv_return = __SIGN;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'L':
    if (memEQ(name, "_IOLBF", 6)) {
    /*                  ^        */
#ifdef _IOLBF
      *iv_return = _IOLBF;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "__SLBF", 6)) {
    /*                  ^        */
#ifdef __SLBF
      *iv_return = __SLBF;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'M':
    if (memEQ(name, "__SMBF", 6)) {
    /*                  ^        */
#ifdef __SMBF
      *iv_return = __SMBF;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "__SMOD", 6)) {
    /*                  ^        */
#ifdef __SMOD
      *iv_return = __SMOD;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'N':
    if (memEQ(name, "_IONBF", 6)) {
    /*                  ^        */
#ifdef _IONBF
      *iv_return = _IONBF;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "__SNBF", 6)) {
    /*                  ^        */
#ifdef __SNBF
      *iv_return = __SNBF;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "__SNPT", 6)) {
    /*                  ^        */
#ifdef __SNPT
      *iv_return = __SNPT;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'O':
    if (memEQ(name, "__SOFF", 6)) {
    /*                  ^        */
#ifdef __SOFF
      *iv_return = __SOFF;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "__SOPT", 6)) {
    /*                  ^        */
#ifdef __SOPT
      *iv_return = __SOPT;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'S':
    if (memEQ(name, "BUFSIZ", 6)) {
    /*                  ^        */
#ifdef BUFSIZ
      *iv_return = BUFSIZ;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "__SSTR", 6)) {
    /*                  ^        */
#ifdef __SSTR
      *iv_return = __SSTR;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'e':
    if (memEQ(name, "stderr", 6)) {
    /*                  ^        */
#ifdef stderr
      *iv_return = stderr;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'o':
    if (memEQ(name, "stdout", 6)) {
    /*                  ^        */
#ifdef stdout
      *iv_return = stdout;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_8 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     L_tmpnam SEEK_CUR SEEK_END SEEK_SET */
  /* Offset 6 gives the best switch position.  */
  switch (name[6]) {
  case 'E':
    if (memEQ(name, "SEEK_SET", 8)) {
    /*                     ^       */
#ifdef SEEK_SET
      *iv_return = SEEK_SET;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'N':
    if (memEQ(name, "SEEK_END", 8)) {
    /*                     ^       */
#ifdef SEEK_END
      *iv_return = SEEK_END;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'U':
    if (memEQ(name, "SEEK_CUR", 8)) {
    /*                     ^       */
#ifdef SEEK_CUR
      *iv_return = SEEK_CUR;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'a':
    if (memEQ(name, "L_tmpnam", 8)) {
    /*                     ^       */
#ifdef L_tmpnam
      *iv_return = L_tmpnam;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant (pTHX_ const char *name, STRLEN len, IV *iv_return) {
  /* Initially switch on the length of the name.  */
  /* When generated this function returned values for the list of names given
     in this section of perl code.  Rather than manually editing these functions
     to add or remove constants, which would result in this comment and section
     of code becoming inaccurate, we recommend that you edit this section of
     code, and use it to regenerate a new set of constant functions which you
     then use to replace the originals.

     Regenerate these constant functions by feeding this entire source file to
     perl -x

#!/usr/bin/perl -w
use ExtUtils::Constant qw (constant_types C_constant XS_constant);

my $types = {map {($_, 1)} qw(IV)};
my @names = (qw(BUFSIZ EOF FILENAME_MAX FOPEN_MAX L_ctermid L_tmpnam NULL
	       SEEK_CUR SEEK_END SEEK_SET TMP_MAX _FSTDIO _IOFBF _IOLBF _IONBF
	       __SALC __SAPP __SEOF __SERR __SIGN __SLBF __SMBF __SMOD __SNBF
	       __SNPT __SOFF __SOPT __SRD __SRW __SSTR __SWR stderr stdin
	       stdout));

print constant_types(), "\n"; # macro defs
foreach (C_constant ("Stdio", 'constant', 'IV', $types, undef, 3, @names) ) {
    print $_, "\n"; # C constant subs
}
print "\n#### XS Section:\n";
print XS_constant ("Stdio", $types);
__END__
   */

  switch (len) {
  case 3:
    if (memEQ(name, "EOF", 3)) {
#ifdef EOF
      *iv_return = EOF;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 4:
    if (memEQ(name, "NULL", 4)) {
#ifdef NULL
      *iv_return = NULL;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 5:
    return constant_5 (aTHX_ name, iv_return);
    break;
  case 6:
    return constant_6 (aTHX_ name, iv_return);
    break;
  case 7:
    /* Names all of length 7.  */
    /* TMP_MAX _FSTDIO */
    /* Offset 2 gives the best switch position.  */
    switch (name[2]) {
    case 'P':
      if (memEQ(name, "TMP_MAX", 7)) {
      /*                 ^          */
#ifdef TMP_MAX
        *iv_return = TMP_MAX;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'S':
      if (memEQ(name, "_FSTDIO", 7)) {
      /*                 ^          */
#ifdef _FSTDIO
        *iv_return = _FSTDIO;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 8:
    return constant_8 (aTHX_ name, iv_return);
    break;
  case 9:
    /* Names all of length 9.  */
    /* FOPEN_MAX L_ctermid */
    /* Offset 0 gives the best switch position.  */
    switch (*name++) {
    case 'F':
      if (memEQ(name, "OPEN_MAX", 8)) {
      /*                F              */
#ifdef FOPEN_MAX
        *iv_return = FOPEN_MAX;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'L':
      if (memEQ(name, "_ctermid", 8)) {
      /*                L              */
#ifdef L_ctermid
        *iv_return = L_ctermid;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 12:
    if (memEQ(name, "FILENAME_MAX", 12)) {
#ifdef FILENAME_MAX
      *iv_return = FILENAME_MAX;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

