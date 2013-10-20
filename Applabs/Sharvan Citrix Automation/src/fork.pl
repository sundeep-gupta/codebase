my $number_of_files = shift || 15;
my $inline_file = shift || "inline.txt";
my $path = shift || "/tmp";
my $file_type = shift || 0;
my $size = shift || 10240000;



my $file_name = "File-".time;
my ($ctr, $pid, @cpids, $loop);
my $ppid = $$;
print("Creating files");

for ($ctr=0;$ctr<$number_of_files;$ctr++) {
		if (!defined($pid = fork())) {
				print("Can't fork!");
				exit 2;
		}elsif ($pid == 0) {
				if (!&create_file($path, $file_type, $size, "$file_name$ctr")) {
						kill 9,$ppid;
						kill 9,@cpids;
						exit 2;
				}
				exit 0;

		}else {
				$cpids[$ctr] = $pid;
		}
}

for ($loop=0;$loop<$number_of_files;$loop++) {
		waitpid($cpids[$loop],0);
}


sub create_file{
	my $path = shift;
	my $file_type = shift;
	my $size = shift;
	my $file_name = shift;

	print("Creating file $file_name\n");
	open(FH, ">$path/$file_name");
	print FH "0" x $size;
	print("File [$file_name] created successfully\n");
	close(FH);
	return 1;
}	