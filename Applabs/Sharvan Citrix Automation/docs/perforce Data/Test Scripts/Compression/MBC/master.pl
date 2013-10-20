#!/usr/bin/perl

open(FH, "master-data.txt") or die "Can\t opne master-data.txt\n";
while (<FH>) {
	print FH "\n".$_."\n";
	print "Executing $_\n";
	system("$_ > master-result.txt");
}
close(FH);