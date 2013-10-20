# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 5920 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/oT.al)"
sub oT {
 $iS->cR();
 my @jS = abmain::oCa(\@abmain::tM);
 if(not $iS->{allow_body_search}) {
 $jS[3]->[1]="fixed";
 }
 my $scat_line;
 if($iS->{allow_subcat} && $iS->{catopt}=~ /=/ ) {
	my $selmak;
	$selmak = aLa::bYa(['scat', $iS->{scat_use_radio}?'radio':'select',  join("\n", $iS->{catopt}, $iS->{hBa})]);
 my $sels = $selmak->aYa();
	$jS[2] = ['notused', 'const', '', "Message category", "", $sels];
 }else {
	$jS[2]->[1]= 'fixed';
 }

 $iS->{xWz} = 'GET';
 if($abmain::gJ{gV}) {
 $jS[3]->[0]= undef;
 $jS[5]->[5]= qq(From <input type="text" size="4" name="hIz" value="365"> days ago, to <input type="text" size="4" name="hJz" value="0"> days ago.);
 $iS->jI(\@jS, "finda", "Search for messages in archive");
 } else {
 $iS->jI(\@jS, "find", "Search for messages");
 }
}

# end of abmain::oT
1;
