# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8040 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/tGz.al)"
sub tGz {
 my ($self, $nousrchk) = @_;

	$self->gOaA();
 if($self->{lDz}) {
 $self->{bXz}->{rhost}= $self->{_cur_user_domain};
 }
	return if $nousrchk;
 my $title = $self->{name};
	&abmain::dE($abmain::master_cfg_dir);
	&abmain::dE($self->{eD});
	$self->gCz($abmain::gJ{fM});
 abmain::error('deny', "Access restricted.") if $self->{fTz}->{type} eq 'A' || $self->{fTz}->{type} eq 'B';
}

# end of jW::tGz
1;
