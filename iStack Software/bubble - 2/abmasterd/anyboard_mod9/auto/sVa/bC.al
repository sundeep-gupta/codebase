# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 461 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/bC.al)"
sub bC {
 my($name, $val, $path, $exp) = @_;
 if($exp) {
 	return "Set-Cookie: $name=$val; expires=$exp; path=$path\n";
 }else {
 	return "Set-Cookie: $name=$val; path=$path\n";
 }
}

# end of sVa::bC
1;
