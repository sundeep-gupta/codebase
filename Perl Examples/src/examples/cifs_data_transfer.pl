use File::Copy;

$smb_share = $ARGV[0];
$smb_password = $ARGV[1];
$threadcount = $ARGV[2];
$target_dir = $ARGV[3];
my @files;

for($ctr=0; $ctr<$threadcount;$ctr++) {
        system("mkdir /tmp/$ctr");
        system("smbmount $smb_share /tmp/$ctr -o password=$smb_password");
        $files[$ctr]=&get_file("/tmp/$ctr",$ctr);
}

while(1)
{
for($fc=0;$fc<$threadcount;$fc++)       {
        if (!defined($kidpid = fork()))         {
                # fork returned undef, so failed
                die "cannot fork: $!";
        }elsif ($kidpid == 0) {
                # fork returned 0, so this branch is the child
                if(!&transfer_data($files[$fc], $target_dir))   {
                        print "Killing The Running Threads => ";
                #        kill 9,$ppid;
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
for($i=0;$i<$threadcount;$i++) {
        waitpid($pid[$i],0);
}
}
sub transfer_data {
        $source = shift;
        $target_dir = shift;

        print "Transferring file $source to $target_dir\\n";
        if (copy($source, $target_dir)) {
                print "File $source transferred successfully\\n";
                return 1;
        }else {
                print "File $source couldn't be transferred: $!\\n";
                return 0;
        }
}


sub get_file {
        my $source_dir = shift;
        my $count = shift;

        $x = 0;
        my @files;
        opendir(DIR, $source_dir) || die "can't opendir $source_dir: $!";
        while ($file=readdir(DIR)) {
                if (($file ne '.') and ($file ne '..')) {
                        $files[$x] = "$source_dir/$file";
                        $x = $x+1;
                        #print $file."\\n";
                }
        }
        closedir DIR;
        return $files[$count];
}

}
 