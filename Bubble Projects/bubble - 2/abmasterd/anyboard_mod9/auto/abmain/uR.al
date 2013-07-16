# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 6674 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/uR.al)"
sub uR{
 $iS->cR();
 $iS->lI();
 $iS->iMz($iS->{admin}, $iS->{eF}->{mS}, $iS->{admin_email}, 1);
 $iS->hL();
 sVa::hCaA "Location: ", $iS->{cgi_full}, "?@{[$abmain::cZa]}cmd=log", "\n\n";
}

# end of abmain::uR
1;
