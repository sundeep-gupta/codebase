package WANScaler::CIFSLibrary;
use strict;
use Exporter;
use Win32::NetResource qw(:DEFAULT GetSharedResources GetError);
use File::Copy;
use Time::HiRes qw(gettimeofday);

our @ISA = ('Exporter');
our @EXPORT = qw( share_directory unshare_directory
			  map_drive unmap_drive
			  get_unc $err_msg $err_code
			  copy_file copy_directory browse_directory delete_file);
use constant NW_CONN_NOT_EXIST => 2250;
use constant TIMEOUT 		   => 100;

our $err_code = undef;
our $err_msg = undef;
sub share_directory {
	my ($share_name, $path) = @_;

    my %share_info = (
    	netname => $share_name,
	    path    => $path
    );
  	my $err_code = undef;
  	if (Win32::NetResource::NetShareAdd(\%share_info)) {
        $err_code = undef;
        return 1;
    } else {
        Win32::NetResource::GetError($err_code);
        $err_msg = Win32::FormatMessage($err_code);
    	return 0;
    }
}

sub unshare_directory {
	my ($share_name) = @_;
  	my $err_code = undef;
  	if (Win32::NetResource::NetShareDel($share_name)) {
        $err_code = undef;
        return 1;
    } else {
        Win32::NetResource::GetError($err_code);
        $err_msg = Win32::FormatMessage($err_code);
    	return 0;
    }
}
sub get_unc {
	my ($drive_letter) = @_;
	if (Win32::NetResource::GetUNCName( my $unc_name,$drive_letter )) {
        $err_code = undef;
        return $unc_name;
    } else {
        Win32::NetResource::GetError($err_code);
        $err_msg = Win32::FormatMessage($err_code);
    	return undef;
    }
}

sub unmap_drive {
	my ($drive_letter)= @_;

	if (Win32::NetResource::CancelConnection($drive_letter.":",1,1)) {
        $err_code = undef;
        return 1;
    } else {
        Win32::NetResource::GetError($err_code);
        $err_msg = Win32::FormatMessage($err_code);
    	return 0;
    }
}
sub map_drive {
	my ($drive_letter, $server_name, $share_name) = @_;
    my %NetResource = (
    	LocalName => "$drive_letter:",
	    RemoteName => "\\\\$server_name\\$share_name",
      );
  	my $err_code = undef;
  	if (Win32::NetResource::AddConnection(\%NetResource)) {
        $err_code = undef;
        return 1;
    } else {

        Win32::NetResource::GetError($err_code);
        $err_msg = Win32::FormatMessage($err_code);
    	return 0;
    }
}
sub share_available {
	my ($server_name, $share_name) = @_;
	 my $count = 0;
	logwrite(\*STDOUT,0,$count), sleep(1) until(is_available($server_name,$share_name) || $count++ > TIMEOUT);
	return 0 if $count > 100;
    return 1;
}
sub is_available {
	my ($server_name, $share_name) = @_;

    my %NetResource = (
	    RemoteName => "\\\\$server_name",
      );
  	my $err_code = undef;
    my @resources = undef;

    unless( Win32::NetResource::GetSharedResources(\@resources, RESOURCETYPE_ANY,\%NetResource)) {
        GetError($err_code);
        warn Win32::FormatMessage($err_code);
    }
    foreach my $resource (@resources) {
        next if ($$resource{DisplayType} != RESOURCEDISPLAYTYPE_SHARE);
		return 1 if ($resource->{RemoteName} eq "\\\\".$server_name."\\".$share_name)
    }
}

sub cifs_read {
	my ($drive_letter,$path,$file_name,$local_path,$local_file_name) = @_;
	my $ret = copy($drive_letter.":\\".$path."\\".$file_name,$local_path."\\".$local_file_name);
	$err_msg = ($ret==1? undef:$!);
	return $ret;
}




sub copy_file {
	my ($source_path,$source_file_name,$dest_path,$dest_file_name) = @_;
	$" ="\t";
	print "@_";
    if (-e $source_path.$source_file_name) {
    	$dest_path = '.\\' unless $dest_path;
        $dest_file_name = "NUL" unless $dest_file_name;
		my @timer1 = gettimeofday();
		my $ret = copy($source_path.$source_file_name,$dest_path.$dest_file_name);
		my @timer2 = gettimeofday();
		my $time = $timer2[0]-$timer1[0] +($timer2[1]-$timer1[1])/1000000;
		$err_msg = ($ret==1?undef:$!);
		return $time;
    } else {
    	$err_msg = "Source File not found";
    	return 0;
    }
}


sub copy_directory {
	my ($source_path,$dest_path) = @_;
	$" ="\t";
	$err_msg = 'Source_path not valid', return 0 unless $source_path;
	$source_path =~ s/\\+$//;
	my $copy = "COPY $source_path\\*.* ". (($dest_path)?  $dest_path : "NUL: " );
	my @timer1 = gettimeofday();
	my @lines = `$copy`;
	my @timer2 = gettimeofday();
	my $time = $timer2[0]-$timer1[0] +($timer2[1]-$timer1[1])/1000000;

	# assume the copy operation succeds eveytime...
	my $ret = {'out'=>\@lines, 'time'=>$time};
	return $ret; # just return the output without parsing for pass / fail TODO
}


sub browse_directory {
	my ($directory) = @_;
	my @timer1 = gettimeofday();
	`dir $directory`;
	my @timer2 = gettimeofday();
	my $time = $timer2[0]-$timer1[0] +($timer2[1]-$timer1[1])/1000000;
	return $time;
}
sub delete_file {
  	my ($file_name) = @_;
  	unlink($file_name);
  	for (my $i = 0; -e $file_name and $i<30 ;$i++ ) {
  		sleep(1);
  	}
 	return (-e $file_name)?0:1;
}

sub logwrite {
	my ($fh,$type,$msg) = @_;
    if(ref($msg)) {
	    syswrite(\*STDOUT,Dumper($msg));
    }
    else {
    	syswrite(\*STDOUT,$msg);
    }
}

1;