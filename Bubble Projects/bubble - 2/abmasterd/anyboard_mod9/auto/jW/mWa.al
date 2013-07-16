# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8411 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mWa.al)"
sub mWa {
	my ($self, $usr1, $usr2) = @_;
	abmain::jJz(\$usr1);
	abmain::jJz(\$usr2);
	return 0 if not ($usr1 && $usr2);
	my $mf1= $self->gXa($usr1);
	my $mf2= $self->gXa($usr2);
	my %ig1 = jW::nVa($mf1->{ignores});
	my %ig2 = jW::nVa($mf2->{ignores});
	return 1 if $ig1{$usr2};
	return 2 if $ig2{$usr1};
	return 0;
}

# end of jW::mWa
1;
