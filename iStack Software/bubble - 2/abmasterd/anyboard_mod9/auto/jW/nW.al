# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 6512 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nW.al)"
sub nW {
 my ($self) = @_;
 my ($uname, $pass) = ($abmain::gJ{uname}, $abmain::gJ{passwd});
 my  @pass_ent = getpwnam($uname) or abmain::error('dM', "Who are you?");
 my  $salt = substr($pass_ent[1], 0, 2);
 if (crypt($pass, $salt) ne $pass_ent[1]) {
 abmain::error('dM', "Invalid user name or password for $pass_ent[0]");
 }
 $self->jI();
}

# end of jW::nW
1;
