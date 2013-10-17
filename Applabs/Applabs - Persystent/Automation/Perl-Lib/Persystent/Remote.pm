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

use lib "C:\\persystent\\Automation\\Perl-Lib\\";
use Win32;
use strict;
use Data::Dumper;


# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# getTimestamp() - Generate a unix timestamp and return it
# Input:  Nothing
# Output: String containing unix timestamp
sub getTimestamp {
    my $timestamp = time();
    return $timestamp;
}



1;

__END__
