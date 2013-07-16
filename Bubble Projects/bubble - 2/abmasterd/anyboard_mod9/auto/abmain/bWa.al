# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 7933 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/bWa.al)"
sub bWa {
 my $str;
 my @gHz;
 push @gHz,   qq(<table bgcolor="#666666" cellspacing=0 cellpadding=0 border="0"><tr><td>);
 my $ta = qq(cellspacing=1 cellpadding=3 border="0");
 push @gHz,  &jW::nNa($ta, "E-Mail", "Status");
 my $i =0;
 for(keys %mail_status) {
 push @gHz, jW::nKz($abmain::bgs[$i++%2], "$_", "$mail_status{$_}");
 }
 push @gHz, "</table></td></tr></table>";
 return join("", @gHz);
}

# end of abmain::bWa
1;
