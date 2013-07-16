use strict;
use Getopt::Std ;
use Carp;

our($opt_f,$opt_s,$opt_r,$opt_n);
getopts("n:s:r");

($opt_s) || croak("Invalid Usage: Size of the file not specified\n\t\tUse perldoc to see usage\n");

my $fileName = 'abcdefghijklmnopqrstuvwxyz'x 7;
$fileName = $fileName.'abcdefghijklmnopqrstuvwx-'     ;
my $size = $opt_s;
my $count = $opt_n || 1;
my $chunk;
for(my $iter = 1;$iter<=$count;$iter++) {
open(FHOUT,">$fileName$iter".".dat") || die "Unable to create file\n";
for(my $i = 0;$i<$size/1000;$i++) {
    if ($opt_r) {
         for (my $j = 0;$j<1000;$j++) {
               $chunk = $chunk.chr(int(rand(255)));
        }
    } else {
        $chunk = chr(0)x 1000;
    }
print FHOUT "$chunk";
$chunk = '';
}
if ($opt_r) {
     for (my $j = 0;$j<$size%1000;$j++) {
           $chunk = $chunk.chr(int(rand(255)));
     }
 } else {
     $chunk = chr(0)x $size%1000;
}
print FHOUT "$chunk";
close(FHOUT);
}