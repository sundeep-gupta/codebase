# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Mytest6.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 3;
BEGIN { use_ok('Mytest6') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

$results = Mytest6::multi_statfs([ '/', '/blech' ]);

	ok( ref $results->[0]);
	ok( ! ref $results->[1] );