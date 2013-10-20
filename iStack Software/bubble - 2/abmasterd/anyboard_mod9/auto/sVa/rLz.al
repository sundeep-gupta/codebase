# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 628 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/rLz.al)"
sub rLz {
 my ($str) = @_;
 $str =~ s/'/\\'/g;
 $str =~ s/\n/\\n/g;
 $str =~ s/\r//g;
 return qq!document.write('$str');!;
}

# end of sVa::rLz
1;
