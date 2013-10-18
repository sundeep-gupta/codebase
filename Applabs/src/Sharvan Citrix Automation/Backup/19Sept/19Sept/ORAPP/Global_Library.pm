#!/usr/bin/perl
package Global_Library;
use File::Find;
use File::Copy;
use Time::HiRes qw(gettimeofday);
use POSIX qw/strftime/;
use Net::FTP;
use File::Path;

sub new {
	$self = {};
	bless $self;
	return $self;
}

my $config = Config::new();
my $me = Global_Library::new();
my $script_log =  $config->{"SCRIPT_LOG"};
my $script_error_log =  $config->{"SCRIPT_ERROR_LOG"};

sub check_matching_file {
	shift;
	$path = shift;
	$size = shift;
	
	$me->print_message("Searching matching file");
	opendir(DIR, $path);
	while(defined ($file = readdir DIR)){
		if (-s "$path/$file" == $size) {
			$me->print_message("Matching file found. File name: [$file]");
			return $file;
		}
	}
	$me->print_message("Couldn't find any matching file");
	return undef;
}

sub prepare_data {
	shift;
	my $working_folder = shift;
	my $TYPE_OF_FILE = shift;
	my $size = shift;

	my $file;

	if (!-d $working_folder) {
		if (!$me->create_directory($working_folder)) {
			return undef;
		}
		else {
			if (!$me->create_directory("$working_folder$TYPE_OF_FILE")) {
				return undef;
			}
			else {
				if (($file = $me->create_file("$working_folder$TYPE_OF_FILE",$TYPE_OF_FILE, $size)) eq undef){
					return undef;
				}
			}
		}
	}
	else {
		if(!-d "$working_folder$TYPE_OF_FILE") {
			if (!$me->create_directory("$working_folder$TYPE_OF_FILE")){
				return undef;
			}
			else {
				if (($file = $me->create_file("$working_folder$TYPE_OF_FILE",$TYPE_OF_FILE, $size)) eq undef){
					return undef;
				}
			}
		}
		else {
			#Search the matching file(s)
			if (($file = $me->check_matching_file("$working_folder$TYPE_OF_FILE",$size)) eq undef) {
				if (($file = $me->create_file("$working_folder$TYPE_OF_FILE",$TYPE_OF_FILE, $size)) eq undef){
					return undef;
				}
			}
		}
	}
	return $file;
}


sub map_share {
	shift;
	my $server = shift;
	my $share = shift;
	
	my $shared;
	if ($^O eq "MSWin32") {
		if (($shared = $me->map_windows($server, $share)) eq undef) {
			return undef;
		} else {
			return $shared;
		}
	} elsif ($^O eq "linux") {
		if (($shared = $me->map_linux($server, $share)) eq undef) {
			return undef;
		} else {
			return $shared;
		}
	}		
}

sub map_windows {
	shift;
	my $server = shift;
	my $share = shift;
	
	my $count = 0;
	@drives = ('k:','l:','m:','n:','o:','p:','q:','r:','s:','t:');
	$me->print_message("Mapping the shared folder");
	foreach (@drives) {
		system("net use $_ /delete > $script_log 2>$script_error_log");
		if (!system("net use $_ \\\\$server\\$share > $script_log 2>$script_error_log")) {
			$me->print_message("Mapped the drive [$_] successfully");
			return "$_";
		}
		
	}
	my $system_error=$me->get_error($script_error_log);
	$me->print_message("Couldn't map the drive. Perl Message: $system_error");
	return undef;
}

sub map_linux {
	shift;
	my $server = shift;
	my $share = shift;

	$me->print_message("Mapping the shared folder");
	if (!system("mount -t smbfs //$server/$share /tmp > $script_log 2>$script_error_log")) {
		$me->print_message("Mapped the folder /tmp successfully");
		return "/tmp";
	} else {
		my $system_error=$me->get_error($script_error_log);
		$me->print_message("Couldn't map the drive. Perl Message: $system_error");
		return undef;
	}
}


sub create_file {
	shift;
	my $path = shift;
	my $file_type = shift;
	my $size = shift;


	$me->print_message("Creating file");
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
			print "Yet to be done\n";
			#return undef;
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
		return $file_name;
	}
	else{
		$me->print_message("File couldn't be created. Perl Message: $!");
		return undef;
	}
}



sub delete_file {
	shift;
	my $file_name = shift;

	$me->print_message("Deleting file(s) [$file_name]");

	if ($^O eq "MSWin32") {
			$file_name =~ s/\//\\/g;
			if (!system("del /q $file_name >$script_log 2>$script_error_log")) {
				$me->print_message("File deleted successfully");
				return 1;
			} else {
				$me->print_message("File couldn't be deleted");
				return 0;
			}
		} elsif ($^O eq "linux") {
			if (!system("rm -r $file_name >$script_log 2>$script_error_log")) {
				$me->print_message("File deleted successfully");
				return 1;
			} else {
				$me->print_message("File couldn't be deleted");
				return 0;
			}
		}	
}

