# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1655 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/mTa.al)"
sub mTa {
 my ($str, $tref, $bXaA, $skiphash) =@_;
 for(@$tref) {
	next if $skiphash && $skiphash->{$_};
 my $rep = $bXaA->{$_};
 $str =~ s/<$_>/$rep/gi;
 $str =~ s/\b$_\b/$rep/gi;
 }
 return $str;
}

# end of sVa::mTa
1;
