#!/usr/bin/env perl
use strict;
use Bubble::FileUtils;

my $rh_report = Bubble::FileUtils::folder_diff({'dir1' => $ARGV[0], 
        'dir2' => $ARGV[1]} );

Bubble::FileUtils::print_report($rh_report, {'dir1' => $ARGV[0], 'dir2' => $ARGV[1]});
