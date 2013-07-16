# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 7602 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/fP.al)"
sub fP {
 $iS->cR();
 if($abmain::gJ{attachfid} ne "") {
	$iS->{tHa} =1;
 }

 $iS->gCz();
 if($iS->{gL} eq "1" || $iS->{gL} eq 'true') {
 	abmain::error('deny', "Followup function is turned off for this forum");
 }
 abmain::error('inval', "Maximum number of attachment files is limited")
	if($abmain::gJ{upldcnt} > $iS->{max_extra_uploads} ); 
 if($iS->{rL}) {
 	$iS->aFz($abmain::gJ{zu}, undef, 1);
 my @arr = split /\t/, $iS->{ratings2}->{$abmain::gJ{zu}};
	abmain::error("inval", "Thread closed") if $abmain::gJ{zu} > 0 && $arr[3] & 2;
 }
 
 if($abmain::gJ{attachfid} ne "") {
	$iS->{xL} =0;
	$iS->{xA} =0;
	$iS->{take_file} =0;
	$iS->{pform_rows} = 4;
 }
 $iS->{gPa} = $abmain::gJ{scat};
 my $ph= $iS->gU($abmain::gJ{zu}, $abmain::gJ{fu}, $abmain::gJ{upldcnt}, $abmain::gJ{kQz}, $abmain::gJ{attachfid});
 sVa::gYaA "Content-type: text/html\n";
 print abmain::bC($abmain::cH, abmain::nXa($iS->{fTz}->{name}), '/', abmain::dU('pJ',24*3600*128));
 print "\n";
 print $ph;
 
}

# end of abmain::fP
1;