sub copy_file {
	shift;
	my $source = shift;
	my $target = shift;

	my ($sec1, $usec1) = gettimeofday();
	$me->print_message("Copying file [$source] to [$target]");
	if (copy($source, $target)) {
		$me->print_message("File [$source] copied successfully to [$target]");
	} else {
		$me->print_message("File couldn't be copied. Perl Message: $!");
		return undef;
	}
	my($sec2, $usec2) = gettimeofday();

	my $sec = ($sec2-$sec1)+(((1000000-$usec1)+$usec2)/1000000);
	return ($sec);
}


sub ftp_put {
	shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $file = shift;
	my $remote_file = shift || $file;
	print $remote_file;

	my ($sec1, $usec1) = gettimeofday();
	$me->print_message("Connecting to FTP server");
	if ($ftp = Net::FTP->new($url)) {
		$me->print_message("Connected");
	}else {
		$me->print_message("Cannot connect");
		return undef;
	}
	$me->print_message("Authenticating to FTP server");
	if ($ftp->login($uid,$pwd)) {
		$me->print_message("Authenticated");
	}else {
		$me->print_message("Couldn't authenticate");
		return undef;
	}
	$me->print_message("Putting file [$file] on FTP Server");
	if ($ftp->put($file, $remote_file)) {
		$me->print_message("Put successfully");
		$ftp->quit;
		my($sec2, $usec2) = gettimeofday();
		my $sec = ($sec2-$sec1)+(((1000000-$usec1)+$usec2)/1000000);
		return ($sec);
	}else {
		$me->print_message("Put failed");
		$ftp->quit;
		return undef;
	}
}

sub ftp_get {
	shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $file = shift;
	my $local_file = shift;

	
	$me->print_message("Connecting to FTP server");
	if ($ftp = Net::FTP->new($url)) {
		$me->print_message("Connected");
	}else {
		$me->print_message("Cannot connect");
		return undef;
	}
	$me->print_message("Authenticating to FTP server");
	if ($ftp->login($uid,$pwd)) {
		$me->print_message("Authenticated");
	}else {
		$me->print_message("Couldn't authenticate");
		return undef;
	}
	my ($sec1, $usec1) = gettimeofday();
	$me->print_message("Getting file [$file] from FTP Server");
	if ($ftp->get($file,$local_file)) {
		$me->print_message("Got successfully");
		$ftp->quit;
		my($sec2, $usec2) = gettimeofday();
		my $sec = ($sec2-$sec1)+(((1000000-$usec1)+$usec2)/1000000);
		return ($sec);
	}else {
		$me->print_message("Get failed");
		$ftp->quit;
		return undef;
	}
}

sub wget_ftp {
	shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $local_file = shift;
	my ($sec1, $usec1) = gettimeofday();
	$me->print_message("Getting file [$url] from FTP Server");
	if (!system("wget --ftp-user $uid --ftp-password $pwd --output-document $local_file $url > $script_log 2>$script_error_log")) {
		$me->print_message("Got successfully");
		my($sec2, $usec2) = gettimeofday();
		my $sec = ($sec2-$sec1)+(((1000000-$usec1)+$usec2)/1000000);
		return ($sec);
	}else {
		my $system_error=$me->get_error($script_error_log);
		$me->print_message("Couldn't get the file. Perl Message: $!");
		return undef;
	}
}


