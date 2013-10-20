for ($x=1;$x<=10;$x++) {
	$pid = fork();
	if (not defined $pid) {
		print "resources not avilable.\n";
	} elsif ($pid == 0) {
		&print_numbers($x);
		exit(0);
	} else {
		waitpid($pid,0);
	}
}


sub print_numbers {
	for ($x=1;$x<=100000;$x++) {
	}
	print "End nums\n";
}

sub print_chars {
	for ($x=1;$x<=10;$x++) {
	}
	print "End chars\n";
}

sub print_hash {
	for ($x=1;$x<=1000;$x++) {
		print "#";
	}
}