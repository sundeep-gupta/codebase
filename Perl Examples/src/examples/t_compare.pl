use strict;
open(FH,'compare.csv');
my @demo = ();
my @main = ();
foreach my $line(<FH>) {
	push(@demo,(split(',',$line))[0]);
        push(@main,(split(',',$line))[1]);
#        print $demo[$#demo],"\t",$main[$#main],"\n";
}
my @not_in_demo;
my @not_in_main;
foreach my $d (@demo) {
     push(@not_in_main,$d) unless exists($main[$d]);
}

foreach my $m (@main) {
     push(@not_in_demo,$m) unless exists($demo[$m]);
}

$" = "\t";
print "\nNOT IN DEMO\n";
print "@not_in_demo";
print "\nNOT IN MAIN\n";
print "@not_in_main";
close(FH);