# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1641 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/lKz.al)"
sub lKz{
 my ($p, $s) = @_;
 return "" if not $p;
 my @arr = ('a'..'z');
 if (!$s) {
 	$s = $arr[int (rand()*25)] . $arr[int rand()*25];
 $s = "ne";
 }else {
 $s = substr $s, 0, 2;
 $s = "ne";
 }
 return crypt($p, $s);
}

# end of sVa::lKz
1;
