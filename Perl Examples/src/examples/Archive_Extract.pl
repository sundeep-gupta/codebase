#!/usr/bin/perl
use strict;
use Archive::Extract;
my $ae = Archive::Extract->new('archive' => '/Users/bubble/workspace/DSTReportsReceiver/test_files/sample.gzip', 'type' => 'gz');
unless($ae) {
    print "Failed to create object\n";
}
$ae->extract('to' => '/Users/bubble/workspace/DSTReportsReceiver/test_files/gzipDecompress');

