# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 5472 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/yEz.al)"
sub yEz {
 $iS->cR();
 $iS->bI();
 my $kQz = $abmain::gJ{kQz};
 my @jS = abmain::oCa(\@abmain::del_conf_cfgs);
 push @jS, ["gJz", "hidden"];
 $iS->{gJz} = $kQz;
 $jS[0][2]="Please confirm the deletion of user: <b>$kQz</b>";
 push @jS, ["hIa", "hidden", "", "", "", "1"];
 $iS->jI(\@jS, "cQ", "");
}

# end of abmain::yEz
1;
