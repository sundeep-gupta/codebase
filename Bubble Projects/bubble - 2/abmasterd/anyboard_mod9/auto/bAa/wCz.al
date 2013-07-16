# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 56 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/wCz.al)"
sub wCz{
 my ($id, $tmstamp, $format) = @_;
 $tmstamp = sVa::bAaA() if not $tmstamp;

 my($year, $mon, $day, $hour, $min,$sec)= sVa::eRaA($tmstamp);

 my ($y, $m, $d, $h, $mn, $ap);
 
 $y = zSz($id."_year", [$year-100..$year+20], $year);
 $m = zSz($id."hHa", [map {sprintf("%02d", $_)}(1..12)], $mon, \@sVa::months);
 $d = zSz($id."_day", [map {sprintf("%02d", $_)}(1..31)], $day);
 $h = zSz("${id}_hour", [map {sprintf("%02d", $_)} (0..23)], $hour);
 $mn  = zSz("${id}iOa", [map {sprintf("%02d", $_)} (0..59)], $min);
 return $format eq 'date' ? "$y-$m-$d" : "$y - $m - $d, $h : $mn";
}

# end of bAa::wCz
1;
