package Thread_Library;
use Time::HiRes qw(gettimeofday);
use POSIX qw/strftime/;
use POSIX ":sys_wait_h";
use File::Copy;

our @files;
our %checksums;
my $file_name;
sub new {
	$self = {};
	bless $self;
	return $self;
}
my $me = Thread_Library::new();


#**************************************FTP/Wget Multi Transfer Starts Here **************************

sub ftp_multi_put {
	shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $local_directory = shift;
	my $ref_files = shift;

	my @files = @{$ref_files};
	my ($ctr, $pid, @cpids,$loop);
	my $ppid = $$;
	for ($ctr=0;$ctr<=$#files;$ctr++) {
		if (!defined($pid = fork())) {
			$me->print_message("Can't fork!");
			return 0;
		}elsif ($pid == 0) {
			if (not defined($ftp = Net::FTP->new($url))) {
				$me->print_message("Couldn't connect $url");
				kill 9, $ppid;
				kill 9, @cpids;
				return 0;
			}
			if (!$ftp->login($uid,$pwd)) {
				$me->print_message("Couldn't authenticated");
				kill 9, $ppid;
				kill 9, @cpids;
				return 0;
			}
			$me->print_message("Putting file [$files[$ctr]] on FTP Server");
			if ($ftp->put("$local_directory$files[$ctr]")) {
				$me->print_message("Put $files[$ctr] successfully");
				$ftp->quit;
			}else {
				$me->print_message("Couldn't put $files[$ctr]. Perl Message: $!");
				$ftp->quit;
				kill 9, $ppid;
				kill 9, @cpids;
				return 0;
			}
			exit 0;
		}else {
			$cpids[$ctr] = $pid;
		}
	}
	for ($loop=0;$loop<=$#files;$loop++) {
		waitpid($cpids[$loop],0);
	}
	return 1;
}

sub ftp_multi_get {
	shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $local_directory = shift;
	my $ref_files = shift;

	my @files = @{$ref_files};
	my ($ctr, $pid, @cpids,$loop);
	my $ppid = $$;
	for ($ctr=0;$ctr<=$#files;$ctr++) {
		if (!defined($pid = fork())) {
			$me->print_message("Can't fork!");
			return 0;
		}elsif ($pid == 0) {
			if (not defined($ftp = Net::FTP->new($url))) {
				$me->print_message("Couldn't connect $url");
				kill 9, $ppid;
				kill 9, @cpids;
				return 0;
			}
			if (!$ftp->login($uid,$pwd)) {
				$me->print_message("Couldn't authenticated");
				kill 9, $ppid;
				kill 9, @cpids;
				return 0;
			}
			$me->print_message("Getting file [$files[$ctr]] from FTP Server");
			if ($ftp->get($files[$ctr],"$local_directory$files[$ctr]")) {
				$me->print_message("Got $files[$ctr] successfully");
				$ftp->quit;
			}else {
				$me->print_message("Couldn't get $files[$ctr]. Perl Message: $!");
				$ftp->quit;
				kill 9, $ppid;
				kill 9, @cpids;
				return 0;
			}
			exit 0;
		}else {
			$cpids[$ctr] = $pid;
		}
	}
	for ($loop=0;$loop<=$#files;$loop++) {
		waitpid($cpids[$loop],0);
	}
	return 1;
}

sub wget_multi_ftp {
	shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $local_directory = shift;
	my $ref_files = shift;

	my @files = @{$ref_files};
	my ($ctr, $pid, @cpids,$loop);
	my $ppid = $$;
	for ($ctr=0;$ctr<=$#files;$ctr++) {
		if (!defined($pid = fork())) {
			$me->print_message("Can't fork!");
			return 0;
		}elsif ($pid == 0) {
			$me->print_message("Getting file [$url$files[$ctr]] from FTP Server");
			if (!system("wget --ftp-user $uid --ftp-password $pwd --output-document $local_directory$files[$ctr] $url$files[$ctr] > nul 2>nul")) {
				$me->print_message("Got [$local_directory$files[$ctr]] successfully");
			}else {
				$me->print_message("Couldn't get [$url$files[$ctr]]. Perl Message: $!");
				kill 9, $ppid;
				kill 9, @cpids;
				return 0;
			}
			exit 0;
		}else {
			$cpids[$ctr] = $pid;
		}
	}
	for ($loop=0;$loop<=$#files;$loop++) {
		waitpid($cpids[$loop],0);
	}
	return 1;
}

