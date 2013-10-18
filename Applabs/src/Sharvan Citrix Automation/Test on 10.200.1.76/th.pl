
if (!defined($kidpid = fork())) {
    # fork returned undef, so failed
    die "cannot fork: $!";
} elsif ($kidpid == 0) {
                # fork returned 0, so this branch is the child
    &child;
} else { 
                # fork returned neither 0 nor undef, 
                # so this branch is the parent
    
	&parent;
	waitpid($kidpid, 0);
} 

print "I am a outsider\n";


sub child {
	for ($x=0;$x<=10000;$x++) {
		print $x;
    }
}

sub parent {
	for ($y=0;$y<=100000;$y++) {
		print "P";
    }
}