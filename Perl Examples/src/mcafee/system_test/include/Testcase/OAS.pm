
package Testcase::OAS;
use strict;
use MSMConst;
use Testcase;
our @ISA = ('Testcase');
sub new {
	my ($package, $rh_config, $log, $msm, $result_log) = @_;
	my $self = Testcase->new($rh_config, $log, $msm);
	$self->{'result_log'} = $result_log if $result_log;
	bless $self, $package;
	return $self;
}

sub init {
    my ($self) = @_;
    my $data_dir = $DATA_DIR . "/" . $self->{'config'}->{'data_dir'};
    my $log      = $self->{'log'} ;
    if($self->{'config'}->{'file_count'}) {
        rmdir($data_dir) if -e $data_dir;
        mkdir($data_dir);
    } else {
	unless (-d $data_dir) {
	    $log->error("$data_dir does not exist") if $log;
	    return 0;
	}
    }
    return 1;
}

sub clean {
    my ($self) = @_;
    my $data_dir = $DATA_DIR."/". $self->{'config'}->{'data_dir'};
    rmdir $data_dir if -e $data_dir and $self->{'config'}->{'file_count'};
    $self->{'product'}->set_product_pref{'$self->{'config'}->{'reset_to_defaults'},'$self->{'config'}->{'test_tool'}');
}

sub _execute_write {
    my ($self, $file_count, $source_dir) = @_;
    for (my $i = 1 ; $i <= $file_count; $i++) {
        open(FP,"> $source_dir/oas_data.$i") or die "$source_dir/oas_data.$i \n";   
        print FP $self->{'config'}->{'data'};
        close (FP);
    }

}


sub _execute_read {
    my ($self, $source_dir) = @_;
    &File::Find::find( sub { 
		if ( -f $File::Find::name) {
			open(my $fh, $File::Find::name) or syswrite(\*STDERR, "Could not open file : ${File::Find::name}\n");
			close $fh if $fh;
		}
	}, $source_dir);
}
