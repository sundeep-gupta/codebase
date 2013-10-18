package Remote_Library;

use ORAPP::Config;
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
my $global_library = Global_Library::new();




sub delete_file{
	shift;
	my $ip = shift;
	my $file_name = shift;

	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Library.cgi";
	$global_library->print_message("Deleting file at $ip");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.delete_file',"$file_name")
		  -> result;
	if (defined $server_response) {
		$global_library->print_message("File deleted successfully from $ip");
		return $server_response;
	}else {
		$global_library->print_message("File couldn't be deleted from $ip");
		return 0;
	}
	
}

#sharing a folder
sub calculate_checksum{
	shift;
	my $ip = shift;
	my $working_dir = shift;
	my $file_name = shift;

	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Library.cgi";
	$global_library->print_message("Calculating checksum at $ip");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.calculate_checksum',"$working_dir", "$file_name")
		  -> result;
	if (defined $server_response) {
		$global_library->print_message("Checksum calculated successfully at $ip");
		return $server_response;
	}else {
		$global_library->print_message("Checksum couldn't be calculated at $ip");
		return undef;
	}
	
}


#sharing a folder
sub share_folder{
	shift;
	my $ip = shift;
	my $share_name = shift;
	my $share_path = shift;

	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Library.cgi";
	$global_library->print_message("Goint to share [$share_name] at $ip");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.share_folder',"$share", "$share_path")
		  -> result;
	if (defined $server_response) {
		$global_library->print_message("Shared [$share_name] successfully at $ip");
		return 1;
	}else {
		$global_library->print_message("Couldn't share [$share_name] at $ip");
		return 0;
	}
	
}


#sharing a folder
sub prepare_data{
	shift;
	my $ip = shift;
	my $share_path = shift;
	my $file_type = shift;
	my $size = shift;

	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Library.cgi";
	$global_library->print_message("Goint to prepare data-set at $ip");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.prepare_data',$share_path,$file_type,$size)
		  -> result;
	if (defined $server_response) {
		$global_library->print_message("Prepared data-set successfully at $ip");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't prepare data-set at $ip");
		return undef;
	}
	
}


sub copy_file {
	shift;
	my $ip = shift;
	my $source = shift;
	my $target = shift;

	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Library.cgi";
	$global_library->print_message("Copying $source to $target");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.copy_file',$source,$target)
		  -> result;
	
	if ($server_response) {
		$global_library->print_message("Copied $source to $target successfully");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't copy $source to $target");
		return undef;
	}
}

sub ftp_put {
	shift;
	my $ip = shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $file = shift;
	my $remote_file = shift || $file;
	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Library.cgi";
	$global_library->print_message("Putting $file to $url");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.put_ftp',$url,$uid,$pwd,$file,$remote_file)
		  -> result;
	
	if ($server_response) {
		$global_library->print_message("Put $file to $url successfully");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't put $file to $url");
		return undef;
	}
}