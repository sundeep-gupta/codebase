# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5187 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/rOz.al)"
sub rOz {
 my ($w, $h, $c) = @_;
 return "" if $w == 0 || $h == 0;
 return qq(<table border="0" cellspacing=0 cellpadding=0 width="$w" height="$h" bgcolor="$c" class="ProportionBlock"><tr><td>\&nbsp;</td></tr></table>);
}

# end of jW::rOz
1;
