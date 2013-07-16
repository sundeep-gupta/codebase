# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 436 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dKaA.al)"
sub dKaA{
	my ($f) = @_;
 	$f =~ s|([^a-zA-Z0-9\-\.])|sprintf '%%%.2X' => ord $1|eg;

}

# end of jW::dKaA
1;
