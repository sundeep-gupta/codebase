# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2591 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/hUa.al)"
sub hUa{
 my $gEz = $abmain::fPz{fOz};
 my ($gJz, $fJz) = split/\&/, $gEz;
 $gJz = pack("h*", $gJz);
 ($abmain::ab_id0, $abmain::ab_id1, $abmain::ab_track) = (split /\</, $abmain::fPz{$abmain::cH})[0..2];
 $abmain::ab_id0 = $gJz if $gJz;
 @abmain::kQa =  abmain::lCa($abmain::lGa, $abmain::lEa[0]);
}

# end of abmain::hUa
1;
