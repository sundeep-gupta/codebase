#!/usr/bin/perl

open(my $fh, $ARGV[0]);
my @arr = <$fh>;
close($fh);
my $cr = chr(015);
foreach my $line (@arr) {
    chomp $line;
    if ($line =~ /$cr$/) {
        print $line;
        print "\n";
    }
}
