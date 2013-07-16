package Log::Result;
##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# UID     YYMMDD : Comment
# -------------------------
# sgupta6 091116 : Created
##############################################################

use strict;
use Log;


sub new {
    my ($package, $filename) = @_;
    my $self = {'filename' => $filename,};
    bless $self, $package;
    return $self;
}

sub append {
    my ($self, $new_results) = @_;
    unless (-e $self->{'filename'}) {
        $self->create_result($new_results);
        return;
    }
    $new_results->{'Capture Time'} = time();
    my $ra_keys = $self->_get_keys();
    my $record  = $new_results->{'Capture Time'};
    foreach my $key (@$ra_keys) {
        next if $key eq 'Capture Time';
        $record = $record.",". $new_results->{$key};
        delete $new_results->{$key};
    }
    # if any elements remained... its not our responsibility :-)
    $self->_append_to_file($record);
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
        my $mode = '>';
            $mode = '>>';
            
	open(my $fh, $mode.' '.$self->{'filename'}) or die "Could not open file : $! : ". $self->{'filename'};
	syswrite($fh, $record."\n") if $fh;
	close $fh if $fh;
}

sub create_result {
	my ($self, $new_result) = @_;
	my $header = "Capture Time";
	my $record = time();
	foreach my $key (keys %$new_result) {
		$header = "$header,$key";
		$record = "$record,".$new_result->{$key} ;
	}
	open (my $fh, "> ".$self->{'filename'}) or die "Could not create file : $! : ". $self->{'filename'};
	print $fh $header."\n" if $fh;
	print $fh $record."\n" if $fh;
	close $fh if $fh;
}

sub compute_average {
    my ($self) = @_;
    my $raa_dump = [];
    open(my $fh, $self->{'filename'}) ;
    return unless $fh;
    foreach my $line (<$fh>) {
        chomp $line;
        my (@fields) = split(',', $line);
        # First field is capture time, so skip this.
        for (my $i = 1; $i < scalar @fields; $i++) {
            if (exists $$raa_dump[$i - 1 ] ) {
                push @{$$raa_dump[$i - 1]}, $fields[$i];
            } else {
	        push @$raa_dump, [$fields[$i]];
	    }
        }
    }
    close $fh;
    my $record = "Average Result";
    foreach my $ra_dump (@$raa_dump) {
	my $average = &_compute_average($ra_dump);
        $record .= ", $average";
    }    
    $self->_append_to_file($record);

}
sub _compute_average {
    my ($ra_num) = @_;
    my ($count, $sum) = (0,0);
    shift @$ra_num;
    foreach my $num (@$ra_num) {
        #TODO: Check if it is a number
        $count++;
        $sum += $num;
    }
    return sprintf "%.02f", $sum/$count if $count;
    return 0;
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