sub wget_http {
	shift;
	my $url = shift;
	my $local_file = shift;

	my ($sec1, $usec1) = gettimeofday();
	$me->print_message("Getting file [$url] from HTTP Server");
	if (!system("wget --output-document $local_file $url > $script_log 2>$script_error_log")) {
		$me->print_message("Got successfully");
		my($sec2, $usec2) = gettimeofday();
		my $sec = ($sec2-$sec1)+(((1000000-$usec1)+$usec2)/1000000);
		return ($sec);
	}else {
		my $system_error=$me->get_error($script_error_log);
		$me->print_message("Couldn't get the file. Perl Message: $!");
		return undef;
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

sub calculate_checksum {
	shift;
	my $working_dir = shift;
	my $file_name = shift;
	
	my $checksum_file = $file_name.".crc";
	if ($^O eq "MSWin32") {
		$me->print_message("Calculating checksum of [$file_name] in [$working_dir]");
		$file_name =~ s/\//\\/g;
		if (!system("fsum -jnc -d$working_dir $file_name > $working_dir\\$checksum_file 2>$script_error_log")) {
			$me->print_message("Checksum calculated");
			sleep(2);
			return $me->read_checksum("$working_dir$checksum_file");
		} else {
			my $system_error=$me->get_error($script_error_log);
			$me->print_message("Checksum couldn't be calculated. Perl Message: $system_error");
			return undef;
		}
	} elsif ($^O eq "linux") {
		$me->print_message("Calculating checksum");
		if (!system("md5sum $file_name > $working_dir$checksum_file 2>$script_error_log")) {
			$me->print_message("Checksum calculated");
			return "$working_dir$checksum_file";
		} else {
			my $system_error=$me->get_error($script_error_log);
			$me->print_message("Checksum couldn't be calculated. Perl Message: $system_error");
			return undef;
		}
	}		

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


sub verify_checksum {
	shift;
	my $source_checksum = shift;
	my $target_checksum = shift;

	$me->print_message("Comparing checksum");
	if ($source_checksum eq $target_checksum) {
		$me->print_message("Checksums are matching");
		return 1;
	}else {
		$me->print_message("Checksums are not matching");
		return 0;
	}

}

sub calculate_throughput {
	shift;
	my $size = shift;
	my $transfer_time = shift;

	return ($size/$transfer_time);
}

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


#sharing a folder
sub share_folder{
	shift;
	my $share_name = shift;
	my $share_path = shift;
	
	my $shared;
	if ($^O eq "MSWin32") {
		if ($me->share_windows($share_name, $share_path)) {
			return 1;
		} else {
			return 0;
		}
	} elsif ($^O eq "linux") {
		if ($me->map_linux($share_name, $share_path)) {
			return 1;
		} else {
			return 0;
		}
	}	

}

sub share_windows {
	shift;
	my $share_name = shift;
	my $share_path = shift;

	$me->print_message("Sharing the folder [$share_path] with share name [$share_name]");
	$me->print_message("Checking is there any share with name [$share_name]");
	if (!system("net share $share_name > $script_log 2>$script_error_log")) {
		$me->print_message("Found a share with name [$share_name]. So first deleting it");
		if (!system("net share $share_name \/delete > $script_log 2>$script_error_log")) {
			$me->print_message("Deleted txisting share [$share_name] successfully");
		}
		else {
			my $system_error=$me->get_error($script_error_log);
			$me->print_message("Share [$share_name] couldn't be deleted. Perl message: $system_error");
			return 0;
		}
	}else{
		$me->print_message("No share with name [$share_name] exists");
	}

	$me->print_message("Checking the existance of share path");
	if (! -d $share_path) {
		$me->print_message("Share path doesn't exist. Creating the folder [$share_path] to be shared");
		if (mkdir $share_path) {
			$me->print_message("Folder [$share_path] created successfully");
		}
		else {
			$me->print_message("Folder [$share_path] couldn't becreated. Perl Message: $!");
			return 0;
		}
	}else {
		$me->print_message("Share path [$share_path] exists");
	}

	$me->print_message("Sharing the folder");
	if (!system("net share $share_name=$share_path > $script_log 2>$script_error_log")) {
		$me->print_message("[$share_path] shared successfully. Share name is [$share_name]");
		return 1;
	}
	else {
		my $system_error=$me->get_error($script_error_log);
		$me->print_message("Folder [$server_path] couldn't be shared. Perl message: $system_error");
		return 0;
	}
}

	
sub share_linux {	
	shift;
	my $share_name = shift;
	my $share_path = shift;

	$me->print_message("Samba should be configured and share should be created manually before");
	$me->print_message("Starting samba server");
	if (!system("service httpd start > $script_log 2>$script_error_log")) {
		$me->print_message("Samba server started successfully");
		return 1;
	}else {
		my $system_error=$me->get_error($script_error_log);
		$me->print_message("Samba share couldn't be started. Perl message: $system_error");
		return 0;
	}

}


# Extracting the system error message
sub get_error{
	shift;
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


#
# Sends a system command
#
sub send_command() {
	my $self = shift;
	my $param = shift;

	my $Response = XMLRPC::Lite->proxy($self->{RPC_SERVER_URL})
			->call('Command', $param)
			->result;
}


#Gets the first file name from a given directory
sub get_file_name {
	shift;
	my $dir = shift;

	my @file;
	opendir(DIR, $dir);
	@file = grep !/^\.\.?$/, readdir DIR;
	closedir(DIR);
	if (length($file[0]) gt 0) {
		return $file[0];
	}else{
		return undef;
	}
}

sub create_path {
	shift;
	my $path = shift;

	$me->print_message("Creating path [$path]");
	if (mkpath($path)) {
		$me->print_message("Path created successfully");
		return 1;
	}else {
		$me->print_message("Path couldn't be created");
		return 0;
	}
}


1;

__END__