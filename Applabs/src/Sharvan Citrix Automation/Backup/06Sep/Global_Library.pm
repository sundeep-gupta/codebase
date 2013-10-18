#!/usr/bin/perl
package Global_Library;
use File::Find;
use Time::HiRes qw(gettimeofday);
use POSIX qw/strftime/;


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
		if (-s "$path\\$file" == $size) {
			$me->print_message("Matching file found. File name: [$file]");
			return $file;
		}
	}
	$me->print_message("Couldn't find any matching file");
	return undef;
}

sub map_share {
	shift;
	my $server = shift;
	my $share = shift;
	
	my $count = 0;
	@drives = ('k:','l:','m:','n:','o:','p:','q:','r:','s:','t:');
	$me->print_message("Mapping the shared folder");
	foreach (@drives) {
		$del = system("net use $_ /delete > tmp");
		while ($count <= 3) {
			$res = system("net use $_ \\\\$server\\$share > tmp");
			if ($res == 0) {
				$me->print_message("Mapped the drive [$_] successfully");
				return "$_";
			}
			sleep(10);
			$count = $count+1;
		}
	}
	$me->print_message("Couldn't mapp the drive");
	return undef;
}

sub create_file {
	shift;
	my $path = shift;
	my $file_type = shift;
	my $size = shift;

	$me->print_message("Creating file");
	my $file_name = "File-".time;
	if (open(FH, ">$path\\$file_name")){
		if ($file_type == 0) {
			while ($size>=1048576) {
				print FH ("0" x 1048576);
				$size = $size - 1048576;
			}
			print FH "0" x $size;
		}
		elsif ($file_type == 1)  {
			print "Yet to be done\n";
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

	$me->print_message("Deleting file [$file_name]");
	if (unlink($file_name)){
		$me->print_message("File deleted successfully");
		return 1;
	}
	else{
		$me->print_message("File couldn't be deleted");
		return 0;
	}
}

sub copy_file {
	shift;
	my $file = shift;
	my $drive = shift;

	($sec1, $usec1) = gettimeofday();
	$me->print_message("Copying file [$file] to [$drive]");
	if (!system("copy $file $drive > $script_log 2>$script_error_log")) {
		$me->print_message("File copied successfully");
	}
	else {
		my $system_error=$me->get_error($script_error_log);
		$me->print_message("File couldn't be copied. Perl Message: $system_error");
		return undef;
	}
	($sec2, $usec2) = gettimeofday();

	my $sec = ($sec2-$sec1)+(((1000000-$usec1)+$usec2)/1000000);
	return ($sec);
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
			return;
		}
	}
	else{
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
			return;
		}
	}
	else {
		$me->print_message("Share path [$share_path] exists");
	}

	$me->print_message("Sharing the folder");
	if (!system("net share $share_name=$share_path > $script_log 2>$script_error_log")) {
		$me->print_message("[$share_path] shared successfully. Share name is [$share_name]");
	}
	else {
		my $system_error=$me->get_error($script_error_log);
		$me->print_message("Folder [$server_path] couldn't be shared. Perl message: $system_error");
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



1;

__END__