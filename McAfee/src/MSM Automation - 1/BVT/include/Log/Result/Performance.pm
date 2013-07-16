package Log::Result::Performance;

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

sub write {
    my ($self, $new_results) = @_;
    open ( my $fh, ">> ". $self->{'filename'} ) or die "Could not open file : $! : ". $self->{'filename'};
    while ( my ( $tc_name, $value) = each %$new_results) {
       syswrite( $fh, "$tc_name,$value\n" );
    }
    close $fh;
}


sub compute_average {
    my ($self) = @_;
    my $raa_dump = [];
return 0;


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
