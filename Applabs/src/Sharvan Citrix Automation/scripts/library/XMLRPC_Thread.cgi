use File::Find;
use File::Copy;
use Time::HiRes qw(gettimeofday);
use POSIX qw/strftime/;
use File::Path;
use XMLRPC::Transport::HTTP;
use Win32::NetResource qw(:DEFAULT GetSharedResources GetError NetShareDel NetShareAdd);
use Net::FTP;

my $server = XMLRPC::Transport::HTTP::CGI
-> dispatch_to('RPC')
-> handle
;

package RPC;

my ($file_name, @files);

sub copy_files_using_threads {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $source_dir = shift;
	my $ref_source_files = shift;
	my $target_dir = shift;
	my $ref_target_files = shift;

	my @source_files = @{$ref_source_files};
	my @target_files = @{$ref_target_files};

	my ($ctr, $pid, @cpids,$loop);
	for ($ctr=0;$ctr<=$#source_files;$ctr++) {
		
		if (!defined($pid = fork())) {
			return 0;
		}elsif ($pid == 0) {
			if (!&File::Copy::copy("$source_dir/$source_files[$ctr]", "$target_dir/$target_files[$ctr]")) {         #Tikka
				kill 9, @cpids;
				return 0;
			}
			exit 0;
		}else {
			$cpids[$ctr] = $pid;
		}
	}
	for ($loop=0;$loop<=$#source_files;$loop++) {
		waitpid($cpids[$loop],0);
	}
	return 1;
}


sub copy_file {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $source = shift;
	my $target = shift;

	if (File::Copy::copy($source, $target)) {
		return 1;
	}else {
		return 0;
	}
}

