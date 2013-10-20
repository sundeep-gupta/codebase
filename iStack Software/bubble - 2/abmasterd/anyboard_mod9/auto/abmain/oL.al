# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 5363 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/oL.al)"
sub oL{
 $iS->cR();
 sVa::hCaA "Location: ", $iS->fC(), "\n\n" if(!$iS->{qR}); 
 if($abmain::gJ{all}) {
 	my @all_cfgs;
 	for(values %abmain::qJa) {
 	     push @all_cfgs, @{$_->[1]};
 	}
 	$iS->jI(\@all_cfgs, "", "Forum options", 1, 1);
 }else {
 $iS->jI(\@abmain::tL, "", "Forum options", 1, 1);
 }
}

# end of abmain::oL
1;
