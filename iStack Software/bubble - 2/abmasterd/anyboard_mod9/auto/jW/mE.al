# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 6063 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mE.al)"
sub mE{
 my  $str = shift;
 my $sum;
 my @arr = unpack("C*", $str);
 for(@arr){ $sum += $_;};
 $hW = "a"."$sum";
}

# end of jW::mE
1;
