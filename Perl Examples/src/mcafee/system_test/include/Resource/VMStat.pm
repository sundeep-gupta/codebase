package Resource::VMStat;
use strict;

my $VMSTAT_FOR_MAC = 'vm_stat';


sub new {
    my ($package, $logfile) = @_;
	my $self = {};
	$self->{'result_file'} = Result->new($logfile);
    bless $self, $package;
	return $self;
}
sub get {
	my ($self) = @_;
	my $fh_results = $self->{'result_file'};
    if($^O eq 'darwin') {
        my @vm_stat = `$VMSTAT_FOR_MAC`;
        my $rh_data = {};
        foreach my $line (@vm_stat) {
	    if( $line =~ /^"?(.*)"?:\s*(\d+)/ ) {
		$rh_data->{$1} = $2;
	    }
	}
	$fh_results->append($rh_data);
	return $rh_data;
    }

}

1;
