package Resource::OpenPorts;
use strict;

my $LSOF_FOR_MAC = 'lsof -i -P | grep -i listen';

sub new {
    my ($package, $logfile) = @_;
	my $self = {};
	$self->{'result_file'} = Result->new($logfile);
    bless $self, $package;
	return $self;
}
sub get {
    my ($self)  = @_;
	my $fh_results = $self->{'result_file'};
    if($^O eq 'darwin') {
	# We store 'command_output' in log file and also
	# count of open ports in another log file.
	my @ports_output = `$LSOF_FOR_MAC`;
	my $rh_data     = {};
	$rh_data->{'open_port_count'} = scalar @ports_output;
	$rh_data->{'command_output'}  = join('', @ports_output);
		$fh_results->append($rh_data);
	return $rh_data;
    }
}


1;
