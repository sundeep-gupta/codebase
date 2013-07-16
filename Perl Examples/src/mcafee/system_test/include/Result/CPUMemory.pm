package Result::CPUMemory;
use strict;
use Result;
our @ISA = qw(Result);


sub new {
    my ($package, $logfile) = @_;
    my $self = Result->new($logfile);
    bless $self, $package;

}


sub append {
	my ($self, $new_results) = @_;

	if (-e $self->{'filename'}) {
	    $new_results->{'Capture Time'} = time();
		my $ra_keys = $self->_get_keys();
		my $ra_new_keys = &_change_in_keys($ra_keys, $new_results);
		if( scalar @$ra_new_keys > 0 ) {
			# New row added change the file accordingly.
			$self->_create_new_data($ra_keys, $ra_new_keys) ;
		}
		# No new record added. so we can simply append 
		my $record = $new_results->{'Capture Time'};
		foreach my $key (@$ra_keys) {
			next if $key eq 'Capture Time';
			$record = $record.",". $new_results->{$key};
		}	
		print "Now appending $record\n";
		$self->_append_to_file($record);
	} else {
		$self->create_result($new_results);
	}

}

sub _change_in_keys {
	my ($ra_prev_keys, $rh_new_result) = @_;
	my @new_keys = ();
	# If not in new result, create a key in new result set
	foreach my $key (@$ra_prev_keys) {
		$rh_new_result->{$key} = ' ' unless $rh_new_result->{$key};
	}

	# If not in prev_keys, append it to new keys list
    foreach my $key (keys %$rh_new_result) {
		push @new_keys,$key unless grep { $_ =~ /^$key$/ ; } @$ra_prev_keys;
	}
	return \@new_keys;
}

sub _create_new_data {
	my ($self, $ra_prev_keys, $ra_new_keys) = @_;

	my $filename = $self->{'filename'};
	open (my $fh, $filename);
	my @content = <$fh>; chomp @content;
	close $fh;

	open (my $fh, ">".$filename);
    syswrite($fh, $content[0] . ",". join (',', @$ra_new_keys) . "\n");
	my $dummy_fields = ', ' x scalar @$ra_new_keys;
	for ( my $i = 1; $i < scalar @content; $i++) {
		syswrite($fh, 	$content[$i] . $dummy_fields ."\n");
	}

	close $fh;
}
