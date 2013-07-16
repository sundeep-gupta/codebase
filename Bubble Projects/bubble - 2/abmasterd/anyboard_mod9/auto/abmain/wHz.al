# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 5486 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/wHz.al)"
sub wHz {
 $iS->cR();
 $iS->bI();
 my $kQz = $abmain::gJ{kQz};
 $kQz = lc($kQz);
 $iS->fZz($kQz);

 my @regcfgs= abmain::oCa(\@abmain::bB);
 if($iS->{short_reg_form}) {
	$regcfgs[3]->[1]="hidden";
	$regcfgs[4]->[1]="hidden";
	$regcfgs[5]->[1]="hidden";
 }
 $regcfgs[0]->[2]  = "Modify user $kQz"; 
 my $profile = $iS->{gFz}->{$kQz};
 if( not $iS->{fYz}->{$kQz}) {
 	abmain::error('inval', "User not found!");
 }
 $profile =[] if not $profile;
#email 
 $regcfgs[2]->[5] = $profile->[1];
#wO
 $regcfgs[3]->[5] = $profile->[3];
#location
 $regcfgs[4]->[5] = $profile->[7];
#desc 
 $regcfgs[5]->[5] = $profile->[8];
 $regcfgs[8]->[5] = $profile->[10];
 $regcfgs[9]->[5] = $profile->[9];
 
 pop @regcfgs if not $iS->{notify_usr};
 $regcfgs[6]=undef;
 $regcfgs[7]=undef;

 push @regcfgs, [status=>"select", $abmain::user_stat_sel, "Status", "", $profile->[4]];
 push @regcfgs, [fMz=>"select", $abmain::user_type_sel, "Access type", "", $profile->[6]];
 push @regcfgs, [kQ=>"hidden", undef, undef, undef, $kQz];
 $iS->jI([@regcfgs[0, 2..12]], "amodreg", "Modify user registration information", 0);
}

# end of abmain::wHz
1;