sub wget_multi_http {
	shift;
	my $url = shift;
	my $local_directory = shift;
	my $ref_files = shift;

	my @files = @{$ref_files};
	my ($ctr, $pid, @cpids,$loop);
	my $ppid = $$;
	for ($ctr=0;$ctr<=$#files;$ctr++) {
		if (!defined($pid = fork())) {
			$me->print_message("Can't fork!");
			return 0;
		}elsif ($pid == 0) {
			$me->print_message("Getting file [$url$files[$ctr]] from HTTP Server to [$local_directory]");
			if (!system("wget --output-document $local_directory$files[$ctr] $url$files[$ctr] >nul 2>nul")) {
				$me->print_message("Got [$local_directory$files[$ctr]] successfully");
			}else {
				$me->print_message("Couldn't get [$url$files[$ctr]]. Perl Message: $!");
				kill 9, $ppid;
				kill 9, @cpids;
				return 0;
			}
			exit 0;
		}else {
			$cpids[$ctr] = $pid;
		}
	}
	for ($loop=0;$loop<=$#files;$loop++) {
		waitpid($cpids[$loop],0);
	}
	return 1;
}
#************************************** Verifying Multi Checksum Starts Here **************************

sub verify_multi_checksums {
	shift;
	my $ref_source_checksums = shift;
	my $ref_target_checksums = shift;

	my %source_checksums = %{$ref_source_checksums};
	my %target_checksums = %{$ref_target_checksums};

	my $key;

	foreach $key (sort keys %source_checksums){};
	foreach $key (sort keys %target_checksums){};
	#while (($key, $value) = each(%source_checksums)){
	#	print $key." => ".$value."\n";
	#}
	#while (($key, $value) = each(%target_checksums)){
	#	print $key." => ".$value."\n";
	#}
	$me->print_message("Verifying checksums");
	for $key ( keys %target_checksums ) {
			$me->print_message("Verifying checksum of $key");
			if ($target_checksums{$key} != $source_checksums{$key}) {
				$me->print_message("Checksums are not matching");
				return 0;
			}else {
				$me->print_message("Checksums are matching");
			}
	}
	return 1;
}


#************************************** Multi Copy Starts Here **************************

sub copy_multi_files {
	shift;
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
			$me->print_message("Can't fork!");
			return 0;
		}elsif ($pid == 0) {
			if (!$me->copy_file("$source_dir$source_files[$ctr]", "$target_dir$target_files[$ctr]")) {
				kill 9, $ppid;
				kill 9, @cpids;
				return 0;
			}
			exit 0;
		}else {
			$cpids[$ctr] = $pid;
		}
	}

	for ($loop=0;$loop<$#source_files;$loop++) {
		waitpid($cpids[$loop],0);
	}
	return 1;
}

sub copy_file {
	shift;
	$source = shift;
	$target = shift;

	$me->print_message("Copying $source to $target");
	if (!copy($source, $target)) {
		$me->print_message("Couldn't copy $source to $target. Perl Message: $!");
		return 0;
	}else{
		$me->print_message("Copied $source to $target");
		return 1;
	}

}





#************************************** Multi Creation Starts Here **************************

