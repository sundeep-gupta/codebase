# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2355 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fA.al)"
sub fA {
 my ($self, $fI, $gV, $pv) = @_;
 $fI =~ /(.*)/; $fI = $1;
 my $suf ="";
 $suf = ".pv" if $pv;
 my $mdir = $gV? $jW::hNa{mK}: $jW::hNa{hM};
 return abmain::kZz($self->{eD} , $mdir,  "$fI.". $self->{ext}).$suf;
}

# end of jW::fA
1;
