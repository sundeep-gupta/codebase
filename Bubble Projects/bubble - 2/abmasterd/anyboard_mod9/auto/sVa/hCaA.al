# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 441 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/hCaA.al)"
sub hCaA(@){
	if($ENV{raw_redir}) {
		print "HTTP/1.0 301 Moved Permanently\n";
	}
	if($ENV{http_10_close}) {
		print "Connection: close\n";
	}
	print @_;
}

# end of sVa::hCaA
1;
