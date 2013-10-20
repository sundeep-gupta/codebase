#!/usr/bin/perl

my $exec_res;
if (-f "execution-results.txt") {
	unlink("execution-results.txt");
}
open(FH, "master-data.txt") or die "Can\t opne master-data.txt\n";
while (<FH>) {
	print FH "\n".$_."\n";
	print "Executing $_\n";
	@words = split(/ /,$_);
	$exec_res = system("perl $_ >master-result.txt >>master-result.txt");
	if ($exec_res == 0) {
		system("echo $words[0]:Pass >>execution-results.txt");
	}elsif($exec_res == 256){
		system("echo $words[0]:Fail >>execution-results.txt");
	}elsif($exec_res == 512){
		system("echo $words[0]:Error >>execution-results.txt");
	}
}
close(FH);