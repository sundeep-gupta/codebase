
if (!defined($pid=fork())) {
	die "Can't fork.";
	exit;
} elsif ($pid == 0) {
		print "\n";
		&print_numbers;
		sleep 2;
}else{
	print "\n";
	&print_chars;
	sleep 2;
}
print "\nI came out\n";

sub print_numbers {
	for ($x=1;$x<=10000;$x++) {
		print $x;
	}
}

sub print_chars {
	for ($x=100;$x>=1;$x--) {
		print "s";
	}
}