# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2186 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gTaA.al)"
sub gTaA {
 my($self, $kQz) = @_;
 $kQz = lc($kQz);
 $kQz = jW::bPa($kQz);
 my $ext = "doc";
 my $profd = abmain::kZz($self->fQz(), "members.dir");
 if( ! -d $profd) {
 	mkdir $profd, 0755 or abmain::error("Fail to create directory $profd: $!");
 }
 my $docd=  abmain::kZz($profd, $kQz.".$ext");
 if( ! -d $docd) {
 	mkdir $docd, 0755 or abmain::error("Fail to create directory $docd: $!");
 }
 return $docd;
}

# end of jW::gTaA
1;
