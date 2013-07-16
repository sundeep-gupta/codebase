package Testcase::OASMixed;
use Testcase::OAS;
use File::Find;
use MSMConst;
use strict;

our @ISA = ('Testcase::OAS');
sub new {

	my ($package, $rh_config, $log, $msm, $result_log) = @_;
	my $self = Testcase::OAS->new($rh_config, $log, $msm, $result_log);
	bless $self, $package;
	return $self;
}

sub execute {
    my ($self)     = @_;
    my $source_dir = $self->{'config'}->{'data_dir'};
    $source_dir    = "$DATA_DIR/$source_dir";
    my $file_count = $self->{'config'}->{'file_count'} || 0;
    my $start_time = time();
    if ($file_count) {
	$self->_execute_write($file_count, $source_dir);
    } else {
	$self->_execute_read($source_dir) if -e $source_dir;
    }
    $self->{'result_log'}->append( {'OASMixed' => time() - $start_time } ) 
		if $self->{'result_log'};
}
