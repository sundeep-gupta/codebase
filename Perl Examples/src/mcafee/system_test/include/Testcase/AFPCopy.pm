package Testcase::AFPCopy;
use strict;
use MSMConst;
use Testcase;

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
    my $target_dir = $self->{'config'}->{'target'};
    my $log        = $self->{'log'};

    $self->_umount_afp($target);
    $log->info("Mounting $target");
    $self->_mount_afp_target($rh_testcase_config);	
}

sub clean {
    my ($self) = @_;
    my $target = $self->{'config'}->{'target'};
    my $log    = $self->{'log'};
    $log->info("Unmounting $target") if $log;
    $self->_umount_afp($target);
}

sub execute {
    my ($self) = @_;
    my $rh_testcase_config = $self->{'config'};

    my $target = $self->{'config'}->{'target'};
    my $files  = $self->{'config'}->{'files'};
    my $source = $self->{'config'}->{'source'};
    my $log    = $self->{'log'};
    my $resource_log = $self->{'resource_log'};
    $source      = "$DATA_DIR/$source";

    $log->info("Starting AFPCopy") if $log;
    my $start_time = time();
    foreach my $file (@$ra_files) {
	copy("$source/$file", $target);
    }

    $self->{'result_log'}->append({'AFPCopy'=>  time() - $start_time});
    return 1;    
}

sub _mount_afp_target {
    my ($self) = @_;
    my $rh_testcase_config = $_[0];
    my $server   = $self->{'config'}->{'server'};
    my $user     = $self->{'config'}->{'user'};
    my $password = $self->{'config'}->{'password'};
    my $dir      = $self->{'config'}->{'server_dir'};
    my $target   = $self->{'config'}->{'target'};

    my $command = "mkdir $target; sudo mount -t afp afp://${user}:${password    }\@${server}:/${dir} ${target}";
    $log->info("command '$command'");
    return system($command);
}


sub _umount_afp {
    my ($self, $target) = @_;
    return system("umount $target");
}

1;
