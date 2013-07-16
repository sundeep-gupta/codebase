# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 470 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/bF.al)"
sub bF {
 my($name, $val);
 foreach (split (/; /, $ENV{'HTTP_COOKIE'})) {
 ($name, $val) = split /=/;
 $fPz{$name}=$val;
 }
}

# end of sVa::bF
1;
