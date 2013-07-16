# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::ODSQuarantine;
use Testcase::ODS;
use Const;
use strict;
use File::Find;
use Time::HiRes qw/gettimeofday/;

our @ISA = ('Testcase::ODS');
sub new {
    my ($package, $rh_param) = @_;
    my $self = Testcase::ODS->new($rh_param);
    bless $self, $package;
    return $self;
}
sub init {
    my ($self) = @_;
    Testcase::ODS::init($self);

    my $data_dir   = $self->{'config'}->{'data_dir'};   
    my $log        = $self->{'log'};
    my $product    = $self->{'product'};
    
    unless ($data_dir) {
        $log->error("Testcase initialization error: $data_dir not defined") if $log;
        return 0;
    }
       
    $data_dir = "$DATA_DIR/$data_dir";
    rmdir($data_dir) if -e $data_dir;
    mkdir($data_dir);
    $product->delete_quarantine();

    $log->info( "unloading scan manager");
    $product->unload_scanner();
    sleep 15;
    $log->info("Copying the payload");
    
    open(FP,"> $data_dir/ods_data.1") or die "$data_dir/ods_data.1 \n";   
    syswrite(FP, $self->{'config'}->{'data'});
    close (FP);
    
    $log->info("loading the scanmanager");
    $product->load_scanner();
    sleep 15;
}


sub execute {
    my ($self)     = @_;
    my $data_dir   = $DATA_DIR."/".$self->{'config'}->{'data_dir'};
    my $log        = $self->{'log'};
    
    $log->info("Starting ODS Scan");
    $self->{'start_time'} = [gettimeofday() ];
    
    if( $self->{'config'}->{'capture_cpu_memory'} ) {
        if ( $self->{'config'}->{'capture_cpu_memory'} == 1) {
            my $th = threads->create('Testcase::ODS::_start_ods_scan', $self, $data_dir);
            &_capture_cpu_metric_on_thread($self, $th);
        } else {
            $self->_start_ods_scan($data_dir);
        }
    }
    else {
	$self->_start_ods_scan($data_dir);
    }

    $self->{'end_time'} = [gettimeofday() ];
    $log->info("ODS Scan completed");
}

sub _capture_cpu_metric_on_thread {
    my ($self, $thread)   = @_;
    my $ra_resource_stats = [];
    my $sleep_time        = $self->{'config'}->{'capture_frequency'};
    my $log               = $self->{'log'};
    my $result_log        = $self->{'result_log'};

    while($thread->is_running()) {
        $log->info("Capturing CPU Metrics") ;
        my $cpu_memory = Resource::CPUMemory->new("$LOG_DIR/cpu_memory_ods_scan.log",
                                                  $self->{'product'}->get_product_process());
	$cpu_memory->get();
	sleep $sleep_time;
    }
    $log->info("Waiting the thread to join") ;
    my $time = $thread->join();
    $log->info("Install thread joined") ;

}

sub verify {
    my ($self) = @_;
    my $product = $self->{'product'};
    my $log = $self->{'log'};
    my $data_dir   = $self->{'config'}->{'data_dir'};
    $data_dir = "$DATA_DIR/$data_dir";
      
    if($product->verify_ods(&Cwd::abs_path( "$data_dir/ods_data.1" ) )) {
	$self->{'result'}  = {'ODSQuarantine' => $PASS};
    $log->info("ODSQuarantine is PASS") ;
    } else {
	$self->{'result'}  = {'ODSQuarantine' => $FAIL};
    $log->info("ODSQuarantine is FAIL") ;
    }
}

sub clean {
    my ($self) = @_;
    Testcase::ODS::clean($self);
}

1;
