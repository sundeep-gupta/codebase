# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::Update;
use File::Find;
use Const;
use Testcase;
use Data::Dumper;
use strict;
use Time::HiRes qw/gettimeofday/;
our @ISA = ('Testcase');
sub new {
    my ($package, $rh_param) = @_;
    my $self = Testcase->new($rh_param);
    bless $self, $package;
    return $self;
}

sub execute {
    my ($self)     = @_;
    my $product    = $self->{'product'};
    my $rh_result  = {};
    $self->{'start_time'} = [ gettimeofday() ];
    my $start_time = time();
    $rh_result->{'Update'} = $product->manual_update();
    $self->{'end_time'}   = [ gettimeofday() ];
    $self->{'result'}     = {'Update' => $PASS };
}

sub init {
    my ($self)   = @_;
    my $log     = $self->{'log'} ;
    my $product  = $self->{'product'};
    my $system   = &System::get_object_reference();

    # Wait if update already running
    while( $product->is_update_running() ) { sleep 1; }


    # Replace current dats and plist file to make sure Update takes place
    # Unload scanners
    $log->info( "unloading scan manager");
    $product->unload_scanner();
    sleep 10;

    my $replace_dat = $self->{'config'}->{'dat'};
    my $rh_dat = $product->get_dat_version();
    my $dat = ( split '\.',$rh_dat->{'Update_DATVersion'}) [0];
    my $ra_dat_path = $product->get_dat_paths(); 
    if ( -e ($ra_dat_path->[0]. '/' . $dat)) {
	$log->info("Removing existing dat ". $ra_dat_path->[0]. '/' . $dat );
        $system->execute_cmd('rm -rf ' . $ra_dat_path->[0]. '/' . $dat) ;
    }
    
    my $source_dir =  $DATA_DIR.'/eupdate_data';

    $log->info( "Source dir is - $source_dir \n");

    # Copy over the dat and plist    
    my $plist = &File::Basename::basename($product->{'am_pref'});
    unlink $product->{'am_pref'} ; 
    $log->info("cp -r $source_dir/$replace_dat ". $ra_dat_path->[0].'/');
    $system->execute_cmd("cp -r $source_dir/$replace_dat ". $ra_dat_path->[0].'/');
    $log->info("Executing cp -r $source_dir/$plist ".$product->{'am_pref'}." \n");
    $system->copy({'source'=>"$source_dir/$plist", 'target'=> $product->{'am_pref'}});
    $system->chmod( {'permission' => 0755,
		     'path' => $product->{'am_pref'} } );	
    # TODO: Check and chmod of dat directory & files
	
    # TODO: Reload the scanners 
    $log->info("loading the scanmanager");
    $product->load_scanner();
    sleep 10;

    $rh_dat =  $product->get_dat_version(); 
    $self->{'old_dat'} = $rh_dat->{'Update_DATVersion'}; 
    $log->info("Replaced DAT is - ".$self->{'old_dat'});    
}

sub verify {
    my ($self)   = @_;
    my $product  = $self->{'product'};
    my $rh_dat  = $product->get_dat_version();
    my $new_dat = $rh_dat->{'Update_DATVersion'};; 
    my $old_dat  = $self->{'old_dat'};
    if ($new_dat > $old_dat) {
        $self->{'result'} = {'Update' => $PASS };
    } else {
        $self->{'result'} = {'Update' => $FAIL };
    }
}
1;     
