#!/usr/bin/perl

use strict;
my $file ='/usr/local/McAfee/fmp/config/traceValues.xml';
print "Waiting till I see FMP's config files";
while ( not -e $file) {}

print "File found, now enabling all tracevalues with a crude way of doing\n";
open (FH, $file);
my @content = <FH>;
close FH;
my $content = join('', @content);
print @content;
$content =~ s/>0</>5</gs;
open( FH, "> $file");
print FH $content;
close FH;
print $content;

print `/usr/local/McAfee/fmp/bin/fmp reload`;
