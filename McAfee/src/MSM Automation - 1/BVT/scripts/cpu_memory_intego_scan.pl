# Copyright (c) 2010, McAfee Inc.  All rights reserved.
#!/usr/bin/perl -w

# Begin Block
BEGIN {
     use Cwd 'abs_path';
     my $abs_path = abs_path($0);
	 $abs_path =~ s/(.*)\/.*$/$1/;
	 chdir $abs_path;
	 unshift @INC, "$abs_path/../include";
	unshift @INC, "../include";
	use lib '../include';
    
	use Util;
	use strict;
	use MSMConst;
	use Security::Competitor::Intego;
}
use Resource::CPUMemory;
my $abs_path = abs_path($0);
$abs_path =~ s/(.*)\/.*$/$1/;
my $prod = Security::Competitor::Intego->new();
print "Log File is $abs_path/../\n";
my $cpu = Resource::CPUMemory->new("$LOG_DIR/cpu_memory_intego_scan.log",
									$prod->{'process'});

while (1) { $cpu->get(); sleep 30; }
