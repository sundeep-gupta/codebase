# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2633 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/oTa.al)"
sub oTa{
 my ($arrref, $val) = @_;
 my $pos;
 for($pos=0; ; $pos++) {
	return $pos if $arrref->[$pos] eq $val;
 }
 return -1;
}

# end of abmain::oTa
1;
