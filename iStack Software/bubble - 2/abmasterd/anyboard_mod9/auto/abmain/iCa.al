# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 4671 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/iCa.al)"
sub iCa{
 if(not -e $abmain::oG){
 	  $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 	  abmain::iUz();
	}
	abmain::error("dM", "Wrong login or password") if(not eVa()) ;
	my $mf = new aLa('idx', \@abmain::iBa, $jT);
	$mf->zOz();
	$mf->{fix_top_url} = $dJz;
	$mf->load(abmain::wTz('leadcfg'));
	$mf->sRa('pvhtml', 1);
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 	print sVa::tWa();
	$mf->sRa('pvhtml', 1);
 print $mf->form();
 print "</body></html>";
}

# end of abmain::iCa
1;
