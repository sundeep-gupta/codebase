package Result;
use strict;
use MSMConst;
use MSMConfig;
use Log;


sub new {
    my ($package, $filename) = @_;
	my $self = {'filename' => $filename,};
	bless $self, $package;
	return $self;

}

sub append {
	my ($self, $new_results) = @_;

	if (-e $self->{'filename'}) {
	    $new_results->{'Capture Time'} = time();
		my $ra_keys = $self->_get_keys();
		my $record = $new_results->{'Capture Time'};
	    foreach my $key (@$ra_keys) {
			next if $key eq 'Capture Time';
#			my $value = $new_results->{$key};
#			my @values = split(':', $value);
#			foreach my $v (@values) {
				$record = $record.",". $new_results->{$key};
#			}				
			delete $new_results->{$key};
		}
	# if any elements remained... its not our responsibility :-)
		$self->_append_to_file($record);
	} else {
		$self->create_result($new_results);
	}
	#exit;
}

sub _get_keys {
	my ($self) = @_;
	return unless -e $self->{'filename'};
	open (my $fh, $self->{'filename'}) ;
	my @lines = <$fh>; chomp @lines;
	close $fh;

	return [ split(',', $lines[0] )];
}
sub _append_to_file {
	my ($self, $record) = @_;
	open(my $fh, ">> ".$self->{'filename'});
	syswrite($fh, $record."\n");
	close $fh;
 #   system("echo $record >> ".$self->{'filename'});
}

sub create_result {
	my ($self, $new_result) = @_;
	my $header = "Capture Time";
	my $record = time();
	foreach my $key (keys %$new_result) {
		$header = "$header,$key";
		$record = "$record,".$new_result->{$key} ;
	}
	open (my $fh, "> ".$self->{'filename'}) or print "Could not create file :". $self->{'filename'};
	print $fh $header."\n";
	print $fh $record."\n";
	close $fh;
}



sub average_result {
    my ($ra_result) = @_;
    my $rh_avg      = {};
    my $rh_sum      = {};
    foreach my $result (@$ra_result) {
	foreach my $key (keys %$result) {
	    if ($rh_sum->{$key} ) {
                $rh_sum->{$key}->{'sum'} += $result->{$key};
		$rh_sum->{$key}->{'count'} = $rh_sum->{$key}->{'count'} + 1;
	    } else {
	        $rh_sum->{$key} = {'sum' => $result->{$key}, 'count' => 1};
	    }
        }
    }
    foreach my $key ( %$rh_avg) {
        $rh_avg->{$key} = $rh_sum->{$key}->{'sum'} / $rh_sum->{$key}->{'count'} ;
    }
    return $rh_avg;

}

1;
