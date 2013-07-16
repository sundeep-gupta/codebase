# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2172 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/bJa.al)"
sub bJa {
 my($self, $kQz, $ext) = @_;
 $kQz = lc($kQz);
 $kQz = jW::bPa($kQz);
 $ext = "prf" if not $ext;
 if( ! -d $self->fQz()) {
 	mkdir $self->fQz, 0755 or abmain::error("Fail to create directory ".$self->fQz().": $!");
 }
 my $profd = abmain::kZz($self->fQz(), "members.dir");
 if( ! -d $profd) {
 	mkdir $profd, 0755 or abmain::error("Fail to create directory $profd: $!");
 }
 return abmain::kZz($profd, $kQz.".$ext");
}

# end of jW::bJa
1;
