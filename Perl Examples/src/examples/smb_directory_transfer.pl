use File::Copy;

$smb_share = shift;
$smb_user = shift;
$smb_password = shift;

my @dirs;
my $dir_count = 0;

system("mkdir /tmp/temp");
system("smbmount $smb_share /tmp/temp -o password=$smb_password");

&get_dir("/tmp/temp");

#smbclient \\\\172.16.1.3\\c$ -U jwhittal -Tc backup.995.tar pdf995/
            
for($ctr=0;$ctr<$dir_count;$ctr++) {
	if (!defined($kidpid = fork()))         {
		# fork returned undef, so failed
		die "cannot fork: $!";
	}elsif ($kidpid == 0) {
		# fork returned 0, so this branch is the child
		if(!&transfer_data("$dirs[$ctr]/","/tmp/$ctr.tar")){
				print "Killing The Running Threads => ";
				kill 9,@pid;
				exit 2;
		}
		exit 0;
	} else {
		# fork returned neither 0 nor undef,
		# so this branch is the parent
		$pid[$ctr]=$kidpid;
	}
}
for($i=0;$i<$dir_count;$i++) {
	waitpid($pid[$i],0);
}

system("umount /tmp/temp");
system("rm -rf /tmp/temp");
system("rm -f /tmp/*.tar");
print "Completed\n";

sub transfer_data {
	$source = shift;
	$target = shift;

	if (system"smbclient $smb_share -U $smb_user -Tc $target $source") {
		print "Couldn't connect to Samba: $!\n";
	}else {
		print "Transferring directory $source to $target_dir\\n";
		if (copy($source, $target_dir)) {
				print "File $source transferred successfully\\n";
				return 1;
		}else {
				print "File $source couldn't be transferred: $!\\n";
				return 0;
		}
	}
}

sub get_dirs{
        my $source_dir = shift;
        opendir(DIR, $source_dir) || die "can't opendir $source_dir: $!";
        while ($file=readdir(DIR)) {
                if (($file ne '.') && ($file ne '..')) {
					if (-d $file) {
                        $dirs[$x] = "$source_dir/$file";
                        $dir_count = $dir_count+1;
                        #print $file."\\n";
					}
                }
        }
        closedir DIR;
}