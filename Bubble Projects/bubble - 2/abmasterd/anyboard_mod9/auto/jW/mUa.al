# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4174 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mUa.al)"
sub mUa {
 my ($str, $tref, $bXaA) =@_;
 for my $x(@$tref) {
 my $rep = $bXaA->{$x};
 $str =~ s/<$x>/$rep/gi;
 }
 return $str;
}

# end of jW::mUa
1;
