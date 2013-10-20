# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 79 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/wFz.al)"
sub wFz{
 my ($ts) = @_;
 $ts = xEz() if not $ts;

 my($min,$hour,$nQ,$mon,$year, $aorp, $mD);
 ($year, $mon, $nQ, $hour, $min, $aorp) = split /:/, $ts;
 
 my $m = $sVa::months[$mon];
 my $w = $sVa::wdays[$mD],
 return "$m $nQ, $year, $hour:$min $aorp";

}

# end of bAa::wFz
1;
