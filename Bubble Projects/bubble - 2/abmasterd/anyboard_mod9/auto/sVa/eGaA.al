# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1861 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/eGaA.al)"
sub eGaA{
 my($year, $mon, $day, $hour, $min,$sec) = @_;
 return sprintf("%04d%02d%02d%02d%02d%02d", $year, $mon, $day, $hour, $min,$sec) ;
}

# end of sVa::eGaA
1;
