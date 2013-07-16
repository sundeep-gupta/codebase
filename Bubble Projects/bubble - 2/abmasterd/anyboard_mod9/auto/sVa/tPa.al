# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1171 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/tPa.al)"
sub tPa{
 my $gEz = shift;
 my ($gJz, $fJz, $opt) = split/:/, $gEz, 3;
 $gJz = pack("h*", $gJz);
 $fJz = pack("H*", $fJz);
 return ($gJz, $fJz, $opt);
}

# end of sVa::tPa
1;
