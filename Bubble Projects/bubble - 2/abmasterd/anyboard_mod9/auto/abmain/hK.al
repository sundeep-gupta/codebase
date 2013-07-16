# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 6368 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/hK.al)"
sub hK {
 $iS->cR();
 $iS->{aGz}=1;
 $iS->aQz();
 $iS->{hEz}=0;
 $iS->{iWz} = 0;
 $iS->yIz(\%abmain::gJ, qw(max_match_count iW yVz 
 hG aO mJ mAz 
					  lVz rP revlist_topic 
					  revlist_reply hEz));
 if($iS->{force_login_4read}) {
 $iS->gCz();
 $iS->fSa($iS->{fTz}->{name}||$abmain::ab_id0||"???", "Search");
 }
 $iS->{collapse_age}=0;
 $iS->kV($abmain::gJ{tK}, $abmain::gJ{gV}, $abmain::gJ{wT}, 
			$abmain::gJ{hKz}, $abmain::gJ{hIz}, $abmain::gJ{hJz}, 0, $abmain::gJ{scat});
}

# end of abmain::hK
1;
