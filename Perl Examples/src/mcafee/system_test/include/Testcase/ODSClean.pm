package Testcase::ODSClean;
use Testcase::ODS;
use MSMConst;
use strict;
our @ISA = ('Testcase::ODS');
sub new {

	my ($package, $rh_config, $log, $msm, $result_log) = @_;
	my $self = Testcase::ODS->new($rh_config, $log, $msm, $result_log);
    bless $self, $package;
    return $self;
}

sub execute {
    my ($self)     = @_;
    my $data_dir   = $self->{'config'}->{'data_dir'};
    my $log        = $self->{'log'};
    my $result_log = $self->{'result_log'};
    $data_dir      = "$DATA_DIR/$data_dir";
    my $start_time = time();
    $log->info("Starting ODSClean Scan") if $log;
    $self->_start_ods_scan($data_dir);
    $log->info("ODS Scan completed") if $log;
    $result_log->append( {'ODSClean' => time() - $start_time } ) if $result_log;
    return 1;
}
