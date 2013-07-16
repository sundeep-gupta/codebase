package Resource::Leaks;
use strict;
#############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091023 : Created
##############################################################
BEGIN {
    push @INC, "include" unless ( grep {$_ =~ /^include$/;} @INC);
    use System;
    use Log::Result::Performance;
}
sub new {
    my ($package, $logfile, $ra_pid) = @_;
    my $self = {};
    $self->{'result_file'} = Log::Result::Performance->new($logfile);
    bless $self, $package;
    return $self;
}


sub get {
    my ($self, $ra_pid) = @_;
    my $fh_results = $self->{'result_file'};
    my $system     = &System::get_object_reference();
    foreach my $pid ( @$ra_pid) {
        my $ra_data    = $system->leaks($pid->{'pid'});
        chomp @$ra_data;
        foreach my $total (grep { $_ =~ /total/ } @$ra_data) {
            $fh_results->write({ $pid->{'name'} => $total });
        }
    }

}

1;
