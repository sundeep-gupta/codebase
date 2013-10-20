# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 7146 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/fNa.al)"
sub fNa{
 $iS->cR();
 my $tt= $iS->fQa();
 if($abmain::gJ{js}) {
 	sVa::gYaA "Content-type: application/x-javascript\n\n";
 	print abmain::rLz($tt);
 }else {
 	sVa::gYaA "Content-type: text/html\n\n";
 	$iS->eMaA( [qw(other_header other_footer)]);
 	print qq(<html><head><title>Tags</title>$iS->{sAz}$iS->{other_header});
 	print $tt;
 	print $iS->{other_footer};
 }
}

# end of abmain::fNa
1;
