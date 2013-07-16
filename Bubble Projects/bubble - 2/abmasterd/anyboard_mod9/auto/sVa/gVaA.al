# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 433 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/gVaA.al)"
sub gVaA{
	my ($url, $raw) = @_;
	if($raw || $ENV{raw_redir}) {
		print "HTTP/1.0 301 Moved Permanently\n";
	}
	print "Location: $url\n\n";
}

# end of sVa::gVaA
1;
