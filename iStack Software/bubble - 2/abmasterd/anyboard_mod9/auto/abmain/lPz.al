# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3326 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/lPz.al)"
sub lPz {
 my $cdir = shift;
 my $dVz="";
 my $lstr;
 while(1) {
 $dVz .="../";
 my ($n, $d, $l, $m) = abmain::lIz(abmain::kZz($cdir, $dVz));
 last if not $n;
 $lstr = abmain::cUz($dVz, $n). "\&nbsp; =\&gt; $lstr ";
 }
 return $lstr;
}

# end of abmain::lPz
1;
