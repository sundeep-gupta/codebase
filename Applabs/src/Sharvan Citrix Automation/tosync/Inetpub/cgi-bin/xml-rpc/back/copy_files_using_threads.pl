use File::Copy;

my $source_dir = shift;
my $ref_source_files = shift;
my $target_dir = shift;
my $ref_target_files = shift;

my @source_files = @{$ref_source_files};
my @target_files = @{$ref_target_files};

my ($ctr, $pid, @cpids,$loop);
my $ppid = $$;
for ($ctr=0;$ctr<=$#source_files;$ctr++) {
	if (!defined($pid = fork())) {
		exit 2;
	}elsif ($pid == 0) {
		if (!&copy_file("$source_dir$source_files[$ctr]", "$target_dir$target_files[$ctr]")) {
			kill 9, $ppid;
			kill 9, @cpids;
			exit 2;
		}
		exit 0;
	}else {
		$cpids[$ctr] = $pid;
	}
}

for ($loop=0;$loop<$#source_files;$loop++) {
	waitpid($cpids[$loop],0);
}
exit 0;

sub copy_file {
	$source = shift;
	$target = shift;

	if (!File::Copy::copy($source, $target)) {
		return 0;
	}else{
		return 1;
	}

}