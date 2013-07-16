# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 4643 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/fDa.al)"
sub fDa{
 if(not -e $abmain::oG){
 	  $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 	  abmain::iUz();
	}
	if(not eVa()) {
		fBa();
 	  	abmain::iUz();
 }
	my $mf = new aLa('idx', \@abmain::fix_cfgs, $jT);
	my @dbs;
 if($abmain::gJ{dbchk}) {
	  eval {
		require zKa;
		my $dbi_hash= zKa::getDataSources();
		@dbs = keys %$dbi_hash;
	  };
 }
	$mf->zOz();
	$mf->load(abmain::wTz('fixcfg'));
	$mf->dNa('fix_top_url', $dJz) if not $mf->{fix_top_url};
	$mf->dNa('fix_cgi_url', $lGa) if not $mf->{fix_top_dir};
	$mf->dNa('dbi_drivers', scalar(@dbs)? join("<br>", map{"<li>$_"} @dbs): "No DBI drivers available");
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 print $mf->form();
 print "</body></html>";
}

# end of abmain::fDa
1;
