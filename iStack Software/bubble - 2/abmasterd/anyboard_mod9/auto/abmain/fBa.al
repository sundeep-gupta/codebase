# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 4326 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/fBa.al)"
sub fBa {
 	if(not -e $abmain::oG){
 	      $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 	      abmain::iUz();
	}
	my $mf = new aLa('mlogin', \@abmain::root_login_cfgs, $jT);
	sVa::gYaA "Content-type: text/html\n\n";
	if(eVa()){
 		abmain::bOaA();
		return;
 }
 my ($h, $f) = abmain::nOa();
 print $h;
	$mf->setWidth('80%');
 print $mf->form();
 print $f;
	abmain::iUz();
}

# end of abmain::fBa
1;
