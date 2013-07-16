#!/usr/bin/perl -w

# Copyright (C) 2010 McAfee, Inc. All rights reserved.

use strict;

my $file1 = $ARGV[0];
my $file2 = $ARGV[1];

my $rh_file1 = read_file($file1);
my $rh_file2 = read_file($file2);
my ($ra_not_found_in1, $ra_not_found_in2, $rh_perm_differ) = compare($rh_file1, $rh_file2);

open(my $rfh, "> bomcompare.txt");

print $rfh "NOT FOUND IN $file1\n";
print "NOT FOUND IN $file1\n";
foreach my $nf1 (@$ra_not_found_in1) {
    print $rfh "$nf1\n"; print "$nf1\n";
}

print $rfh "NOT FOUND IN $file2\n";
print "NOT FOUND IN $file2\n";
foreach my $nf2 (@$ra_not_found_in2) {
    print $rfh "$nf2\n"; print "$nf2\n";
}

print $rfh "DIFFERENCES IN FILE PERMISSIONS\n";
print "DIFFERENCES IN FILE PERMISSIONS\n";
print $rfh "Name\t $file1\t $file2\n";
print "Name\t $file1\t $file2\n";
foreach my $key (keys %$rh_perm_differ) {
    print $rfh "$key\t",$rh_perm_differ->{$key}->[0],"\t",$rh_perm_differ->{$key}->[1],"\n";
}
close $rfh;
sub compare {
    my ($rh_file1, $rh_file2) = @_;
    my $ra_not_found_in1 = [];
    my $ra_not_found_in2 = [];
    my $rh_perm_differ   = {};

    foreach my $key (keys %$rh_file1) {
        if ($rh_file2->{$key} ){
            if($rh_file2->{$key}->{'perm'} ne $rh_file1->{$key}->{'perm'}) {
                $rh_perm_differ->{$key} = [$rh_file1->{$key}->{'perm'},
                        $rh_file2->{$key}->{'perm'} ];
            }
            delete $rh_file2->{$key};
        } else {
            push @$ra_not_found_in2, $key;
        }
        delete $rh_file1->{$key};
    }

    foreach my $key (keys %$rh_file2) {
        push @$ra_not_found_in1, $key;
    }
    return ($ra_not_found_in1, $ra_not_found_in2, $rh_perm_differ);
}

sub read_file {
    my ($file) = @_;
    open(my $fh, $file);
    my @fc = <$fh>; chomp @fc;
    my $rh_file = {};
    foreach my $line (@fc) {
        my ($file, $perm, $uid, $gid, $size) = split(':', $line);
        $size = 0 unless defined $size;
        $rh_file->{$file} = {'perm' => $perm, 'size' => $size };
    }
    close $fh;
    return $rh_file;
}
