# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1164 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/sBa.al)"
sub sBa{
 my ($name, $pass, $opt) = @_;
 my $uid_c = unpack("h*", $name);
 my $cE = unpack("H*", $pass);
 return "$uid_c:$cE:$opt";
}

# end of sVa::sBa
1;
