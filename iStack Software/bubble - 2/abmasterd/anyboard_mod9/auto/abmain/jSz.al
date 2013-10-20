# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 7880 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/jSz.al)"
sub jSz {
 
 my $time = $_[0] || time(); # default to now if no argument

 my @months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
 my @wdays  = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");

 my ($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst) = localtime($time);
 $mon = $months[$mon];
 $mD = $wdays[$mD];
 my $zone = sprintf("%+05.d", ($TZ + $isdst) * 100);
 return join(" ", $mD.",", $nQ, $mon, $year+1900, sprintf("%02d", $hour) . ":" . sprintf("%02d", $min), $zone );
}

# end of abmain::jSz
1;
