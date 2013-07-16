# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::AppProtNoNetworkAccess;
use strict;
use Testcase;
use System;
use AppleScript;
use Time::HiRes qw(gettimeofday);
use Const;

our @ISA = ('Testcase');
sub new {
    my ($package, $rh_param) = @_;
    my $self  = Testcase->new($rh_param);
    bless $self, $package;
    return $self;
}

sub init {
    my ($self) = @_;
    my $log = $self->{'log'};
    
    my $data_dir   = $self->{'config'}->{'data_dir'};
    
    unless ($data_dir) {
        $log->error("Testcase initialization error: $data_dir not defined") if $log;
        return 0;
    }

    my $app_name   = $self->{'config'}->{'app_name'};
    my $app_src_dir   = $self->{'config'}->{'app_src_dir'};
    
    $data_dir = "$DATA_DIR/$data_dir";
    rmdir($data_dir) if -e $data_dir;
    mkdir($data_dir);

    my $source_file = "$app_src_dir/$app_name";
    my $dest_file = "$data_dir/$app_name";
    
    $log->info("Copying the $source_file into $data_dir");

    # Copy the binary file to the destination since the source folder
    # can be special folder as per AppProt rules...
    `cp $source_file $dest_file`;
   
    # Delete existing AppProt rules if any... 
    my $product = $self->{'product'};
    $product->delete_app_rules();
}

sub clean {
    my ($self) = @_;
    my $log = $self->{'log'};
   
     my $data_dir = $self->{'config'}->{'data_dir'};
    $data_dir = "$DATA_DIR/$data_dir";
    rmdir($data_dir) if -e $data_dir;
    $log->info("Removing directory $data_dir");
 
    my $product = $self->{'product'};

    # Removing added appProt rules as part of cleanup...
    $product->delete_app_rules();
}

sub execute {
    my ($self) = @_;
    my $log = $self->{'log'};
    my $product = $self->{'product'};
    $self->{'start_time'} = [gettimeofday()];

    # Make sure the appProt and the aptt FMs are installed...
    return unless ($product->is_fm_installed("AppProtection"));
    $product->add_fm('aptt') if not $product->is_fm_installed('aptt');

    unless ( $self->{'product'}->is_service_running('appProtd'))
    {
        $self->{'result'}->{ 'AppProtNoNetworkAccess'} = $FAIL;
        return;
    }

    my $data_dir = $self->{'config'}->{'data_dir'};
    $data_dir = "$DATA_DIR/$data_dir";

    my $app_name = $self->{'config'}->{'app_name'};
    my $dest_file = "$data_dir/$app_name";
    $dest_file = &Cwd::abs_path($dest_file);

    # Add the above app without network access as appProt rule...
    my $cmd = $product->{'tools'}->{'aptt'}->{'bin'} . ' 20000 "'. $dest_file.'" 1 1 2 2>&1';
    my $cmd_out = &System::get_object_reference()->execute_cmd("sudo $cmd");

    # Now check whether the command got timed out...
    $cmd = $dest_file.' www.google.com | grep "timed out"';
    $cmd_out = &System::get_object_reference()->execute_cmd("$cmd");
    chomp $cmd_out;

    $self->{'result'}->{ 'AppProtNoNetworkAccess'} = $FAIL;
    if($cmd_out ne '')
    {
	$self->{'result'}->{'AppProtNoNetworkAccess'} = $PASS;
    }
    $log->info($cmd_out);

    $self->{'end_time'} = [ gettimeofday() ];
}

sub verify {
	my ($self) = @_;
}

1;
