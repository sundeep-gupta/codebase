# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 4806 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/kOa.al)"
sub kOa{
	abmain::error("dM") if(not eVa()) ;
	my $mf = new aLa('lic', \@abmain::lFa, $jT);
	$mf->aAa(\%abmain::gJ);
	$mf->{iGz} =~ s/\s+//g;
	$mf->{iGz} =~ s/"//g;
	abmain::error('inval') if scalar((split /(\d+)/, $mf->{iGz})) <6;
 	abmain::kPa("kUa", unpack("h*", $mf->{iGz}));
	abmain::wLz();
}

# end of abmain::kOa
1;
