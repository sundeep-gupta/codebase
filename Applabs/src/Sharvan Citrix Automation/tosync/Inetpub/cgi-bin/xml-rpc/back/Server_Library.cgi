use File::Find;
use File::Copy;
use Time::HiRes qw(gettimeofday);
use POSIX qw/strftime/;
use File::Path;
use XMLRPC::Transport::HTTP;
use Win32::NetResource qw(:DEFAULT GetSharedResources GetError NetShareDel NetShareAdd);

my $server = XMLRPC::Transport::HTTP::CGI
-> dispatch_to('Server_Configuration')
-> handle
;

package Server_Configuration;
#sharing a folder
sub share_folder{
	shift if UNIVERSAL::isa($_[0] => __PACKAGE__);
	my $share_name = shift;
	my $share_path = shift;
	my $shared;
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
	my $ShareInfo = {
					'path' => $share_path,
					'netname' => $share_name,
					'remark' => "It is good to share",
					'passwd' => "",
					'current-users' =>0,
					'permissions' => 0,
					'maxusers' => -1,
					'type'  => 0,
				    };
    
	if (Win32::NetResource::NetShareAdd( $ShareInfo, my $parm )) {
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
		if (!system("rm -r $file_name >nul 2>nul")) {
			return 1;
		} else {
			return 0;
		}
	}	
}