sub delete_files_using_threads {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $dir = shift;
	my $ref_files = shift;

	my @files = @{$ref_files};

	my ($ctr, $pid, @cpids,$loop);
	for ($ctr=0;$ctr<=$#files;$ctr++) {
		
		if (!defined($pid = fork())) {
			return 0;
		}elsif ($pid == 0) {
			if (!unlink("$dir/$files[$ctr]")) {
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

#************************************** Multi Checksums Starts Here **************************

sub calculate_multi_checksums {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $working_dir = shift;
	my $ref_files = shift;

	my @files = @{$ref_files};
	my ($ctr, $checksum, $checksum_file, %checksums);
	if ($^O eq "MSWin32") {
		$working_dir =~ s/\//\\/g;
		if (!&calculate_win_checksum($working_dir,\@files)) {
			return 0;
		} else {
			for ($ctr=0;$ctr<=$#files;$ctr++) {
				$checksum_file = $files[$ctr].".crc";
				$checksum = &read_checksum("$working_dir\\$checksum_file");
				$checksums{$files[$ctr]} = $checksum;
			}
			return \%checksums;
		}
	} elsif ($^O eq "linux") {
		&calculate_linux_checksum(); #TBD
	}	
}

sub calculate_win_checksum {
	my $working_dir = shift;
	my $ref_files = shift;

	@files = @{$ref_files};
	my ($ctr, $pid, @cpids, $loop);
	
	for ($ctr=0;$ctr<=$#files;$ctr++) {
		if (!defined($pid = fork())) {
			return 0;
		}elsif ($pid == 0) {
			my $checksum_file = $files[$ctr].".crc";
			if (system("fsum -jnc -d$working_dir $files[$ctr] > $working_dir\\$checksum_file 2>nul")) {
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
	return 0;
}

sub read_checksum {
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
		return undef;
	}
}

#**************************************FTP/Wget Multi Transfer Starts Here **************************

sub put_ftp_using_threads {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $source_dir = shift;
	my $ref_source_files = shift;
	my $target_dir = shift;
	my $ref_target_files = shift;

	my @source_files = @{$ref_source_files};
	my @target_files = @{$ref_target_files};

	my ($ctr, $pid, @cpids,$loop);
	for ($ctr=0;$ctr<=$#source_files;$ctr++) {
		if (!defined($pid = fork())) {
			return 0;
		}elsif ($pid == 0) {
			if (not defined($ftp = Net::FTP->new($url))) {
				kill 9, @cpids;
				return 0;
			}
			if (!$ftp->login($uid,$pwd)) {
				kill 9, @cpids;
				return 0;
			}
			if ($ftp->put("$source_dir/$source_files[$ctr]","$target_dir/$target_files[$ctr]")) {
				$ftp->quit;
			}else {
				$ftp->quit;
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

sub get_ftp_using_threads {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $source_dir = shift;
	my $ref_source_files = shift;
	my $target_dir = shift;
	my $ref_target_files = shift;

	my @source_files = @{$ref_source_files};
	my @target_files = @{$ref_target_files};

	my ($ctr, $pid, @cpids,$loop);
	for ($ctr=0;$ctr<=$#source_files;$ctr++) {
		if (!defined($pid = fork())) {
			return 0;
		}elsif ($pid == 0) {
			if (not defined($ftp = Net::FTP->new($url))) {
				kill 9, @cpids;
				return 0;
			}
			if (!$ftp->login($uid,$pwd)) {
				kill 9, @cpids;
				return 0;
			}
			if ($ftp->get("$source_dir/$source_files[$ctr]","$target_dir/@target_files[$ctr]")) {
				$ftp->quit;
			}else {
				$ftp->quit;
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

sub wget_ftp_using_threads {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $source_dir = shift;
	my $ref_source_files = shift;
	my $target_dir = shift;
	my $ref_target_files = shift;
	
	my @source_files = @{$ref_source_files};
	my @target_files = @{$ref_target_files};
	my ($ctr, $pid, @cpids,$loop);
	for ($ctr=0;$ctr<=$#source_files;$ctr++) {
		if (!defined($pid = fork())) {
			return 0;
		}elsif ($pid == 0) {
			if (system("wget --ftp-user $uid --ftp-password $pwd --output-document $target_dir/$target_files[$ctr] $url$source_dir/$source_files[$ctr] >nul 2>nul")) {
				kill 9, @cpids;
				return 0;
			}
			exit 0;
		}else {
			$cpids[$ctr] = $pid;
		}
	}
	for ($loop=0;$loop<=$#source_files;$loop++) {
		waitpid($cpids[$loop],0);
	}
	return 1;
}

sub wget_http_using_threads {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $url = shift;
	my $source_dir = shift;
	my $ref_source_files = shift;
	my $target_dir = shift;
	my $ref_target_files = shift;
	
	my @source_files = @{$ref_source_files};
	my @target_files = @{$ref_target_files};
	my ($ctr, $pid, @cpids,$loop);
	for ($ctr=0;$ctr<=$#source_files;$ctr++) {
		if (!defined($pid = fork())) {
			return 0;
		}elsif ($pid == 0) {
			if (system("wget --output-document $target_dir/$target_files[$ctr] $url$source_dir/$source_files[$ctr] >nul 2>nul")) {
				kill 9, @cpids;
				return 0;
			}
			exit 0;
		}else {
			$cpids[$ctr] = $pid;
		}
	}
	for ($loop=0;$loop<=$#source_files;$loop++) {
		waitpid($cpids[$loop],0);
	}
	return 1;
}

#************************************** Multi Creation Starts Here **************************

sub prepare_multi_data {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $number_of_files = shift;
	my $working_folder = shift;
	my $file_type = shift;
	my $size = shift;

	my $ctr;

	if (!-d $working_folder) {
		if (!&create_directory($working_folder)) {
			return 0;
		}
		else {
			if (!&create_directory("$working_folder/$file_type")) {
				return 0;
			}
			else {
				if (!&create_multi_files($number_of_files,$working_folder,$file_type, $size)){
					return 0;
				}else {
					for ($ctr=0;$ctr<$number_of_files;$ctr++) {
						push(@files,"$file_name$ctr");
					}
					return \@files;
				}
			}
		}
	}
	else {
		if(!-d "$working_folder/$file_type") {
			if (!&create_directory("$working_folder/$file_type")){
				return 0;
			}
			else {
				if (!&create_multi_files($number_of_files,$working_folder,$file_type, $size)){
					return 0;
				}else {
					for ($ctr=0;$ctr<$number_of_files;$ctr++) {
						push(@files,"$file_name$ctr");
					}
					return \@files;
				}
			}
		}
		else {
			#Search the matching file(s)
			if (&check_matching_file($number_of_files,"$working_folder/$file_type",$size)<$number_of_files-1) {
				if (!&create_multi_files(($number_of_files-1-$#files),$working_folder,$file_type, $size)){
					return 0;
				}else {
					for ($ctr=$#files+1;$ctr<$number_of_files;$ctr++) {
						push(@files,"$file_name$ctr");
					}
					return \@files;
				}
			}elsif($#files == $number_of_files-1){
				return \@files;
			}else {
				return 0;
			}
		}
	}
}


sub check_matching_file {
	my $number_of_files = shift;
	my $working_folder = shift;
	my $size = shift;
	
	my $file;
	opendir(DIR, $working_folder);
	while((defined ($file = readdir DIR)) && $#files<$number_of_files-1){
		if (-s "$working_folder/$file" == $size) {
			push(@files,"$file");
		}
	}
	if ($#files>=0) {
		return $#files;
	}else {
		return 0;
	}

}


sub create_multi_files {
	my $number_of_files = shift;
	my $working_folder = shift;
	my $file_type = shift;
	my $size = shift;

	$file_name = "File-".time;
	my ($ctr, $pid, @cpids, $loop);
	for ($ctr=0;$ctr<$number_of_files;$ctr++) {
			if (!defined($pid = fork())) {
					return 0;
			}elsif ($pid == 0) {
					if (!&create_file($working_folder, $file_type, $size, "$file_name$ctr")) {
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
	my $working_folder = shift;
	my $file_type = shift;
	my $size = shift;
	my $file_name = shift;

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
		
		return 1;
	}
	else{
		return 0;
	}
}

sub create_directory {
	my $dir_name = shift;

	if (mkdir($dir_name)) {
		return 1
	}
	else {
		return 0;
	}
}

