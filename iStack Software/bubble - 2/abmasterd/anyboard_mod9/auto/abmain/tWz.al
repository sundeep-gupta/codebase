# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 6160 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/tWz.al)"
sub tWz {
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->{_admin_only}=1 if not $iS->{uIz};
 $iS->{gAz}=1 if $iS->{uSz};
 $iS->tGz();  
 my $eveform = aLa->new("eve", \@abmain::uHz);
 $eveform->zNz([cmd=>"hidden"]);
 $eveform->dNa('cmd', "tZz");
 $iS->dNaA($eveform);
}

# end of abmain::tWz
1;
