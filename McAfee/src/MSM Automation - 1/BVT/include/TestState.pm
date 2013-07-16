# Copyright (c) 2010, McAfee Inc.  All rights reserved.
package TestState;

sub new {
    my ($package,$ra_test_case) = @_;
    my $self = {};
    bless $self, $package;
    $self->{'test_state_file'} = '.test_state';
    if( -e $self->{'test_state_file'}) {
        $self->{'test_state'} = $self->_read_test_state();
    } else {
      $self->{'test_state'} = $ra_test_case;
      $self->{'timestamp'} = time();
      foreach my $rh_test_state (@$ra_test_case) {
	  $rh_test_state->{'completed'} = 0;
	  $rh_test_state->{'results'} = 0;
	  $rh_test_state->{'runnable'} = $rh_test_state->{'total'};
        }
    }
    return $self;
}
sub all_runs_completed {
    my ($self) = @_;
    my $ra_test_state = $self->{'test_state'};
    foreach my $rh_test_state (@$ra_test_state) {
        return 0 if $rh_test_state->{'runnable'};
    }
    return 1;

}
sub get_next_testcase {
    my ($self) = @_;
    my $ra_test_state = $self->{'test_state'};
    for( my $i = 0; $i < scalar @$ra_test_state; $i++) {
	return $i if $$ra_test_state[$i]->{'runnable'}; 
    }
}
sub increment {
    my ($self, $tc_idx) = @_;
    $self->{'test_state'}->[$tc_idx]->{'runnable'} -= 1;
    $self->{'test_state'}->[$tc_idx]->{'completed'} += 1;
    $self->_save_test_state();
}
sub _save_test_state {
    my ($self) = @_;
    open(my $fh, "> ".$self->{'test_state_file'});
    syswrite($fh, $self->{'timestamp'}."\n");
    my $ra_test_state = $self->{'test_state'};
    foreach my $rh_test_state (@$ra_test_state) {
        syswrite($fh, $rh_test_state->{'name'}.":".
                      $rh_test_state->{'total'}.":".
		      $rh_test_state->{'completed'}.":".
		      $rh_test_state->{'results'}."\n");
    }
    close $fh;
}

sub set_results_computed {
    my ($self, $tc_idx) = @_;
    $self->{'test_state'}->[$tc_idx]->{'results'} = 1;
    $self->_save_test_state();
}

sub runnable {
    my ($self, $tc_idx) = @_;
    my $ra_test_state = $self->{'test_state'};
    return $self->{'test_state'}->[$tc_idx]->{'runnable'};
}

sub is_results_computed {
    my ($self, $tc_idx) = @_;
    return $self->{'test_state'}->[$tc_idx]->{'results'};

}
sub _read_test_state {
    my ($self) = @_;
    my $test_state_file = $self->{'test_state_file'};
    return [] unless -e $test_state_file;
    open(my $fh, $test_state_file);
    my @states = <$fh>; chomp @states;
    close $fh;
    $self->{'timestamp'} = shift @states;
    
    my $ra_test_state = [];
    foreach my $state (@states) {
        my ($tc_name, $total, $completed, $results) = split(":", $state);
        my $rh_test_state = {'name' => $tc_name,
			  'total' => $total,
			  'completed' => $completed,
			  'runnable' => $total - $completed,
			  'results' => $results
			};
        push @$ra_test_state, $rh_test_state;
    }
    return $ra_test_state;
}

1;
