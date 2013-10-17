#!/usr/bin/perl
use Data::Dumper;
use WANScaler::Console;
my $var = WANScaler::Console->new({Port => 1362});
print Dumper($var);
print $var->getlines();
