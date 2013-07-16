package Resource::Df;
use strict;

#TODO : Filesys::Df module in perl exist, but unable to install.
my $DF_COMMAND = 'df -ahm';

sub new {
    my ($package, $logfile) = @_;
	my $self = {};
	$self->{'result_file'} = Result->new($logfile);
    bless $self, $package;
	return $self;
}


sub get {
	my ($self) = @_;
    return unless $^O eq 'darwin';
    my $fh_results = $self->{'result_file'};
    my @df_output = `$DF_COMMAND`;
    chomp @df_output;
    my $ra_df = [];
    
    foreach my $line (@df_output) {
				my $rh_df = {};
			if ($line =~ /^(.*?)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)%\s+(.+)$/) {
				my $file_system = $1; $file_system =~ s/\s+$//;
				$rh_df->{'Filesystem'} = $file_system;
				$rh_df->{'Blocks'}     = $2;
				$rh_df->{'Used'}       = $3;
				$rh_df->{'Available'}  = $4;
				$rh_df->{'Capacity'}   = $5;
				$rh_df->{'Mount'}      = $6;
				$fh_results->append($rh_df); 
				push @$ra_df, $rh_df;
			}; 
    }
}


