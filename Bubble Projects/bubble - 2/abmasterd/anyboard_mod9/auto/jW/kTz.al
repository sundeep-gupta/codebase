# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2096 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/kTz.al)"
sub kTz {
 my($self, $name) = @_;
 $name = abmain::wS($name);
 return "$self->{cgi}?@{[$abmain::cZa]}cmd=vXz;pgno=A;kQz=$name";
}

# end of jW::kTz
1;
