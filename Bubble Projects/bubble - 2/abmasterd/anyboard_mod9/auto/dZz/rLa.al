# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 417 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/rLa.al)"
sub rLa {
 $_[0] =~ s/&/&amp;/g;
 $_[0] =~ s/</&lt;/g;
 $_[0] =~ s/>/&gt;/g;
 $_[0] =~ s/'/&apos;/g;
 $_[0] =~ s/"/&quot;/g;
 $_[0] =~ s/([\x80-\xFF])/&tFa(ord($1))/ge;
 return($_[0]);
}

# end of dZz::rLa
1;
