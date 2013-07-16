package Testcase::DiskSpace;
use strict;
use File::Find;
use Testcase;

our @ISA = ('Testcase');
sub new {
    my ($package, $rh_config, $log, $msm, $result_log) = @_;
    my $self = Testcase->new($rh_config, $log, $msm);
    bless $self, $package;
    $self->{'result_log'} = $result_log if $result_log;
    $self->{'log'}        = $log        if $log;
    return $self;
}

sub execute {
    my ($self)        = @_;
	my $msm           = $self->{'msm'};
	my $ra_prod_paths = $msm->get_product_paths();
    $ra_prod_paths  ||= $self->{'config'}->{'product_paths'};

	my $ra_dat_paths  = $msm->get_dat_paths();
	$ra_dat_paths   ||= $self->{'config'}->{'dat_paths'};
    my $prod_size     = 0;
    my $dat_size      = 0;
    my $log           = $self->{'log'};
    $log->info("Calculating product disk space") if $log;
    foreach my $dir (@$ra_prod_paths) {
        &File::Find::find( sub { $prod_size += -s $File::Find::name ; }, $dir) if -e $dir;
    }

    $log->info("Calculating dat space") if $log;
    foreach my $dir (@$ra_dat_paths) {
	&File::Find::find( sub { $dat_size += -s $File::Find::name; }, $dir) if -e $dir;
    }
   
    $self->{'result_log'}->append( {'DiskSpace_Product' => $prod_size,
				    'DiskSpace_Dat'     => $dat_size,} ) if $self->{'result_log'};
} 

1;
