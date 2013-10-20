# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 6472 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yXa.al)"
sub yXa{
 my $self = shift;

 mE($abmain::fvp);
 if(not defined($abmain::fPz{$hW})) {
 return;
 }
 ($cI, $aN) = split /:/, $abmain::fPz{$hW};
 $oK = pack("H*",  $cI);
 $dD = pack("H*",  $aN);
 my $p = $self->{oA};
 my $inp = abmain::lKz($dD, $dD);

 if ($oK eq $self->{admin} && (($inp eq $p))){
 $uT = "adm";
		return 1;
 }
 return;
}

# end of jW::yXa
1;
