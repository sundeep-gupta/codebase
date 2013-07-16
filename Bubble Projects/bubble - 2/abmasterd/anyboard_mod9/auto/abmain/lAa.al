# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 4832 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/lAa.al)"
sub lAa{
	my $mf = new aLa('licentry', \@abmain::lFa, $jT);
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body><center>";
	print $abmain::lGa, "[".$abmain::lEa[1]."]</center>";
 print $mf->form();
	if(not eVa()) {
		my $l = sVa::cUz("$lGa?cmd=admin", "please login first");
		print "<p><center>You are not logged in, $l . </center>"; 
 }
 print "</body></html>";
}

# end of abmain::lAa
1;
