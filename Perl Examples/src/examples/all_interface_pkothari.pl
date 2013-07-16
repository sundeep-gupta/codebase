#! /usr/local/bin/perl5.6 -w
use strict;
use English;
use Socket;
my $name = "SKGUPTA-LAP";
my @addresses = gethostbyname($name)   or die "Can't resolve $name: $!\n";
print @addresses[0..3];
@addresses = map { inet_ntoa($_) } @addresses[4 .. $#addresses];

foreach my $val(@addresses) {
  print "$val\n";
} 
@addresses = ('sun','har');
print (join ", " ,@addresses);