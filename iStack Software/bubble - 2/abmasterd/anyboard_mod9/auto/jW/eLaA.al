# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2369 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/eLaA.al)"
sub eLaA {
 my ($self, $user) = @_;
 $user = lc($user);
 my $hno = abmain::fVz($user, $passwd_cnt) || "0";
 return abmain::kZz($self->dBaA(),$hno);
}

# end of jW::eLaA
1;
