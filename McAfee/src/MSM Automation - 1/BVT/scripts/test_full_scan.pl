# Copyright (c) 2010, McAfee Inc.  All rights reserved.
use strict;
use File::Find;
my $ra_volumes = [ '/Volumes/' ];
my $counter = 0;
my $eicar_code = 'ZQZXJVBVT';
my $fh;
foreach my $dir ( @$ra_volumes ) {
&File::Find::find( { 
 #   'wanted' => sub {},
	'wanted' => sub {
        if ( -d $File::Find::name and -w $File::Find::name and 
		     not -e $File::Find::name."/eicar.$counter") {
	    # Create a eicar sample file in each directory
                open ($fh, ">". $File::Find::name."/eicar.$counter");
				syswrite( $fh, $eicar_code);
				close $fh;
				$counter++;
		}	else {
	        print "Not writing into ${File::Find::name}\n" if -d $File::Find::name and not -w $File::Find::name;
		}
	}, }, $dir );
}
print "$counter samples written\n";
