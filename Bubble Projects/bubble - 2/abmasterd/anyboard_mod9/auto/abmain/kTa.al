# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3167 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/kTa.al)"
sub kTa{
 my($kSa,  $prog, $kRa, $kYa, $kVa, $kXa, $lBa,$lDa, $kZa) = @_;
 $kSa =~ s!^https?://!!i;
 my $str = lc($kSa.join("", reverse @_));
 my $chksm = unpack("%32C*", $str);
 return lc($prog.$kRa.$kYa.$chksm."$kVa${kXa}n$lBa$lDa$kZa");
}

# end of abmain::kTa
1;
