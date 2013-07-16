package Testcase::FTPCopy;
use strict;
use MSMConst;
use AppleScript;
use Net::FTP;
our @ISA = ('Testcase');
sub new {
    my ($package, $rh_config, $log, $msm, $result_log) = @_;
    my $self = Testcase->new($rh_config, $log, $msm);
    bless $self, $package;
    $self->{'result_log'} = $result_log;
    return $self;
}

sub init {
	my ($self) = @_;

	# Do product specific checks here...

	# Test data checks.
	
}

sub clean {
    my ($self) = @_;

}

sub execute {
    my ($self)     = @_;
    my $result_log = $self->{'result_log'};
    my $log        = $self->{'log'};
    my $server     = $self->{'config'}->{'server'};
    my $user       = $self->{'config'}->{'user'};
    my $password   = $self->{'config'}->{'password'};
    my $target     = $self->{'config'}->{'target'};
    my $ra_files   = $self->{'config'}->{'files'};
    my $source     = $self->{'config'}->{'source'};
    my $pwd        = &Cwd::getcwd();
    chdir($target);

    my $ftp = Net::FTP->new($server, Debug => 0);
    $ftp->login($user, $password);
    $ftp->binary();
    $ftp->cwd($source);    

    my $start_time = time();
    foreach my $file (@$ra_files) {
        $ftp->get($file);
    }
    $ftp->quit;
    chdir($pwd);

    $self->{'result_log'}->append({ 'FTPCopy' =>  time() - $start_time});
    return;    
}
1;
