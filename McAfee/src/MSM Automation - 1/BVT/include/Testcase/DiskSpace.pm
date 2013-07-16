# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::DiskSpace;
use strict;
use File::Find;
use Testcase;
use Const;
our @ISA = ('Testcase');
sub new {
    my ($package, $rh_param) = @_;
    my $self = Testcase->new($rh_param);
    bless $self, $package;
    return $self;
}

sub execute {
    my ($self)        = @_;
    my $product           = $self->{'product'};
    my $ra_prod_paths = $product->get_product_paths();
    $ra_prod_paths  ||= $self->{'config'}->{'product_paths'};

    my $ra_dat_paths  = $product->get_dat_paths();
    $ra_dat_paths   ||= $self->{'config'}->{'dat_paths'};
    my $prod_size     = 0;
    my $dat_size      = 0;
    my $log           = $self->{'log'};
    $log->info("Calculating product disk space") if $log;
    foreach my $dir (@$ra_prod_paths) {
        &File::Find::find( {'no_chdir' => 1, 'wanted' => sub { $prod_size += -s $File::Find::name ; } } , $dir) if -e $dir;
    }

    $log->info("Calculating dat space") if $log;
    foreach my $dir (@$ra_dat_paths) {
	&File::Find::find( { 'no_chdir' => 1, 'wanted' => sub { $dat_size += -s $File::Find::name; } }, $dir) if -e $dir;
    }
    open( my $fh, ">>".$LOG_DIR."/disk_usage.log");
    print $fh "DiskSpace_Product $prod_size\nDiskSpace_DAT,$dat_size\n";
    close $fh;
    $self->{'result'} = {'DiskSpace' => $PASS,
                         'DiskSpace_Product' => $prod_size,
                         'DiskSpace_DAT'     => $dat_size,
                         };
   
} 

1;
