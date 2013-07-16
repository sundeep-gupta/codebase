#!/usr/bin/perl

use strict;
$ARGV[0] or die "File name must be provided\n";
my $file = $ARGV[0];
-f $file or die "File $file does not exist\n";

open(my $fh, $file);
my @lines = <$fh>;
close($fh);
my $rh_process = {
    'scanner' => {},
    'nailsd' => {},
    'nailslogd' =>{},



};
for my $line (@lines) {
    if ($line =~ /^(\d+)\s+(\S+)\s+(\d+\.?\d+)%\s+(\d+\.?\d+?)\s+MB\s+(\d+\.?\d+?)\s+MB\s+(\d+\.?\d+?)\s+MB\s+(\d+\.?\d+?)\s+MB\s+(\d+\.?\d+?)\s+MB/) {
        unless ($rh_process->{$2}) {
            $rh_process->{$2} = { 'pid' => {}, 
                                  'cpu' => 0,
                                  'mem1' => 0,
                                  'mem2' => 0,
                                  'mem3' => 0,
                                  'mem4' => 0,
                                  'mem5' => 0,
                                  'count' => 0
                                  };
        }
        $rh_process->{$2}->{'pid'}->{$1} = 1;
        $rh_process->{$2}->{'cpu'} = $rh_process->{$2}->{'cpu'} + $3;
        $rh_process->{$2}->{'mem1'} = $rh_process->{$2}->{'mem1'} + $4;
        $rh_process->{$2}->{'mem2'} = $rh_process->{$2}->{'mem2'} + $5;
        $rh_process->{$2}->{'mem3'} = $rh_process->{$2}->{'mem3'} + $6;
        $rh_process->{$2}->{'mem4'} = $rh_process->{$2}->{'mem4'} + $7;
        $rh_process->{$2}->{'mem5'} = $rh_process->{$2}->{'mem5'} + $8;
        $rh_process->{$2}->{'count'} = $rh_process->{$2}->{'count'} + 1;
    }
}
foreach my $key (keys %$rh_process) {
    next if $rh_process->{$key}->{'count'} == 0;
        $rh_process->{$key}->{'cpu'} = $rh_process->{$key}->{'cpu'} / $rh_process->{$key}->{'count'};
        $rh_process->{$key}->{'mem1'} = $rh_process->{$key}->{'mem1'} / $rh_process->{$key}->{'count'};
        $rh_process->{$key}->{'mem2'} = $rh_process->{$key}->{'mem2'} / $rh_process->{$key}->{'count'};
        $rh_process->{$key}->{'mem3'} = $rh_process->{$key}->{'mem3'} / $rh_process->{$key}->{'count'};
        $rh_process->{$key}->{'mem4'} = $rh_process->{$key}->{'mem4'} / $rh_process->{$key}->{'count'};
        $rh_process->{$key}->{'mem5'} = $rh_process->{$key}->{'mem5'} / $rh_process->{$key}->{'count'};
        
        print $key ,", ";
        print $rh_process->{$key}->{'cpu'} ,", ";;
        print $rh_process->{$key}->{'mem1'} ,", ";;
        print $rh_process->{$key}->{'mem2'} ,", ";;
        print $rh_process->{$key}->{'mem3'} ,", ";;
        print $rh_process->{$key}->{'mem4'} ,", ";;
        print $rh_process->{$key}->{'mem5'} , "\n";


}
