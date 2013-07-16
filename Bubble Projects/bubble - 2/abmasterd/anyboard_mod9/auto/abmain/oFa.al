# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 7267 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/oFa.al)"
sub oFa {
 my $non_root = shift;
 $iS->cR();
 my ($is_root, $root) = abmain::eVa() ;
 my $isadm;
 unless ($is_root) {
	$iS->gCz();
	my $uname = $iS->{fTz}->{name};
	$isadm=   $iS->{moders}->{$uname} || $uname eq $iS->{admin};
 $isadm |= $iS->yXa();
	abmain::error('deny') if not $isadm;
 }
 abmain::error("deny") if  not ($is_root || $non_root || ($isadm && ($abmain::forum_admin_roll || $abmain::gJ{newscat} eq $iS->pJa() ) ));
 $iS->oFa($abmain::gJ{subject}, $abmain::gJ{cG}, $abmain::gJ{aK}, $abmain::gJ{newscat});
 my $str = jDa(10,0,1, "", $abmain::gJ{newscat});
 abmain::cTz("$str", "Message added");
}

# end of abmain::oFa
1;
