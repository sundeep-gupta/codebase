# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 385 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/kKz.al)"
sub kKz{
 my $d=shift;
 $d =~ s/\s+//g;
 my ($k, $c) = split /\./, $d;
 $c and $c == unpack("%16C*", $k);
}

# end of jW::kKz
1;
