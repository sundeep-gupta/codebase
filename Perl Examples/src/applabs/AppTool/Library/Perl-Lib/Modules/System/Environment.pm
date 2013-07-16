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

#
# NOTE:  We need to define the location of our Perl library within a centralized area.
#        This will allow us to pre-load all the necessary modules prior to code 
#        execution. Also this prevents any hard-coded paths or directories.
#

use strict;

BEGIN {
    $_ = ($^O =~ /MSWin32/) ? "C:/AppLabs/AppTool/Library/Perl-Lib" : "/opt/AppLabs/AppTool/Library/Perl-Lib/";
    push @INC, $_;
} 


# DEBUG
#print "Modules Loaded:\n";
#print map {"$_ => $INC{$_}\n"} keys %INC;
#print "\@INC Paths Defined:\n";
#print join "\n", @INC;


1;

__END__
