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


sub prepare_data {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $share_path = shift;
	my $file_type = shift;
	my $size = shift;

	my $file;

	if (!-d $share_path) {
		if (!&create_directory($share_path)) {
			return undef;
		}
		else {
			if (!&create_directory("$share_path/$file_type")) {
				return undef;
			}
			else {
				if (($file = &create_file("$share_path/$file_type",$file_type, $size)) eq undef){
					return undef;
				}
			}
		}
	}
	else {
		if(!-d "$share_path/$file_type") {
			if (!&create_directory("$share_path/$file_type")){
				return undef;
			}
			else {
				if (($file = &create_file("$share_path/$file_type",$file_type, $size)) eq undef){
					return undef;
				}
			}
		}
		else {
			#Search the matching file(s)
			if (($file = &check_matching_file("$share_path/$file_type",$size)) eq undef) {
				if (($file = &create_file("$share_path/$file_type",$file_type, $size)) eq undef){
					return undef;
				}
			}
		}
	}
	return $file;
}

sub create_file {
	my $path = shift;
	my $file_type = shift;
	my $size = shift;

	my $file_name = "File-".time;
	if (open(FH, ">$path/$file_name")){
		if ($file_type == 0) {
			while ($size>=1048576) {
				print FH ("0" x 1048576);
				$size = $size - 1048576;
			}
			print FH "0" x $size;
		}
		elsif ($file_type == 1)  {
			return undef; #"Yet to be done"
		}
		elsif ($file_type == 2)  {
			while ($size>=1048576) {
				print FH map (pack( "c",rand(255 )) ,  1..(1024*1024));
				$size = $size - 1048576;
			}
			print FH map (pack( "c",rand(255 )) ,  1..($size));
		}
		close(FH);
		return $file_name;
	}
	else{
		return undef;
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


sub check_matching_file {
	$path = shift;
	$size = shift;
	
	opendir(DIR, $path);
	while(defined ($file = readdir DIR)){
		if (-s "$path/$file" == $size) {
			closedir(DIR);
			return $file;
		}
	}
	closedir(DIR);
	return undef;
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

#sharing a folder
sub share_folder{
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $share_name = shift;
	my $share_path = shift;
	
	if ($^O eq "MSWin32") {
		if (&share_windows($share_name, $share_path)) {
			return 1;
		} else {
			return 0;
		}
	} elsif ($^O eq "linux") {
		if (&map_linux($share_name, $share_path)) {
			return 1;
		} else {
			return 0;
		}
	}	

}

sub share_windows {
	my $share_name = shift;
	my $share_path = shift;
	
	if (Win32::NetResource::GetSharedResources(my $resources, RESOURCETYPE_DISK,{RemoteName => "\\\\" . Win32::NodeName()})){
		foreach my $href (@$resources) {
			foreach(keys %$href) { 
				if (($_ eq "RemoteName") && ($href->{$_} eq "\\\\" . Win32::NodeName()."\\$share_name")){
					if (!Win32::NetResource::NetShareDel("$share_name")) {
						return 0;
					}
				}
			}
		}
	}
	if (! -d $share_path) {
		if (!mkdir $share_path) {
			return 0;
		}
	}
	if (! -d $share_path) {
			if (!mkdir $share_path) {
				return 0;
			}
		}
	if (! -d "$share_path/0") {
		if (!mkdir "$share_path/0") {
			return 0;
		}
	}
	if (! -d "$share_path/1") {
		if (!mkdir "$share_path/1") {
			return 0;
		}
	}
	if (! -d "$share_path/2") {
		if (!mkdir "$share_path/2") {
			return 0;
		}
	}	
	my $ShareInfo = {
				'path' => "c:\\kshare",
				'netname' => "kshare",
				'remark' => "It is good to share",
				'passwd' => "",
				'current-users' =>0,
				'permissions' => 0,
				'maxusers' => -1,
				'type'  => 0,
				};
    
	if (Win32::NetResource::NetShareAdd( $ShareInfo, my $parm )) {
		open(FH,">c:/out.txt");
		print FH "Added";
		close(FH);
		return 1;
	}else {
		return 0;
	}
}

	
sub share_linux {	

	my $share_name = shift;
	my $share_path = shift;

	if (!system("service smb restart > $script_log 2>$script_error_log")) {
		return 1;
	}else {
		return 0;
	}

}


# Extracting the system error message
sub get_error{

	my $file_name=shift;
	
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

#Today's Date
sub today
{

	my $date=strftime("%B %d, %Y", localtime(time()));
	return $date;
}

#Current Time
sub now
{

	my $time=strftime("%H:%M:%S", localtime(time()));
	return $time;
}

#Printing formatted output
sub print_message{

	my $msg = shift;

	print today()."-".now().": ".$msg."\n";
}

sub calculate_checksum {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $working_dir = shift;
	my $file_name = shift;
	
	my $checksum_file = $file_name.".crc";
	if ($^O eq "MSWin32") {
		$file_name =~ s/\//\\/g;
		$working_dir =~ s/\//\\/g;
		if (!system("fsum -jnc -d$working_dir $file_name > $working_dir\\$checksum_file 2>nul")) {
			return &read_checksum("$working_dir/$checksum_file");
		} else {
			return undef;
		}
	} elsif ($^O eq "linux") {
		if (!system("md5sum $file_name > $working_dir$checksum_file 2>nul")) {
			return "$working_dir$checksum_file";
		} else {
			return undef;
		}
	}		
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

sub delete_file {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $file_name = shift;

	if ($^O eq "MSWin32") {
		$file_name =~ s/\//\\/g;
		if (!system("del /q $file_name >nul 2>nul")) {
			return 1;
		} else {
			return 0;
		}
	} elsif ($^O eq "linux") {
		if (!system("rm -rf $file_name >nul 2>nul")) {
			return 1;
		} else {
			return 0;
		}
	}	
}

sub put_ftp {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $local_file = shift;
	my $remote_file = shift || $file;

	if (not defined($ftp = Net::FTP->new($url))) {
		return 0;
	}
	if (!$ftp->login($uid,$pwd)) {
		return 0;
	}
	if ($ftp->put($local_file, "ftp-path$remote_file")) {
		$ftp->quit;
		return 1;
	}else {
		$ftp->quit;
		return 0;
	}
}

sub get_ftp {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $remote_file = shift;
	my $local_file = shift || $remote_file;

	if (not defined($ftp = Net::FTP->new($url))) {
		return 0;
	}
	if (!$ftp->login($uid,$pwd)) {
		return 0;
	}
	if ($ftp->get("ftp-path$remote_file",$local_file)) {
		$ftp->quit;
		return 1;
	}else {
		$ftp->quit;
		return 0;
	}
}

sub wget_ftp {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $local_file = shift;
	
	if (!system("wget --ftp-user $uid --ftp-password $pwd --output-document $local_file $url >nul 2>nul")) {
		return 1;
	}else {
		return 0;
	}
}

sub wget_http {
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $url = shift;
	my $local_file = shift;
	
	if (!system("wget --output-document $local_file $url >nul 2>nul")) {
		return 1;
	}else {
		return 0;
	}
}
