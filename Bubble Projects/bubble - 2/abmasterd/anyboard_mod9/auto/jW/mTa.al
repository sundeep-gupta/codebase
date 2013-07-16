# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4182 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mTa.al)"
sub mTa {
 my ($str, $tref, $bXaA, $skiphash) =@_;
 for my $x (@$tref) {
	next if $skiphash && $skiphash->{$x};
 my $rep = $bXaA->{$x};
 $str =~ s/<$x>/$rep/gi;
 $str =~ s/\b$x\b/$rep/g;
 }
 return $str;
}

# end of jW::mTa
1;
