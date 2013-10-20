# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 4689 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/lUa.al)"
sub lUa{
 if(not -e $abmain::oG){
 	  $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 	  abmain::iUz();
	}
	abmain::error("dM", "Wrong login or password") if(not eVa()) ;
 my $id = $abmain::gJ{id};
	my $mf = new aLa('idx', \@abmain::gDa, $jT);
	$mf->zOz();
	$mf->{fix_top_url} = $dJz;
	$mf->sRa('pvhtml', 1);
 if($id) {
		my $bf = abmain::wTz('bannerfile');
 	my $uNa = new hDa($bf);
		$mf->dNa("banner_id", $id);
		$uNa->kHa($id, $mf);
	}
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 	print sVa::tWa();
 print $mf->form();
 print "</body></html>";
}

# end of abmain::lUa
1;
