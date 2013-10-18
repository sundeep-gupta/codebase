#!/usr/bin/perl -w


use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
new CGI;

print header;

my $src = param("src") if defined(param("src"));
my $dst = param("dst") if defined(param("dst"));
	
if(defined($src) && defined($dst))
{    	
	my $command = "/usr/local/bin/sudo /usr/local/sbin/tcpkillx -i em0 -n 1 \'tcp and src $src and dst $dst and (dst port 445 or dst port 139)\'";

	print "<p>Executing: $command</p>";
	system($command);
}


