# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 824 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/jSz.al)"
sub jSz {
# convert a time() value to a date-time string according to RFC 822
 
 my $time = $_[0] || time(); # default to now if no argument

 my 	@months2 = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
 my @wdays2  = qw(Sun Mon Tue Wed Thu Fri Sat);
 my ($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst) = localtime($time);
 $mon = $months2[$mon];
 $mD = $wdays2[$mD];
 my $zone = sprintf("%+05.d", ($TZ + $isdst) * 100);
 return join(" ", $mD.",", $nQ, $mon, $year+1900, sprintf("%02d", $hour) . ":" . sprintf("%02d", $min), $zone );
}

# end of sVa::jSz
1;
