#!/usr/bin/perl
#PREDEFINED Libraries
use strict;
use threads;
use Data::Dumper;
use XMLRPC::Lite;
use Frontier::Client;
use IPC::Open3;
use POSIX ":sys_wait_h";


# Use random number generator to get next operation to do...
#
use constant MAX_OCTET_VALUE => 240;
use constant MIN_OCTET_VALUE => 5;
use constant MAX_RPC_TIMEOUT => 3600;

use constant FTP_FILE_SIZE => 1024*1024;
use constant HTTP_FILE_SIZE => 1024*1024;
use constant CIFS_FILE_SIZE => 1024*1024;

my $PORT = 7050;
my @server_ips = ('10.199.32.111',
#				  '10.199.32.121',
                  '10.199.32.131',
                  '10.199.32.141',
                  '10.199.32.151',
#                  '10.199.32.161',
#                  '10.199.32.171',
                  );

my @start_address = (172,32,2,30);
my $sessions = 5;
my $cifs_options = {'share_name' => 'CIFS_Share0',
		   		'browse_dir_name' => 'Browse',
				'read_file_path' => 'LargeFile45',
				'read_file_name' => 'LargeFile.dat',
	      };
#my $res = start_cifs_sessions(\@start_address,$sessions,$options);
#print Dumper($res);
my 	$ftp_options = {
    			'server' => '172.32.2.41',
                'user_name' => 'administrator',
                'password' => 'ARS!jr',
                'src_path' => '/',
                'get_file_name' => 'LargeFile.dat',
#                'put_file_name' => myputfile,
    			};
#my $ftp_res = start_ftp_sessions($sessions,$ftp_options);
my $wget_options = {'url'=>'http://172.32.2.41/index.html'};

my @cifs_threads ;
my @ftp_threads ;
my @wget_threads ;
my $i = 0;
foreach my $server_ip (@server_ips) {
print $server_ip,"\t";
#	$ftp_threads[$i] = threads->new(\&do_ftp,$server_ip,$sessions,$ftp_options);
	$cifs_threads[$i] = threads->new(\&do_cifs,$server_ip,\@start_address,$sessions,$cifs_options);
#	$wget_threads[$i] = threads->new(\&do_wget,$server_ip,$sessions,$wget_options);
    sleep(1);
    $i++;
}
$i = 0;
my $val =0;
my $sum = 0;

foreach my $thread (@ftp_threads) {
	my $server_response = $thread->join;
	$, = "\t";
	foreach my $var (@$server_response) {
    	if($var) {
	         if ($var->{'REASON'}->{'TIME'} ){
	            $val =((FTP_FILE_SIZE/$var->{'REASON'}->{'TIME'})*8/1000000);
	             print $server_ips[$i], $var->{'RESULT'},$val,"\n" ;
	             $sum+=$val;
	         } else {
	            print $server_ips[$i], $var->{'RESULT'},Dumper($var->{'REASON'}),"\n"
	         }
         }else {
         	print Dumper($var);
         }
	}
    $i++;
}
foreach my $thread (@wget_threads) {
	my $server_response = $thread->join;
	$, = "\t";
	foreach my $var (@$server_response) {
    	$val = ( $var*8/1000000);
		print $server_ips[$i],$val,"\n";
        $sum+=$val;
	}
    $i++;
}
$i = 0;
$i = 0;
foreach my $thread (@cifs_threads) {
	my $server_response = $thread->join;
	$, = "\t";
	foreach my $var (@$server_response) {
		$val =     (CIFS_FILE_SIZE*8/$var->{'REASON'}/1000000);
       print $server_ips[$i], $var->{'RESULT'},$val,"\n";
        $sum+=$val;
	}
    $i++;
}
print 'Total :',$sum,' Mbps';

#print Dumper($server_response);

#my $wget_options = {
#                'url' => URL,
#            };
#my $wget_res = start_wget_sessions($sessions,$wget_options);

sub do_ftp {
	my ($server_ip, $session,$ftp_options) = @_;
	my $server_response= XMLRPC::Lite-> proxy('http://'.$server_ip.':'.$PORT.'/',timeout=>MAX_RPC_TIMEOUT)
	          -> on_fault(sub {syswrite(\*STDOUT,"Couldn't connect to http://$server_ip:$PORT/\n");exit 2;})
	          -> call('Scalability.start_ftp_sessions',$sessions,$ftp_options)
	          -> result;
	return $server_response;
}

sub do_cifs {
	my ($server_ip,$start_address,$session,$cifs_options) = @_;
	my $server_response= XMLRPC::Lite-> proxy('http://'.$server_ip.':'.$PORT.'/',timeout=>MAX_RPC_TIMEOUT)
	          -> on_fault(sub {syswrite(\*STDOUT,"Couldn't connect to http://$server_ip:$PORT/\n");exit 2;})
	          -> call('Scalability.start_cifs_sessions',$start_address,$sessions,$cifs_options)
	          -> result;
	return $server_response;
}
sub do_wget {
	my ($server_ip,$session,$wget_options) = @_;
	my $server_response= XMLRPC::Lite-> proxy('http://'.$server_ip.':'.$PORT.'/',timeout=>MAX_RPC_TIMEOUT)
	          -> on_fault(sub {syswrite(\*STDOUT,"Couldn't connect to http://$server_ip:$PORT/\n");exit 2;})
	          -> call('Scalability.start_http_sessions',$sessions,$wget_options)
	          -> result;
	return $server_response;
}

sub run {

	my ($command, $cmd_line_options) = @_;
	my $cmd_opt =  @$cmd_line_options[0];
	my @arr= `$command $cmd_opt 2>&1`;
	foreach my $line (@arr) {
		if ($line =~ /\s+0K[\s+\.]*\s+\d+%\s+(\d+\.?\d*)\s([KMG]?)B\/s/) {
			return $1*1024 		 if ($2 eq 'K');
			return $1*1024*1024	 if ($2 eq 'M');
			return $1*1024*1024*1024 if ($2 eq 'G');
			return $1;
		}
	}
#	return $arr[6];
	return 'FAIL';

}