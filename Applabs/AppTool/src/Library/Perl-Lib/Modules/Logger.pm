#!/usr/bin/perl -w
#
# Copyright:     AppLabs Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision:  $
# Last Modified: $Date:  $
# Modified By:   $Author:  $
# Source:        $Source:  $
#
####################################################################################
##
##

use System::Environment;
use Modules::Config;
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------


#
# logHistory() - This function logs any data passed to it. The history log contains server actions.
# Input:  $content - String containing the content to be logged
# Output: Returns 1 if successful and undef if failed
sub logHistory {
    my($content) = @_;
    
    my $log_file = $CONFIG->{'LOG_PATH'} . $CONFIG->{'LOG_FILE'};
    my $timestamp = fetchDate();
    
    # Make sure our content is defined
    if (defined($content) && ($content ne "")) {
        $content = "[$timestamp]: $content";
    }
    else {
        return;
    }
    
    # Append
    if (-e $log_file) {
        open(OUTFILE, ">>$log_file") || die "Cannot append to $log_file: $!\n";
        print OUTFILE "$content\n";
        close(OUTFILE);
    }
    # Create
    else {
        open(OUTFILE, ">$log_file") || die "Cannot create $log_file: $!\n";
        print OUTFILE "$content\n";
        close(OUTFILE);
    }
    
    return 1;
}

#
# logEvent() - This function logs any data passed to it. The event log contains command events (i.e. read, write, execute).
# Input:  $content - String containing the content to be logged
# Output: Returns 1 if successful and undef if failed
sub logEvent {
    my($content) = @_;
    
    my $log_file = $CONFIG->{'LOG_PATH'} . $CONFIG->{'EVENT_LOG'};
    my $timestamp = fetchDate();
    
    # Make sure our content is defined
    if (defined($content) && ($content ne "")) {
        $content = "[$timestamp]: $content";
    }
    else {
        return;
    }
    
    # Append
    if (-e $log_file) {
        open(OUTFILE, ">>$log_file") || die "Cannot append to $log_file: $!\n";
        print OUTFILE "$content\n";
        close(OUTFILE);
    }
    # Create
    else {
        open(OUTFILE, ">$log_file") || die "Cannot create $log_file: $!\n";
        print OUTFILE "$content\n";
        close(OUTFILE);
    }
    
    return 1;
}

#
# fetchDate() - This function creates a basic formatted timestamp
# Input:  Nothing
# Output: Returns the local time in the format of: 'MM/DD/YY - HH:MM:SS'
sub fetchDate {
    # Time Information
    my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $year = $year + 1900;
    $mon  = $mon + 1;
    my $localtime = "$mon/$mday/$year - $hour:$min:$sec";
    return $localtime;
}


1;

__END__
