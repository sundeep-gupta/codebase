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

BEGIN {
    push @INC, "C:\\AppLabs\\AppTool\\Library\\Perl-Lib";
    push @INC, "C:\\AppLabs\\AppTool\\Library\\Perl-Lib\\Modules";
} 

use Modules::Config;
use Modules::Logger;
use Modules::Agent;
use Getopt::Long;
use CGI qw(:standard :nodebug);
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# Daemonize:  fork, and then detatch from the local shell
#

# Allow specification of port
my $port;
GetOptions( "p:i" => \$port );

my $server = start_daemon($port);

my $pid = fork;
defined $pid or die "Cannot fork daemon: $!";

if ($pid) {        # The parent exits
    print redirect($server->url);
    exit 0;
}

close(STDOUT);     # The child lives on, but disconnects from the local terminal


# -----------------------------------------------------------
# We create our own interrupt handler so we exit gracefully
#

sub INT_handler {
    # Send error message to log file
    my $timestamp = time();
    print "[$timestamp]: Agent process is stopping....\n";
    logEvent("[$timestamp]: Agent process is stopping.");
    exit(0);
}

$SIG{'INT'} = 'INT_handler';


# -----------------------------------------------------------
# Now we enter a never-ending listen loop
#
LISTEN: {
    daemon_listener($server);

    redo LISTEN;
}


__END__
