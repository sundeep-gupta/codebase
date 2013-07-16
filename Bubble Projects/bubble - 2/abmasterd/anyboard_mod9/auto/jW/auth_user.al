# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1910 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/auth_user.al)"
#return 'AUTHOK' if user exists and OK, 'NOUSER' if user does not exist, 'AUTHFAIL' if user exists but password is not OK

sub auth_user {
	my ($self, $gJz, $passwd)= @_;
 	return 'NOUSER' if ($self->{fYz}->{lc($gJz)} eq  '');
 	return $self->{fYz}->{lc($gJz)} eq  abmain::lKz($passwd, 'ne') ? 'AUTHOK':'AUTHFAIL';
}

# end of jW::auth_user
1;
