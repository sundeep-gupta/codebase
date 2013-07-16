# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 5399 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/xOz.al)"
sub xOz {
 $iS->cR();
 $iS->bI();
 if($abmain::gJ{qQz}) {
 my $pp = $iS->qZz($abmain::gJ{qQz});
 $iS->cJ($pp, \@abmain::qSz) if -f $pp;
 }
 $iS->jI(\@abmain::qSz, "rCz", "Add or modify poll", 0);
}

# end of abmain::xOz
1;
