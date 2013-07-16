#!/usr/bin/perl

use strict;
use File::Find;

my $dir = $ARGV[0];
my $stat_counter_code = "\n" . '<!-- Start of StatCounter Code -->' . "\n" .
'<script type="text/javascript">' . "\n" .
'    var sc_project=6021735; ' . "\n" .
'    var sc_invisible=1; ' . "\n" .
'    var sc_security="c9d4cb5f"; ' . "\n" .
'</script>' . "\n" .

'<script type="text/javascript" src="http://www.statcounter.com/counter/counter.js">' . "\n" .
'</script>' . "\n" .
'<noscript>' . "\n" .
'<div class="statcounter">' . "\n" .
'    <a title="hits counter" href="http://www.statcounter.com/free_hit_counter.html" ' . "\n" .
'       target="_blank">' . "\n" .
'        <img class="statcounter" src="http://c.statcounter.com/6021735/0/c9d4cb5f/1/"' . "\n" .
'             alt="hits counter">' . "\n" .
'    </a>' . "\n" .
'</div>' . "\n" .
'</noscript>' . "\n" .
'<!-- End of StatCounter Code -->' . "\n" ;
&File::Find::find({ no_chdir => 1, wanted => sub {
    my $file = $File::Find::name;
    if ($file =~ /\.html$/) {
        open(my $fh, $file);
        my @contents = <$fh>;
        close $fh;
        
        my $data = join('', @contents);
        $data =~ s/<body>/<body>$stat_counter_code/;
        
        open (my $fh, ">$file");
        print $fh $data;
        close($fh);
    }

}}, $dir);
