#!/usr/bin/perl

use strict;
use File::Find;

my $dir = $ARGV[0];

&File::Find::find({ no_chdir => 1, wanted => sub {
    my $file = $File::Find::name;
    if ($file =~ /\.html$/) {
        open(my $fh, $file);
        my @contents = <$fh>;
        close $fh;
        my $data = join('', @contents);
        $data =~ s/pub-\d{16}/pub-7489626597901170/g;
        
        open (my $fh, ">$file");
        print $fh $data;
        close($fh);
    }
}}, $dir);
