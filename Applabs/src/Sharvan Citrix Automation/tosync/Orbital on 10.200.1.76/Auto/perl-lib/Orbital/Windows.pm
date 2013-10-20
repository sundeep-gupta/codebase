#!/usr/bin/perl -w
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.2 $
# Last Modified: $Date: 2005/08/18 23:57:10 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbital/control/perl-lib/Orbital/Windows.pm,v $
#
####################################################################################
##
##


use vars qw($CONFIG_FILE $RESULTS_FILE $ORBITAL_PATH $LOG_PATH);
use lib "C:\\usr\\local\\orbital\\console\\perl-lib\\";
use Orbital::Config;
use strict;
use Data::Dumper;

# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

my $CONFIG_FILE  = $CONFIG->{'CONFIG_FILE'};    # Name of the config file created from our xml request
my $RESULTS_FILE = $CONFIG->{'RESULTS_FILE'};   # Name of results file created from Visual Test scripts
my $ORBITAL_PATH = "..\\..\\";                  # Directory of the Orbital Test Tool software package
my $LOG_PATH     = "..\\..\\console\\logs\\";   # Path of the log files

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

sub cleanUpMachine {
    # Close any shared directories that currently exist
    closeShares();
    
    # Check if there are any runaway Visual Test processes still alive, if so, capture a list of the PIDs
    my $retval = checkProcesses();
    my @PIDS = @$retval;
    
    # If there are any runaway processes, go ahead and kill them
    if ($#PIDS >= 0) {
        killProcesses($retval);
    }
}

#
# checkProcesses() - Check to see if there are any runaway Visual Test processes, if so return a list of the PID's
# Input:  Nothing
# Output: Array reference containing a list of all runaway Visual Test pid's
sub checkProcesses {
    # Define the following
    my $path   = $ORBITAL_PATH."Utility\\";    # Path/directory of our PsTools utilities
    my $command = "pslist.exe -e mtrun";     # Let's search exclusively for runaway Visual Test processes
    my @PIDS   = ();                           # List of process id's to return
    
    # Make sure we remember where we are
    use Cwd;
    my $old_path = cwd;
    $old_path =~ s/\//\\/g;
    
    print "DEBUG>> old path: $old_path \n" if ($CONFIG->{'DEBUG'} > 1);
    print "DEBUG>> new path: $path \n" if ($CONFIG->{'DEBUG'} > 1);
    
    # Change into the directory that our PsTools scripts exist
    chdir("$path") || die "Cannot chdir to: $path ($!)";
    
    my $current_path = cwd;
    $current_path =~ s/\//\\/g;
    
    print "DEBUG>> current path: $current_path \n" if ($CONFIG->{'DEBUG'} > 1);
    
    # NOTE: Using the backtick operator captures the output instead of printing it to the screen
    my @output = `$command`;
    my $rv = join("", @output);
    
    print "DEBUG>> process data: [$rv] \n" if ($CONFIG->{'DEBUG'} > 1);
    
    # Change back to old path when we finish, so relative paths continue to make sense
    chdir($old_path);
    
    # Parse our output for any mtrun.exe processes that are still alive
    splice(@output, 0, 6);
    foreach my $line (@output) {
        $line =~ s/^\s+//g;
        $line =~ s/\s+$//g;
        next unless ($line =~ m/\W+/g);
        my @proc = split(/\s+/,$line);
        my $process_name = $proc[0];
        my $pid = $proc[1];
        push(@PIDS,$pid) if ($process_name =~ m/mtrun/i);
        
        print "DEBUG>> process name = [$process_name] \n" if ($CONFIG->{'DEBUG'} > 1);
        print "DEBUG>> pid = [$pid] \n" if ($CONFIG->{'DEBUG'} > 1);
    }
    
    return (\@PIDS);
}

#
# killProcesses() - Kill any runaway Visual Test processes
# Input:  $PIDS - Array reference containing a list of all runaway Visual Test pid's
# Output: Nothing
sub killProcesses {
    my($PIDS) = shift;
    
    # Define the following
    my $path    = $ORBITAL_PATH."Utility\\";    # Path/directory of our PsTools utilities
    my $command = "pskill.exe -t";              # Let's kill any runaway Visual Test process
    
    # Make sure we remember where we are
    use Cwd;
    my $old_path = cwd;
    $old_path =~ s/\//\\/g;
    
    print "DEBUG>> old path: $old_path \n" if ($CONFIG->{'DEBUG'} > 1);
    print "DEBUG>> new path: $path \n" if ($CONFIG->{'DEBUG'} > 1);
    
    # Change into the directory that our PsTools scripts exist
    chdir("$path") || die "Cannot chdir to: $path ($!)";
    
    my $current_path = cwd;
    $current_path =~ s/\//\\/g;
    
    print "DEBUG>> current path: $current_path \n" if ($CONFIG->{'DEBUG'} > 1);
    
    foreach my $process (@$PIDS) {
        # NOTE: Using the backtick operator captures the output instead of printing it to the screen
        my @output = `$command $process`;
        my $rv = join("", @output);
        $rv =~ s/^\s+//g;
        $rv =~ s/\s+$//g;
        print "DEBUG>> kill process: [$rv] \n" if ($CONFIG->{'DEBUG'} > 0);
    }
    
    # Change back to old path when we finish, so relative paths continue to make sense
    chdir($old_path);
}

#
# closeShares() - Closes any open shares on the local machine
# Input:  Nothing
# Output: Standard output from the command
sub closeShares {
    # Close any 'shares' that currently exist
    my $command = "net use * /delete /y";
    my @output = `$command`;
    my $rv = join("", @output);
    $rv =~ s/^\s+//g;
    $rv =~ s/\s+$//g;
    print "DEBUG>> closed shares: [$rv] \n" if ($CONFIG->{'DEBUG'} > 1);
    
    return $rv;
}


1;

__END__


