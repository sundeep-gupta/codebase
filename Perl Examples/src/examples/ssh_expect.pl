#!/usr/bin/perl
use strict;
use Net::SSH::Expect;

my $ssh = Net::SSH::Expect->new (
            host => "ap6414isd.us.oracle.com", 
            user => 'skgupta', 
            password => 'ARS!jr12',
            raw_pty => 1,
            timeout => 100
        );
print $ssh->login();
