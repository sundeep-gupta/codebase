#!/usr/bin/perl -w


# Begin Block
BEGIN {
	unshift @INC, "include";
	use lib 'include';
    use Util;
	use strict;
	use Soak::Config;
	use Soak::Test;
}

die ("You must be 'root' to run the test!!!\n") unless( &Util::is_root() );
# Read configuration
my $soak_config = Soak::Config->new();

my $soak_test = Soak::Test->new($soak_config);

$soak_test->run();

#sleep 3600 * 24 * 5; # 5 day soak test

#$soak_test->stop();




