#!/usr/bin/perl

use CGI::Carp qw(fatalsToBrowser);
use CGI ':standard';
use GD::Graph::lines;
use strict;

# Both the arrays should same number of entries.
my @data = (['v1', 'v2','v3','v4','v5'],
[30.5, 31, 31.04, 30.75, 33.01],
[29.5, 30.25, 30.25, 30.2, 30.75 ]);

my $mygraph = GD::Graph::lines->new(600, 300);
$mygraph->set(
x_label => 'X Axis',
y_label => 'Y Axis',
title => 'Chart Title',

y_tick_number => 5,
y_min_value => 29,
y_max_value => 34,
x_label_skip => 2,
long_ticks => 1,

# Draw datasets in 'solid', 'dashed' and 'dotted-dashed' lines
line_types => [1, 1],

# Set the thickness of line
line_width => 1,

# Set colors for datasets
dclrs => ['blue', 'red'],
) or warn $mygraph->error;


$mygraph->set_legend_font(GD::gdMediumBoldFont);
$mygraph->set_legend('Line Type 1', 'Line Type 2');

my $myimage = $mygraph->plot(\@data) or die $mygraph->error;

print "Context-type: image/png\n\n";
print $myimage->png;
