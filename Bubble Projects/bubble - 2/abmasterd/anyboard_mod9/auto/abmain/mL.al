# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 7404 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/mL.al)"
sub mL {
 $iS->cR();
 $iS->bI();
 $iS->aQz();
 $iS->{aGz} = 1;
 $iS->{aIz} = 1;
 my @fJ = split '\0', $abmain::gJ{fJ};
 my $e;
 $iS->{_show_prog} =1;
 local $| = 1; 
 sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 
 if(!$abmain::gJ{fromarch}) {
 if($abmain::gJ{by} eq 'fI') {
 	$e = $iS->qNa(\@fJ, $abmain::gJ{thread}, 0, $abmain::gJ{gLz}, $abmain::gJ{backup});
 }else {
 	$e = $iS->aQ($abmain::gJ{by}, \@fJ, $abmain::gJ{thread}, 0, $abmain::gJ{gLz}, $abmain::gJ{backup});
 }
 	$iS->aQz();
 	for(@{$iS->{just_deleted}}) {
 		delete $iS->{aLz}->{$_};
 	}
 	$iS->aVz();
 	$iS->{aIz} = 0;
 	$iS->aT();
 	$iS->eG();
 	my $fC=$iS->fC();
 }else {
 $e = $iS->iNa($abmain::gJ{by}, \@fJ, 0, $abmain::gJ{gLz});
 }
 print "<pre>\n$e\n</pre>";

 #abmain::cTz("<pre>\n$e\n</pre>","Deletion results");
};

# end of abmain::mL
1;
