# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dDa;

#line 31 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dDa/eVaA.al)"
sub eVaA{
	my ($d, $u) =@_;
	open F, ">>/tmp/blog";
	print F time(), "\n-------------===========================\n$u\n";
	print F $d;
	close F;
}

# end of dDa::eVaA
1;
