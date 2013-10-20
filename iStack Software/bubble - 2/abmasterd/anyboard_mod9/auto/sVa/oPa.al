# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1194 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/oPa.al)"
sub oPa {
 my ($str, $sep) = @_;
 $sep = "=" if $sep eq "";
 my ($k, $v, $pos);
 $pos = index $str, $sep;
 return if $pos <0;
 $k = substr $str, 0, $pos;
 $v = substr $str, $pos+1;
 return ($k, $v);
}

# end of sVa::oPa
1;