sub prepare_multi_data {
	shift;
	my $number_of_files = shift;
	my $working_folder = shift;
	my $file_type = shift;
	my $size = shift;

	my ($file,$ctr);

	if (!-d $working_folder) {
		if (!$me->create_directory($working_folder)) {
			return 0;
		}
		else {
			if (!$me->create_directory("$working_folder$file_type")) {
				return 0;
			}
			else {
				if (!$me->create_multi_files($number_of_files,$working_folder,$file_type, $size)){
					return 0;
				}else {
					for ($ctr=0;$ctr<$number_of_files;$ctr++) {
						push(@files,"$file_name$ctr");
					}
					#print @files;
					return @files;
				}
			}
		}
	}
	else {
		if(!-d "$working_folder$file_type") {
			if (!$me->create_directory("$working_folder$file_type")){
				return 0;
			}
			else {
				if (!$me->create_multi_files($number_of_files,$working_folder,$file_type, $size)){
					return 0;
				}else {
					for ($ctr=0;$ctr<$number_of_files;$ctr++) {
						push(@files,"$file_name$ctr");
					}
					#print @files;
					return @files;
				}
			}
		}
		else {
			#Search the matching file(s)
			if ($me->check_matching_file($number_of_files,"$working_folder$file_type",$size)<$number_of_files-1) {
				if (!$me->create_multi_files(($number_of_files-1-$#files),$working_folder,$file_type, $size)){
					return 0;
				}else {
					for ($ctr=$#files+1;$ctr<$number_of_files;$ctr++) {
						push(@files,"$file_name$ctr");
					}
					#print @files;
					return @files;
				}
			}elsif($#files == $number_of_files-1){
				return @files;
			}else {
				return 0;
			}
		}
	}
}

sub create_multi_files {
	shift;
	my $number_of_files = shift;
	my $working_folder = shift;
	my $file_type = shift;
	my $size = shift;

	$file_name = "File-".time;
	my ($ctr, $pid, @cpids, $loop);
	my $ppid = $$;
	print $number_of_files;
	$me->print_message("Creating files\n");
	for ($ctr=0;$ctr<$number_of_files;$ctr++) {
			if (!defined($pid = fork())) {
					print("Can't fork!");
					return 0;
			}elsif ($pid == 0) {
					if (!$me->create_file($working_folder, $file_type, $size, "$file_name$ctr")) {
							kill 9,$ppid;
							kill 9,@cpids;
							return 0;
					}
					exit 0;
			}else {
					$cpids[$ctr] = $pid;
			}
	}

	for ($loop=0;$loop<$number_of_files;$loop++) {
			waitpid($cpids[$loop],0);
	}
	return 1;
}

sub create_file {
	shift;
	my $working_folder = shift;
	my $file_type = shift;
	my $size = shift;
	my $file_name = shift;

	$me->print_message("Creating file $file_name");
	if (open(FH, ">$working_folder/$file_type/$file_name")){
		if ($file_type == 0) {
			while ($size>=1048576) {
				print FH ("0" x 1048576);
				$size = $size - 1048576;
			}
			print FH "0" x $size;
		}
		elsif ($file_type == 1)  {
			print "Yet to be done\n";
			return 0;
		}
		elsif ($file_type == 2)  {
			while ($size>=1048576) {
				print FH map (pack( "c",rand(255 )) ,  1..(1024*1024));
				$size = $size - 1048576;
			}
			print FH map (pack( "c",rand(255 )) ,  1..($size));
		}
		close(FH);
		$me->print_message("File [$file_name] created successfully");
		
		return 1;
	}
	else{
		$me->print_message("File couldn't be created. Perl Message: $!");
		return 0;
	}
}

sub create_directory {
	shift;
	my $dir_name = shift;

	$me->print_message("Creating directory [$dir_name]");
	if (mkdir($dir_name)) {
		$me->print_message("Directory created successfully");
		return 1
	}
	else {
		$me->print_message("Directory couldn't be created. Perl Message: $!");
		return 0;
	}
}


sub check_matching_file {
	shift;
	my $number_of_files = shift;
	my $working_folder = shift;
	my $size = shift;
	
	my $file;
	$me->print_message("Searching matching file(s)");
	opendir(DIR, $working_folder);
	while((defined ($file = readdir DIR)) && $#files<$number_of_files-1){
		if (-s "$working_folder/$file" == $size) {
			$me->print_message("Matching file found. File name: [$file]");
			push(@files,"$file");
		}
	}
	if ($#files>=0) {
		return $#files;
	}else {
		$me->print_message("Couldn't find any matching file");
		return -1;
	}
}

#************************************** Multi Checksums Starts Here **************************

sub calculate_multi_checksums {
	shift;
	my $working_dir = shift;
	my $ref_files = shift;

	my ($ctr, $checksum, $checksum_file);
	if ($^O eq "MSWin32") {
		$working_dir =~ s/\//\\/g;
		if (!$me->calculate_win_checksum($working_dir,$ref_files)) {
			return 0;
		} else {
			for ($ctr=0;$ctr<=$#files;$ctr++) {
				$checksum_file = $files[$ctr].".crc";
				$checksum = $me->read_checksum("$working_dir\\$checksum_file");
				$checksums{$files[$ctr]} = $checksum;
			}	
			return %checksums;
		}
	} elsif ($^O eq "linux") {
		$me->calculate_linux_checksum(); #TBD
	}	
}

sub calculate_win_checksum {
	shift;
	my $working_dir = shift;
	my $ref_files = shift;

	@files = @{$ref_files};
	my ($ctr, $pid, @cpids, $loop);
	my $ppid = $$;
	
	$me->print_message("Calculating checksums");

	for ($ctr=0;$ctr<=$#files;$ctr++) {
		if (!defined($pid = fork())) {
			$me->print_message("Can't fork!");
			return 0;
		}elsif ($pid == 0) {
			my $checksum_file = $files[$ctr].".crc";
			$me->print_message("Calculating checksum of [$files[$ctr]] in [$working_dir]");
			if (!system("fsum -jnc -d$working_dir $files[$ctr] > $working_dir\\$checksum_file 2>nul")) {
				$me->print_message("Checksum calculated of [$files[$ctr]]");
			} else {
				$me->print_message("Checksum couldn't be calculated.");
				kill 9,$ppid;
				kill 9,@cpids;
				return 0;
			}
			exit 0;
		}else {
			$cpids[$ctr] = $pid;
		}
	}
	for ($loop=0;$loop<=$#files;$loop++) {
		waitpid($cpids[$loop],0);
	}
	return 1;
}


sub calculate_linux_checksum {
	shift;
	return 0;
}


sub read_checksum {
	shift;
	my $file_name = shift;
	
	my $checksum;
	if (open(FH, $file_name)) {
		while (<FH>) {
			for $checksum (split) {
				close(FH);
				return $checksum;
			}
		}
	}else {
		print "\n\nCan't open $file_name\n\n";
		return undef;
	}
}

#************************************* Multi Checksum Ends Here ****************************************


#Today's Date
sub today
{
	shift;
	my $date=strftime("%B %d, %Y", localtime(time()));
	return $date;
}

#Current Time
sub now
{
	shift;
	my $time=strftime("%H:%M:%S", localtime(time()));
	return $time;
}

#Printing formatted output
sub print_message{
	shift;
	my $msg = shift;

	print today()."-".now().": ".$msg."\n";
}

# Extracting the system error message
sub get_error{
	shift;
	my $file_name=shift;
	
	my ($content, @contents);
	my $lines="";
	if (open(ERRORHANDLER, $file_name)) {
		@contents=<ERRORHANDLER>;
		foreach $content (@contents) {
			$lines=$lines." ".$content;
		}
		close(ERRORHANDLER);
		return $lines;
	}
	return "Couldn't open script error log file";
}

#Gets the first file name from a given directory
sub get_file_names {
	shift;
	my $dir = shift;

	my @all_files;
	opendir(DIR, $dir);
	@all_files = grep !/^\.\.?$/, readdir DIR;
	@files = grep !/^?$\.crc/, @all_files;
	closedir(DIR);
	return @files;
}


1;


