#!/usr/bin/perl -w

BEGIN {
    use Cwd 'abs_path';
    my $abs_path = abs_path($0);
    $abs_path =~ s/(.*)\/.*$/$1/;
    chdir $abs_path;
    unshift @INC, "$abs_path/include";
}
use Util;
    use strict;
    use Performance::Config;
    use Performance::Test;



die ("You must be 'root' to run the test!!!\n") unless( &Util::is_root() );
&Util::add_login_item(&Cwd::abs_path($0));
&Util::enable_auto_login();

# Read configuration
my $performance_config = Performance::Config->new();

my $performance_test = Performance::Test->new($performance_config);

$performance_test->run();

#sleep 3600 * 24 * 5; # 5 day soak test

#$performance_test->stop();




