# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Mytest2.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 4;
BEGIN { use_ok('Mytest2') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

is(&Mytest2::is_even(0), 1);
is(&Mytest2::is_even(1), 0);
is(&Mytest2::is_even(2), 1);