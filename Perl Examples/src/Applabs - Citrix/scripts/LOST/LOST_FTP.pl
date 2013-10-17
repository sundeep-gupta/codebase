use strict;
use Data::Dumper;
use WANScaler::FTPLibrary;
use threads;
#use WANScaler::LOST::Config;

######## Start N Sessions of FTP Parallelly ################################
my %ftp = (
		'server' => '10.1.2.4',
		'username' => 'kl',
        'password' => 'test',
     	'instances' => 2,
   		'dest' 		=> 'NUL:'
		);
start_ftp_in_loop(undef,\%ftp);

sub start_ftp_in_loop {
	my ($package, $options) = @_;
	my $ftp_connections = $options->{'instances'};
    while(1) {
    	my $ftp_thread = threads->new(&start_multi_ftp,$options);
        $ftp_thread->join();
    }
	return;
}
sub start_multi_ftp {
	my $options = shift;
    my @ftp_threads;
    for(my $i=0;$i<$options->{'instances'};$i++) {
		$ftp_threads[$i] = threads->new(\&start_ftp, $options);
        syswrite(\*STDOUT,"Starting new thread\n");
    }
    for(my $i=0;$i<$options->{'instances'};$i++) {
        syswrite(\*STDOUT,"Waiting to join\n");
    	$ftp_threads[$i]->join;
    }
}
sub start_ftp {
	my $options = shift;
	my $ftp = WANScaler::FTPLibrary->new($options->{'server'});
    print Dumper($ftp);

   $ftp->login($options->{'username'},$options->{'password'}); #
    my @list = $ftp->ls();

#    print Dumper(\@list);
    #### RESTRICTION is that the FTP SITE SHOULD NOT HAVE THE DIRECTORY IN THIS FOLDER ######
    foreach my $file (@list) {
    	syswrite(\*STDOUT, 'Getting'.$file);
    	$ftp->get($file,$options->{'dest'});
    }
    return;
}