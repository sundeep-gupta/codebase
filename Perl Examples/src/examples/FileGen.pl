use strict;
use Getopt::Std ;
use Carp;

our($opt_f,$opt_s,$opt_r,$opt_n,$opt_R);
getopts("n:f:s:R:r");
($opt_f) || croak("Invalid Usage: Missing file name\n\t\tUse perldoc to see usage\n");
($opt_s) || croak("Invalid Usage: Size of the file not specified\n\t\tUse perldoc to see usage\n");
my $fileName = $opt_f;
my $size = $opt_s;
my $count = $opt_n || 1;
my $chunk;
my $RATIO = $opt_R;
syswrite(\*STDOUT,$RATIO);

for(my $iter = 1;$iter<=$count;$iter++) {
open(FHOUT,">$fileName$iter".".dat") || die "Unable to create file\n";

for(my $i = 0;$i<$size/1000;$i++) {
    if ($opt_r) {
    	if ($opt_R) {
	         for (my $j = 0;$j<1000;$j++) {
	               $chunk = $chunk.chr(int(rand($RATIO)));
	        }
        } else {
        	for (my $j = 0; $j<1000; $j++) {
            	$chunk = $chunk.chr(int(rand(255)));
            }
        }
    } else {
        $chunk = chr(0)x 1000;
    }
print FHOUT "$chunk";
$chunk = '';
}
if ($opt_r) {
    if ($opt_R) {
         for (my $j = 0;$j<1000;$j++) {
               $chunk = $chunk. chr(int(rand($RATIO)));
        }
    } else {
        for (my $j = 0; $j<1000; $j++) {
            $chunk = $chunk. chr(int(rand(255)));
        }
    }
} else {
     $chunk = chr(0)x ( $size%1000);
}
syswrite(\*FHOUT, $chunk);
close(FHOUT);
}