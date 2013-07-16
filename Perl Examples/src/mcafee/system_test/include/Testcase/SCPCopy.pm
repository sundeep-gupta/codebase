package Testcase::SCPCopy;
use strict;
use MSMConst;

our @ISA = ('Testcase');
sub new {
	my ($package, $rh_config, $log, $msm, $result_log) = @_;
	my $self = Testcase->new($rh_config, $log, $msm);
	bless $self, $package;
    $self->{'result_log'} = $result_log if $result_log;
	return $self;
}

sub init {
    my ($self) = @_;
    my $target = $self->{'config'}->{'target'};
    rmdir ($target) if -e $target;
    mkdir $target;

}

sub clean {
    my ($self) = @_; 
 my $target = $self->{'config'}->{'target'};
   
    rmdir ($target) if -e $target;    
}

sub execute {
    my ($self) = @_;
    my $log      = $self->{'log'};
    my $result_log = $self->{'result_log'};
    my $server   = $self->{'config'}->{'server'};
    my $user     = $self->{'config'}->{'user'};
    my $password = $self->{'config'}->{'password'};
    my $target   = $self->{'config'}->{'target'};
    my $ra_files = $self->{'config'}->{'files'};
    my $source   = $self->{'config'}->{'source'};
    $target      = "$DATA_DIR/$target";
    my $start_time = time();
    foreach my $file (@$ra_files) {
	my $command = "scp  ${user}:${password}\@${server}:${source}/${file} ${target}/${file} ";
	$log->info("SCP: $command");
	system($command);
    }

    $result_log->append( {'SCPCopy' => time() - $start_time } );
}

1;
