use File::Copy;

$source_dir = $ARGV[0];
$target_dir = $ARGV[1];

my @files;
$threadcount = 0;
opendir(DIR, $source_dir) || die "can't opendir $some_dir: $!";
while ($file=readdir(DIR)) {
	if (($file ne '.') and ($file ne '..')) {
		$files[$threadcount] = "$source_dir/$file";
		$threadcount = $threadcount+1;
		#print $file."\n";
	}
}
closedir DIR;


for($fc=0;$fc<$threadcount;$fc++)	{
	if (!defined($kidpid = fork())) 	{
		# fork returned undef, so failed
		die "cannot fork: $!";
	}elsif ($kidpid == 0) {
		# fork returned 0, so this branch is the child
		if(!&transfer_data($files[$fc], $target_dir))	{
			print "Killing The Running Threads => ";
			kill 9,$ppid;
			kill 9,@pid;
			exit 2;
		}
		exit 0;
	} else { 
		# fork returned neither 0 nor undef, 
		# so this branch is the parent
		$pid[$fc]=$kidpid;
	}
}
for($i=1;$i<=$threadcount;$i++) {
	waitpid($pid[$i],0);
}

sub transfer_data {
	$source = shift;
	$target_dir = shift;

	print "Transferring file $source to $target_dir\n";
	if (copy($source, $target_dir)) {
		print "File $source transferred successfully\n";
		return 1;
	}else {
		print "File $sorce couldn't be transferred: $!\n";
		return 0;
	}
}