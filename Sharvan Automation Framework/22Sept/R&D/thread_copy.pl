
use File::Copy;

$CONNECTIONS=5;
my ($ctr, $pid, @cpids, @target_checksums, $loop);
my $ppid = $$;
for ($ctr=0;$ctr<$CONNECTIONS;$ctr++) {
	print "Coming\n";
	if (!defined($pid = fork())) {
		$global_library->print_message("Can't fork!");
		exit 2;
	}elsif ($pid == 0) {
		if (!copy_file("k:/File-1158951167", "/tmp/File-1158951167$ctr")) {
			kill 9, $ppid;
			kill 9, @cpids;
			exit 2;
		}
		exit 0;
	}else {
		$cpids[$ctr] = $pid;
	}
}

for ($loop=0;$loop<$CONNECTIONS;$loop++) {
	waitpid($cpids[$loop],0);
}


sub copy_file {
	$source = shift;
	$target = shift;

	print "Copying $target\n";
	if (!copy($source, $target)) {
		return 0;
	}else{
		print "Copied $target\n";
		return 1;
	}

}