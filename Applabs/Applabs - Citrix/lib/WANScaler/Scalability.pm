package WANScaler::Scalability;
use strict;
use warnings;
use threads;
use Data::Dumper;
use WANScaler::CIFSLibrary;
use WANScaler::FTPLibrary;
# Use random number generator to get next operation to do...
#
use constant MAX_OCTET_VALUE => 240;
use constant MIN_OCTET_VALUE => 5;

sub start_cifs_sessions {
	my ($self, $start_address, $sessions, $options) = @_;
    my @start_ip = @$start_address;
	my @cifs_threads;
	for(my $i = 0;$i < $sessions; $i++ ) {
        my $ip_address = $start_ip[0].'.'.$start_ip[1].'.'.$start_ip[2].'.'.$start_ip[3];

        if($start_ip[4] >= MAX_OCTET_VALUE) {
            $start_ip[3] = MIN_OCTET_VALUE;
            $start_ip[2] = $start_ip[2]++;
        } else {
            $start_ip[3]++;
        }
        my $session_options = $options;
        $session_options->{'server_address'} = $ip_address;
        $session_options->{'index'} = $i;
        $cifs_threads[$i] = threads->new(\&cifs_session, $options);
    }
	my $i = 0;
	my @results;
	foreach my $thread (@cifs_threads) {
		my $ret = $thread->join();
		$results[$i]  = $ret;
		$i++;

	}
	return \@results;
}

sub cifs_session {
	my $session_options = shift;
    my $server_address 		= $session_options->{'server_address'};
    my $read_file_path 		= $session_options->{'read_file_path'};
    my $read_file_name 		= $session_options->{'read_file_name'};
    my $write_file_name    	= $session_options->{'write_file_name'};
    my $write_file_path    	= $session_options->{'write_file_path'};
    my $browse_dir_name		= $session_options->{'browse_dir_name'};
    my $share_path 	   		= $session_options->{'share_name'};
    my $index 				= $session_options->{'index'};
	my $server_root			= $session_options->{'server_address'};
    my $avg_pause_time = undef;

#	local $log_prefix = $server_address."-".$share_path."-";
	my $time = undef;

    #initialize the random number generator
    srand($index+1);
    do {
    	my $result = {};
		# READ Operation
        if(!read_skip()) {
            my $source_path = '\\\\'.$server_root.'\\'.$share_path.'\\'.$read_file_path."\\" ;
			syswrite(\*STDOUT,$source_path."\n");
            my $time = WANScaler::CIFSLibrary::copy_file($source_path,$read_file_name);    #if dest not specified copy to NUL:
            $result->{'TYPE'} = 'CIFS READ';
            if($time == 0 && $err_msg) {
                $result->{'RESULT'}= 'FAIL';
                $result->{'REASON'}= $err_msg;
            } else {
                $result->{'RESULT'}= 'PASS';
                $result->{'REASON'} =  $time;
            }
           return $result;
        } elsif (!write_skip()) {
            my $source_path = ".\\" ;
            my $dest_path   = '\\\\'.$server_root.'\\'.$share_path.'\\'.$write_file_path."\\" ;
            my $time = WANScaler::CIFSLibrary::copy_file($source_path,$write_file_name,$dest_path);    #if dest not specified copy to NUL:
            $result->{'TYPE'} => 'CIFS WRITE';
            if($time == 0 && $err_msg) {
                $result->{'RESULT'}=> 'FAIL';
                $result->{'REASON'}=> $err_msg;
            } else {
                $result->{'RESULT'}=> 'PASS';
                $result->{'REASON'} => $time;
            }
            return $result;
        } else {
            $time = browse_directory('\\\\'.$server_root.'\\'.$share_path.'\\'.$browse_dir_name);
            $result->{'TYPE'} => 'CIFS BROWSE';
            if($time == 0 && $err_msg) {
                $result->{'RESULT'}=> 'FAIL';
                $result->{'REASON'}=> $err_msg;
            } else {
                $result->{'RESULT'}=> 'PASS';
                $result->{'REASON'} => $time;
            }
 			return $result;
        }
    }
}
sub read_skip {
	return 0;
	return int rand(2);
}
sub write_skip {
	return int rand(2);
}

sub start_ftp_sessions {
	shift;
	my ($sessions,$options) = @_ ;
    	my @ftp_threads;
    	for(my $i = 0;$i < $sessions; $i++ ) {
	        $ftp_threads[$i] = threads->new(\&ftp_session, $options,$i);
	    }
	    my $i = 0;
	    my @results;
	    foreach my $thread (@ftp_threads) {
	        my $ret = $thread->join();
	        $results[$i]  = $ret;
	        $i++;

	    }
	    return \@results;
}

sub ftp_session {
    my $options = shift;
    my $index = shift;
    srand($index);
	open(FH,'>TEst.txt');
	close(FH);
    my $ftp = WANScaler::FTPLibrary->new($options->{'server'});
    $ftp->login($options->{'username'},$options->{'password'});
	$ftp->chdir($options->{'src_path'});
	my $result = {};
	if(!ftp_get_skip()) {

	   my $time = 0;
       $time = $ftp->get($options->{'get_file_name'},'NUL');
       $result->{'TYPE'} = 'FTP GET';
       if($time == 0 && $err_msg) {
           $result->{'RESULT'}= 'FAIL';
           $result->{'REASON'}= 'GET operation failed';
       } else {
           $result->{'RESULT'}= 'PASS';
           $result->{'REASON'} = $time;
       }

    } elsif (!ftp_put_skip()) {
	    my $time = 0;
	    $time = $ftp->put($options->{'put_file_name'});
	    $result->{'TYPE'} = 'FTP PUT';
	    if($time == 0 && $err_msg) {
	       $result->{'RESULT'}= 'FAIL';
	       $result->{'REASON'}= 'PUT operation failed';
	    } else {
	       $result->{'RESULT'}= 'PASS';
	       $result->{'REASON'} = $time;
	    }
    } else {
	    my $time = 0;
	    $time = $ftp->ls();
	    $result->{'TYPE'} = 'FTP BROWSE';
	    if($time == 0 && $err_msg) {
	       $result->{'RESULT'}= 'FAIL';
	       $result->{'REASON'}= 'BROWSE operation failed';
	    } else {
	       $result->{'RESULT'}= 'PASS';
	       $result->{'REASON'} = $time;
	    }
    }
    $ftp->disconnect();

    return $result;
}
sub ftp_get_skip {
	return 0;	# DEFAULTING TO NO SKIP
	return int rand(2);
}
sub ftp_put_skip {
	return int rand(2);
}


sub start_http_sessions  {
	my ($self,$sessions,$options) = @_;
    my @wget_threads;
    for(my $i = 0;$i < $sessions; $i++ ) {
	my @arr = ($options->{'url'});
        $wget_threads[$i] = threads->new(\&run, 'wget',\@arr);
    }
    my $i = 0;
    my @results;
    foreach my $thread (@wget_threads) {
        my $ret = $thread->join();
        $results[$i]  = $ret;
        $i++;

    }
    return \@results;
}


sub run {

	my ($command, $cmd_line_options) = @_;
	my $cmd_opt =  @$cmd_line_options[0];
	my @arr= `$command $cmd_opt 2>&1`;
	foreach my $line (@arr) {
		if ($line =~ /\s+0K[\s+\.]*\s+\d+%\s+(\d+\.?\d*)\s[KMG]?B\/s/) {
			return $1;
		}
	}
#	return $arr[6];
	return 'FAIL';

}
1;