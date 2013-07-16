# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Mytest5.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
BEGIN { use_ok('Mytest5') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

	@a = &Mytest5::statfs("/blech");
	ok( scalar(@a) == 1 && $a[0] == 2 );
	@a = &Mytest5::statfs("/");
	is( scalar(@a), 7 );