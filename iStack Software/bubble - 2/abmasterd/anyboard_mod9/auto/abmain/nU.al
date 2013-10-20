# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 6749 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/nU.al)"
sub nU {
 if($abmain::gJ{cO}) {
	$iS->{_verbose}=1;
	local $| =1;
	sVa::gYaA "Content-type: text/html\n\n";
	print "<html><body><pre>";
 }
 $iS->nU($abmain::gJ{cO}, $abmain::gJ{hIz},
 $abmain::gJ{hJz}, $abmain::gJ{zA});
 if($iS->{_verbose}) {
	print "</pre>";
 	print $iS->dRz(), "</body></html>";
 }else{
	sleep(1);
 	sVa::hCaA "Location: ", $iS->fC(), "\n\n";
 }
 abmain::iUz();
};

# end of abmain::nU
1;
