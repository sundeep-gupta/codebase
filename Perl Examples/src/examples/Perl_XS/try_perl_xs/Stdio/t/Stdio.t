# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Stdio.t'

#########################

# change 'tests => 2' to 'tests => last_test_to_print';

use Test::More tests => 2;
BEGIN { use_ok('Stdio') };


my $fail = 0;
foreach my $constname (qw(
	BUFSIZ EOF FILENAME_MAX FOPEN_MAX L_ctermid L_tmpnam NULL SEEK_CUR
	SEEK_END SEEK_SET TMP_MAX _FSTDIO _IOFBF _IOLBF _IONBF __SALC __SAPP
	__SEOF __SERR __SIGN __SLBF __SMBF __SMOD __SNBF __SNPT __SOFF __SOPT
	__SRD __SRW __SSTR __SWR stderr stdin stdout)) {
  next if (eval "my \$a = $constname; 1");
  if ($@ =~ /^Your vendor has not defined Stdio macro $constname/) {
    print "# pass: $@";
  } else {
    print "# fail: $@";
    $fail = 1;
  }

}

ok( $fail == 0 , 'Constants' );
#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

