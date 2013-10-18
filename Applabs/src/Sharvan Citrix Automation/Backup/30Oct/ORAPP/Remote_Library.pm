package Remote_Library;

use ORAPP::Config;
use ORAPP::Global_Library;
use File::Find;
use File::Copy;
use Time::HiRes qw(gettimeofday);
use POSIX qw/strftime/;
use Net::FTP;
use File::Path;
use XMLRPC::Lite;

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
	$global_library->print_message("Deleting file from $ip");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.delete_file',"$file_name")
		  -> result;
	if ($server_response) {
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
	if ($server_response) {
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
	$global_library->print_message("Going to share [$share_name] at $ip");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.share_folder',$share_name, $share_path)
		  -> result;
	if ($server_response) {
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
	$global_library->print_message("Going to prepare data-set at $ip");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.prepare_data',$share_path,$file_type,$size)
		  -> result;
	if ($server_response) {
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

sub put_ftp {
	shift;
	my $ip = shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $local_file = shift;
	my $remote_file = shift || $local_file;
	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Library.cgi";
	$global_library->print_message("Putting $local_file to $url");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.put_ftp',$url,$uid,$pwd,$local_file,$remote_file)
		  -> result;
	
	if ($server_response) {
		$global_library->print_message("Put $local_file to $url successfully");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't put $local_file to $url");
		return undef;
	}
}

sub get_ftp {
	shift;
	my $ip = shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $remote_file = shift;
	my $local_file = shift || $file;
	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Library.cgi";
	$global_library->print_message("Getting $remote_file to $url");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.get_ftp',$url,$uid,$pwd,$remote_file,$local_file)
		  -> result;
	
	if ($server_response) {
		$global_library->print_message("Got $remote_file from $url successfully");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't get $remote_file to $url");
		return undef;
	}
}

sub wget_ftp {
	shift;
	my $ip = shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $local_file = shift;
	
	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Library.cgi";
	$global_library->print_message("Getting $url");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.wget_ftp',$url,$uid,$pwd,$local_file)
		  -> result;
	if ($server_response) {
		$global_library->print_message("Got $url successfully");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't get $url");
		return undef;
	}
}

sub wget_http {
	shift;
	my $ip = shift;
	my $url = shift;
	my $local_file = shift;

	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Library.cgi";
	$global_library->print_message("Getting $url");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.wget_http',$url,$local_file)
		  -> result;
	if ($server_response) {
		$global_library->print_message("Got $url successfully");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't get $url");
		return undef;
	}
}


#****************************************************************

sub copy_files_using_threads {
	shift;
	my $ip = shift;
	my $source_dir = shift;
	my $ref_source_files = shift;
	my $target_dir = shift;
	my $ref_target_files = shift;

	my @source_files = @{$ref_source_files};
	my @target_files = @{$ref_target_files};

	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Thread.cgi";
	$global_library->print_message("Copying files now");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.copy_files_using_threads',$source_dir,[@source_files],$target_dir,[@target_files])
		  -> result;
	if ($server_response) {
		$global_library->print_message("Copied files successfully");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't copy files");
		return undef;
	}
}

#**************************************************
sub calculate_multi_checksums {
	shift;
	my $ip = shift;
	my $working_dir = shift;
	my $ref_files = shift;

	my @files = @{$ref_files};
	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Thread.cgi";
	$global_library->print_message("Calculating checksums");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.calculate_multi_checksums',$working_dir,[@files])
		  -> result;
	if ($server_response) {
		$global_library->print_message("Checksums calculated successfully");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't calculate checksum");
		return undef;
	}
}

#*************************************************************************
sub put_ftp_using_threads {
	shift;
	my $ip = shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $source_dir = shift;
	my $ref_source_files = shift;
	my $target_dir = shift;
	my $ref_target_files = shift;

	my @source_files = @{$ref_source_files};
	my @target_files = @{$ref_target_files};
	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Thread.cgi";
	$global_library->print_message("Putting files at $url");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.put_ftp_using_threads',$url,$uid,$pwd,$source_dir,[@source_files],$target_dir,[@target_files])
		  -> result;
	if ($server_response) {
		$global_library->print_message("Put files successfully at $url");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't put files at $url");
		return undef;
	}
}

sub get_ftp_using_threads {
	shift;
	my $ip = shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $source_dir = shift;
	my $ref_source_files = shift;
	my $target_dir = shift;
	my $ref_target_files = shift;

	my @source_files = @{$ref_source_files};
	my @target_files = @{$ref_target_files};

	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Thread.cgi";
	$global_library->print_message("Getting files at $url");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.get_ftp_using_threads',$url,$uid,$pwd,$source_dir,[@source_files],$target_dir,[@target_files])
		  -> result;
	if ($server_response) {
		$global_library->print_message("Got files successfully at $url");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't get files at $url");
		return undef;
	}
}

sub wget_ftp_using_threads {
	shift;
	my $ip = shift;
	my $url = shift;
	my $uid = shift;
	my $pwd = shift;
	my $source_dir = shift;
	my $ref_source_files = shift;
	my $target_dir = shift;
	my $ref_target_files = shift;

	my @source_files = @{$ref_source_files};
	my @target_files = @{$ref_target_files};

	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Thread.cgi";
	$global_library->print_message("Getting files from $url");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.wget_ftp_using_threads',$url,$uid,$pwd,$source_dir,[@source_files],$target_dir,[@target_files])
		  -> result;
	if ($server_response) {
		$global_library->print_message("Got files successfully from $url");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't get files from $url");
		return undef;
	}
}

sub wget_http_using_threads {
	shift;
	my $ip = shift;
	my $url = shift;
	my $source_dir = shift;
	my $ref_source_files = shift;
	my $target_dir = shift;
	my $ref_target_files = shift;

	my @source_files = @{$ref_source_files};
	my @target_files = @{$ref_target_files};

	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Thread.cgi";
	$global_library->print_message("Getting files from $url");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.wget_http_using_threads',$url,$source_dir,[@source_files],$target_dir,[@target_files])
		  -> result;
	if ($server_response) {
		$global_library->print_message("Got files successfully from $url");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't get files from $url");
		return undef;
	}
}


#sharing a folder
sub prepare_multi_data{
	shift;
	my $ip = shift;
	my $file_count = shift;
	my $share_path = shift;
	my $file_type = shift;
	my $size = shift;

	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Thread.cgi";
	$global_library->print_message("Going to prepare data-set at $ip");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.prepare_multi_data',$file_count,$share_path,$file_type,$size)
		  -> result;
	if ($server_response) {
		$global_library->print_message("Prepared data-set successfully at $ip");
		return $server_response;
	}else {
		$global_library->print_message("Couldn't prepare data-set at $ip");
		return undef;
	}
	
}

sub delete_files_using_threads{
	shift;
	my $ip = shift;
	my $dir = shift;
	my $ref_files = shift;
	
	my @files = @{$ref_files};

	my $lib_url = "http://$ip/cgi-bin/xml-rpc/library/XMLRPC_Thread.cgi";
	$global_library->print_message("Deleting files from $ip");
	my $server_response= XMLRPC::Lite
		  -> proxy($lib_url)
		  -> on_fault(sub {$global_library->print_message("Couldn't connect to $ip");exit 2;})
		  -> call('RPC.delete_files_using_threads',"$dir",[@files])
		  -> result;
	if ($server_response) {
		$global_library->print_message("Files deleted successfully from $ip");
		return $server_response;
	}else {
		$global_library->print_message("Files couldn't be deleted from $ip");
		return 0;
	}
	
}