#!/usr/bin/perl -w
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.16 $
# Last Modified: $Date: 2005/06/23 23:34:36 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbital/control/cgi-lib/receiver.pl,v $
#
####################################################################################
##
##
use lib "..\\perl-lib\\";
use strict;
use CGI qw(:standard :nodebug);
use Orbital::Receiver;
use Getopt::Long;


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

close(STDOUT);     # The child lives on, but disconnects
                   # from the local terminal

# -----------------------------------------------------------
# Now we enter a never-ending listen loop
#
LISTEN: {
    daemon_listener($server);
    
    redo LISTEN;
}


__END__
