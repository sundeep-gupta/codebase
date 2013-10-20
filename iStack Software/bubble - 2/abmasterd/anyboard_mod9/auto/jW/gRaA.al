# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1673 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gRaA.al)"
sub gRaA {
	my ($self) = @_;
	my @opts = split /\s/, $self->{core_opts};
	my $opt_hash = {};
	for(@opts, @abmain::core_cfgs) {
		$opt_hash->{$_}=1;
	}
 $self->{_core_opts} = $opt_hash;
}

# end of jW::gRaA
1;
