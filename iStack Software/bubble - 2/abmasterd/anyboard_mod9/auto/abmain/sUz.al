# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 4278 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/sUz.al)"
sub sUz {
 $iS->cR(undef, 1);
 $iS->{tHa} = 1;
 $iS->tGz();
 $iS->sEz($abmain::gJ{reload}?"":$iS->{fTz}->{name}, $abmain::gJ{sIz}, 0, $abmain::gJ{mood});
 sVa::hCaA "Location:", $iS->sPz(), "\n\n";
 $iS->fSa($iS->{fTz}->{name}, "Chat");
}

# end of abmain::sUz
1;
