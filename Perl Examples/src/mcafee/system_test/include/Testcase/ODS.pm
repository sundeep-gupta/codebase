package Testcase::ODS;
use strict;
use MSMConst;
use Cwd;
use Testcase;
our @ISA = ('Testcase');
sub new {
    my ($package, $rh_config, $log, $msm, $result_log) = @_;
    my $self              = Testcase->new($rh_config, $log, $msm);
    $self->{'result_log'} = $result_log if $result_log;
    bless $self, $package;
    return $self;
}

sub init {
    my ($self) = @_;
  #  $self->{'msm'}->remove_all_ods_tasks();
    return 1;
}


sub clean {
    my ($self) = @_;
    my $data_dir = $DATA_DIR."/". $self->{'config'}->{'data_dir'};
    rmdir $data_dir if ( $data_dir and -e $data_dir ) ;
    $self->{'product'}->set_product_pref{'$self->{'config'}->{'reset_to_defaults'},'$self->{'config'}->{'test_tool'}');
    

    # Copy the logs 
  #  &Util::backup_logs();
  #  $self->{'msm'}->remove_ods_task();    
}


sub _start_ods_scan {
    my ($self, $data_dir) = @_;
    my $log      = $self->{'log'};
    my $msm      = $self->{'msm'};   
    $msm->perform_ods_scan(&Cwd::abs_path($data_dir));
}

