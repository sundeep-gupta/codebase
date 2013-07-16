# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 1454 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/xEz.al)"
sub xEz{
 my ($t) = @_;
 $t = time() if not $t;
 my ($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst)=localtime($t);
 my $aorp;
 	$aorp = $hour>12 ? "PM": "AM";
 	$hour -= 12 if $hour > 12;;
 	$hour = "0$hour" if $hour<10;
 	$min = "0$min" if $min<10;
 	$mon = "0$mon" if $mon<10;
 	$nQ = "0$nQ" if $nQ<10;
 	$year+=1900;
 return  join(':', $year, $mon, $nQ, sprintf("%02d",$hour), sprintf("%02d", $min), $aorp, $mD);
}

1;

1;
# end of aLa::xEz
