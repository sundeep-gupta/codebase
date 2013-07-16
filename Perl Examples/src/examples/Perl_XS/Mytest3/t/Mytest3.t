# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Mytest3.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 6;
BEGIN { use_ok('Mytest3') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

$i = -1.5; &Mytest3::round($i); is( $i, -2.0 );
$i = -1.1; &Mytest3::round($i); is( $i, -1.0 );
$i = 0.0; &Mytest3::round($i);  is( $i,  0.0 );
$i = 0.5; &Mytest3::round($i);  is( $i,  1.0 );
$i = 1.2; &Mytest3::round($i);  is( $i,  1.0 );