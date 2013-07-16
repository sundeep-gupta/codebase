#!/usr/bin/perl -w
use strict;
my $file = $ARGV[0];
use Data::Dumper;
die "error" unless $ARGV[0] and -e $ARGV[0];

open (my $fh, $file);

my @content = <$fh>;

close $fh;

my $ra_process = [ 'Sym', 'Norton', 'CCache' ];

    my $rh_sum = { 'cpu' => 0, 'rshrd' => 0, 'vsize' => 0, 'rsize' => 0 };
my $total_runs = grep { $_ =~ /Processes/ ; } @content;
foreach my $process (@$ra_process) {
    my @grepped_lines = grep {$_ =~ /$process/ } @content;
	foreach my $line (@grepped_lines) {
		my ($cpu, $rsize, $vsize, $rshrd) = (split(' ', $line))[0,1,2,3];
		  $cpu =~ s/^\s*//; $rsize =~ s/^\s*//; $vsize =~ s/^\s*//; $rsize =~ s/^\s*//;
		  print "$cpu\n" unless $cpu;
		  if( $rsize =~ /(\d+)(\w)\+$/) {
		      $rsize = $1 *1024;
		 	  $rsize *= 1024 if $2 eq 'M';
	    	}  
		  if( $vsize =~ /(\d+)(\w)\+$/) {
		      $vsize = $1 * 1024;
		      $vsize *= 1024 if $2 eq 'M';
		  }

		if( $rshrd =~ /(\d+)(\w)\+$/) {
		    $rshrd = $1 *1024;
		    $rshrd *= 1024 if $2 eq 'M';
		}
        
		$rh_sum->{'cpu'}   += $cpu;
		$rh_sum->{'vsize'} += $vsize;
		$rh_sum->{'rshrd'} += $rshrd;
		$rh_sum->{'rsize'} += $rsize;

		
	}
}

my $rh_avg = {};

foreach my $key ( keys %$rh_sum ) {
	$rh_avg->{$key} = $rh_sum->{$key} / $total_runs;
}
print Dumper($rh_avg);
