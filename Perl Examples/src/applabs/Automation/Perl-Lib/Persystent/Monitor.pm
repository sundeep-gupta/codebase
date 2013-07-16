#!/usr/bin/perl -w
#
# Copyright:     AppLabs Technologies / Persystent Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision:  $
# Last Modified: $Date:  $
# Modified By:   $Author:  $
# Source:        $Source:  $
#
####################################################################################
##
##


package Monitor;

use lib "C:\\persystent\\Automation\\Perl-Lib\\";
use vars qw($PROC_WATCH_LIST);
use Persystent::Config;
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

my $PROC_WATCH_LIST = (
    "PtcServerSrv.exe",            # Persystent Server (service)
    "Rembo.exe",                   # Persystent Rembo Server (service)
    "rbagent.exe",                 # Persystent Rembo Agent (service)
    "dbgw.exe",                    # Persystent Rembo ODBC (service)
    "sqlservr.exe",
    "iexplore.exe"
);


# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input:  None
# Output: Object for performance monitoring
sub new {
    
    my $MONITOR = {
        "PROC_WATCH_LIST" => $PROC_WATCH_LIST,      # Default list of processes to watch for
    };
    
    bless $MONITOR, 'Monitor';   # Tag object with pkg name
    return $MONITOR;
}


1;

__END__
