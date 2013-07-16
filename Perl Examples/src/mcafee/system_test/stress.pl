#!/usr/bin/perl -w


# Begin Block
BEGIN {
	unshift @INC, "include";
	use lib 'include';
	use strict;
	use Util;
	use Stress::Config;
	use Stress::Test;
}
die ("You must be 'root' to run the test!!!\n") unless( &Util::is_root() );


# Read configuration
my $stress_config = Stress::Config->new();

my $stress_test = Stress::Test->new($stress_config);

$stress_test->run();

#sleep 3600 * 24 * 5; # 5 day soak test

#$stress_test->stop();




