# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 427 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/tFa.al)"
sub tFa {
 my $n = shift;
 if ($n < 0x80) {
 return chr ($n);
 } elsif ($n < 0x800) {
 return pack ("CC", (($n >> 6) | 0xc0), (($n & 0x3f) | 0x80));
 } elsif ($n < 0x10000) {
 return pack ("CCC", (($n >> 12) | 0xe0), ((($n >> 6) & 0x3f) | 0x80),
 (($n & 0x3f) | 0x80));
 } elsif ($n < 0x110000) {
 return pack ("CCCC", (($n >> 18) | 0xf0), ((($n >> 12) & 0x3f) | 0x80),
 ((($n >> 6) & 0x3f) | 0x80), (($n & 0x3f) | 0x80));
 }
 return $n;
}

1;

1;

1;
# end of dZz::tFa
