#!/usr/bin/perl
package WANScaler::LOSTLibrary;
use strict;
use warnings;
use threads;
use Data::Dumper;

use WANScaler::FTPLibrary;
use WANScaler::HTTPLibrary;
use WANScaler::IPerfLibrary;

# Use random number generator to get next operation to do...
#
use constant MAX_OCTET_VALUE => 240;
use constant MIN_OCTET_VALUE => 5;
use constant LOCALHOST => 'localhost';
use constant XMLRPC_PORT => 2050;
use constant WS_SERVICE_NAME => 'wanscalerclient';
my  $SLEEP_BEFORE_STAT = 10;
my  $SAMPLE_INSTANCES = 60;


############################### FTP RELATED FUNCTIONS #########################

sub start_ftp_sessions {
	shift;
	my ($options) = @_ ;
    	my @ftp_threads;
        my $i;
    	for($i = 0;$i < $options->{sessions}; $i++ ) {
	        $ftp_threads[$i] = threads->new(\&ftp_session, $options,$i);
	    }
	    $i = 0;
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
	open(FH,'>TEst.txt');
	close(FH);
    my $ftp;
    $ftp = WANScaler::FTPLibrary->new($options->{'server'}) or die "FTP connection failed \n";
    $ftp->login($options->{'username'},$options->{'password'}) or die "FTP Login failed \n";
	my $time;
    my $result;
	if( $options->{'get_file'} ){
       $time = $ftp->get($options->{'get_file'},'NUL');
        if($time == 0 && $ftp_err) {
        	print 'hi';
        }
    }
    if ($options->{'put_file'}) {
	    $time = $ftp->put($options->{'put_file'});
        if($time == 0 && $ftp_err) {
        	print 'hi';
        }
	}
    if($options->{'browse'}) {
	    $time = $ftp->ls();
        if($time == 0 && $ftp_err) {
        	print 'hi';
        }
    }
    $ftp->close();
    return $result;
}

############################### HTTP RELATED METHODS ###########################

sub start_http_sessions {
	my ($self,$options) = @_;
    my @http_threads;
    my $i ;
    for($i = 0;$i < $options->{'sessions'};$i++) {
	      my $url = 'http://'.$options->{'server'};
	      $url.=':'.$options->{'server_port'} if $options->{'server_port'};
	      $url.='/'.$options->{'uri'};
          $http_threads[$i] = threads->new(\&http_session,$url);
    }
    my @results;
 	$i = 0;
    foreach my $thread (@http_threads) {
        my $ret = $thread->join();
        $results[$i]  = $ret;
        $i++;
    }
    return \@results
}
sub http_session {
	my $url = shift;
	my $ret =  WANScaler::HTTPLibrary->get($url);
    my $result = {'TYPE' => 'HTTP GET'};
    if( !($result) or $http_err) {
        $result->{'RESULT'}= {'FAIL' => $http_err};
    } else {
        $result->{'RESULT'} = { 'PASS' => $ret};
    }
    return $result;
}

######################## SET WANSCALER CLIENT ##################################

sub set_wanscaler_client {
	my ($self,$options) = @_;
	my $wanscaler = WANScaler::XmlRpc->new("http://".LOCALHOST.':'.XMLRPC_PORT."/RPC2");
	if ($options->{PARAMETER}) {
		my $parameters = $options->{PARAMETER};
		foreach my $param (keys %$parameters) {
			syswrite(\*STDOUT, $param."\n");
			$wanscaler->set_parameter($param, $parameters->{$param});
		}
	}
#	if($options->{restart_service} == 1) {
#		stop_wanscaler_service();
#		start_wanscaler_service();
#	}
}

################### GET WANSCALER CLIENT PARAMETERS ############################
sub get_wanscaler_stats {
	my ($self,$options)   = @_;

	my $cpu_thread = threads->create(\&__get_cpu_stat, $options);
    my $connection_thread = threads->create(\&__get_connection_stat, $options);

    my $cpu_result 			= $cpu_thread->join();
    my $connection_result 	= $connection_thread->join();

    return [$cpu_result,$connection_result];
}

sub __get_cpu_stat {
	my $options = shift;
	sleep($SLEEP_BEFORE_STAT);
    my $wanscaler		  = WANScaler::XmlRpc::System->new("http://".LOCALHOST.':'.XMLRPC_PORT."/RPC2");
    my $instances = undef;
    my $total = 0;
    my $i;
    my $cpu;
    for($i = 0;$i< $options->{'instances'};$i++) {
		$cpu   	   	= $wanscaler->get_cpu_utilization() if ($options->{'CPU'} == 1);
        $instances 	= $instances.($instances?', '.$cpu:$cpu);
        $total 		= $total+$cpu;
        sleep(1);
    }
	syswrite(\*STDOUT,Dumper($cpu));
    return {'CPU'=>{'Instances' => $instances,
    				 'Average' 	=> sprintf "%.3f", ($total/$options->{'instances'})
    				}
           };
}


sub __get_connection_stat {
	my $options = shift;
    return undef;

}
####################### INSTALL THE WANSCALER CLIENT ###########################
sub install_wanscaler_client  {
	my ($self,$options) = @_;
    my $ftp = WANScaler::FTPLibrary->new(    $options->{'server'});
    $ftp->login;
    $ftp->binary;
    $ftp->passive;
	$ftp->chdir($options->{'path'});
    $options->{'filename'} =~ s/type/$options->{'type'}/;
    $options->{'filename'} =~ s/build/$options->{'build'}/;
    syswrite (\*STDOUT, "Getting file: ".$options->{'filename'});
    my $time = $ftp->get($options->{'filename'});
    return 'Install Failed: Coulnd not download build' unless $time;
	syswrite(\*STDOUT,'Starting Installation');
    my $res = WANScaler::MSILibrary->install($options->{'filename'});
    syswrite(\*STDOUT,'Installation done');
    unlink $options->{'filename'};
    return $res;
#	return ($res)? 'WANScaler Client installed successfully. Waiting for reboot'
#    			 : 'WANScaler Client installation failed';
}
####################### METHODS TO START & STOP SERVICE ########################
############################# MIGHT FAIL  :-D ##################################

sub start_wanscaler_service {
	my $status = {};
    my @response = `net start wanscalerclient`;
    return \@response;
}

sub stop_wanscaler_service {
	my $status = {};
    my @response = `net stop wanscalerclient`;
	return \@response;
}

sub restart {
	syswrite(\*STDOUT, 'Got instruction for Restart');
	if(fork == 0) {
		syswrite(\*STDOUT, 'Restarting...');
        Win32::ShutDown::ForceReStart();
    } else {
	    return 'Done';
    }
}
#################### USED TO TEST IF SERVER IS OK ##############################
sub test {
	print 'Hi';
	return 'test';
}

1;