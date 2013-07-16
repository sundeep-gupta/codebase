# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 5986 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/wEz.al)"
sub wEz {
 $iS->cR() if -f $iS->nCa();
 if($iS->{aXa}) {
	$iS->{tHa}=0;
	$iS->{gAz}=0;
 }else {
 	$iS->{tHa} = 1;
 }
 $iS->tGz();
 my $url = $abmain::gJ{url};
 my $wW = $abmain::gJ{wW};
 $iS->{re_subject} = $wW;
 abmain::error("deny", "Recommendation feature disabled") if $iS->{tellcnt} <=0;
 my @jS = abmain::oCa(\@abmain::hPa);
 push @jS, ["url", "hidden", undef, undef, undef, $url]; 
 push @jS, ["wW", "hidden", undef, undef, undef, $wW]; 
 $iS->jI(\@jS, "recommend", "");
}

# end of abmain::wEz
1;
