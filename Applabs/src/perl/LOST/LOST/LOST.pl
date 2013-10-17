use strict;
use Data::Dumper;
use WANScaler::HTTPLibrary;
use WANScaler::FTPLibrary;
use threads;
#use WANScaler::LOST::Config;

######## Start N Sessions of FTP Parallelly ################################
my %ftp = (
			server 		 => '10.1.2.4',
			username 	 => 'kl',
         	password 	 => 'test',
	     	instances    => 50,
   			dest 	     => 'NUL:'
		);
my %http = (
             server 		 => '10.1.2.4',
             port    	 => '80', # DEFAULT
             uri          => 'index.html',
             instances    => 50
         );
my %iperf = (
	       server  		 => '10.1.2.4',
	       'time'  		 => 20, # TIME has precedence over SIZE So
comment it when using SIZE
#          'size' 		 => 20000,
	       instances 	 => 100,
	       ports   		 => [5001,5002]
          );

my $iperf_test = threads->new(\&start_iperf_in_loop, undef,\%iperf);
my $http_test = threads->new(\&start_http_in_loop, undef,\%http);
my $ftp_test = threads->new(\&start_ftp_in_loop, undef,\%ftp);
$iperf_test->join;
$http_test->join;
$ftp_test->join;

sub start_iperf_in_loop {
	my ($package, $options) = @_;
	my $iperf_connections = $options->{'instances'};
     while(1) {
     	my $iperf_thread = threads->new(\&start_multi_iperf,$options);
         $iperf_thread->join();
     }
	return;
}

sub start_multi_iperf {
	my $options = shift;
     my $i ;
     my @iperf_threads;
     foreach my $port (@{$options->{'ports'}}) {
     	my $tmp_options = $options;
         $tmp_options->{'port'}=$port;
         $iperf_threads[$i] = threads->new(\&iperf_session,$tmp_options);
     }
     foreach my $thread (@iperf_threads) {
         my $ret = $thread->join();
         $i++;
     }

     @iperf_threads = undef;
	return;
}

sub iperf_session {
	my ($options) = @_;
     my $iperf_cmd = 'iperf -c '.$options->{'server'};
     $iperf_cmd = $iperf_cmd.' -p '.$options->{'port'} if $options->{'port'};
     $iperf_cmd = $iperf_cmd.' -f m ' ;
     if( $options->{'time'}) {
	    $iperf_cmd = $iperf_cmd.' -t '.$options->{'time'};
     } elsif ($options->{'size'}) {
	    $iperf_cmd = $iperf_cmd.' -n '.$options->{'size'} ;
     }

     $iperf_cmd = $iperf_cmd.' -P '.$options->{'instances'} if $options->{'instances'};

     my $result = `$iperf_cmd 2>&1`;
	$iperf_cmd = undef;
     return $result;
}

sub start_http_in_loop {
	my ($package, $options) = @_;
	my $http_connections = $options->{'instances'};
     while(1) {
     	my $http_thread = threads->new(\&start_multi_http,$options);
         $http_thread->join();
         $http_thread = undef;
     }
	return;
}

sub start_multi_http {
	my $options = shift;
     my @http_threads;
     my $i ;
     for($i = 0;$i < $options->{'instances'};$i++) {
	      my $url = 'http://'.$options->{'server'};
	      $url.=':'.$options->{'port'} if $options->{'port'};
	      $url.='/'.$options->{'uri'};
           $http_threads[$i] = threads->new(\&http_session,$url);
     }
  	$i = 0;

     foreach my $thread (@http_threads) {
         my $ret = $thread->join();
         $i++;
     }
     @http_threads = undef;
	return;
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
     $ret = undef   ;
     return $result;
}
sub start_ftp_in_loop {
	my ($package, $options) = @_;
	my $ftp_connections = $options->{'instances'};
     while(1) {
     	my $ftp_thread = threads->new(\&start_multi_ftp,$options);
         $ftp_thread->join();
         $ftp_thread = undef;
     }
	return;
}
sub start_multi_ftp {
	my $options = shift;
     my @ftp_threads;
     for(my $i=0;$i<$options->{'instances'};$i++) {
		$ftp_threads[$i] = threads->new(\&start_ftp, $options);
     }
     for(my $i=0;$i<$options->{'instances'};$i++) {
     	$ftp_threads[$i]->join;
     }
     @ftp_threads = undef;
     return;
}
sub start_ftp {
	my $options = shift;
	my $ftp = WANScaler::FTPLibrary->new($options->{'server'});
    $ftp->login($options->{'username'},$options->{'password'}); #
     my @list = $ftp->ls();

     #### RESTRICTION is that the FTP SITE SHOULD NOT HAVE THE DIRECTORY IN THIS FOLDER ######
     foreach my $file (@list) {
     	$ftp->get($file,$options->{'dest'});
     }
     return;
}