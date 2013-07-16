#!/usr/bin/perl -w
use strict;

my @dirs_to_scan = (@ARGV);
my $rh_filesizes = {};
foreach my $dir (@dirs_to_scan) {
	opendir(my $dirh, $dir);
	my @elements = readdir($dirh);
	closedir($dirh);
	
	foreach my $elem (@elements) {
		next if $elem eq '.' or $elem eq '..';
		push @dirs_to_scan, "$dir/$elem" if -d "$dir/$elem";
		$rh_filesizes->{"$dir/$elem"} = (-s "$dir/$elem")/1024;
	}
}
foreach my $key (keys %$rh_filesizes) {
	print "$key ". $rh_filesizes->{$key}."\n";
}
