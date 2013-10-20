# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 92 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/dLaA.al)"
sub dLaA{
	my ($self, $verfstr) = @_;
	return if not ($verfstr||$self->{verifiers});
	my @verfs = split /\s*\|\s*/, $verfstr||$self->{verifiers};
	for(@verfs) {
		$_ =~ s/^\s+//;
		$_ =~ s/\s+$//;
		my ($hR, $arg) = split /\s+/, $_, 2;
		next if not $hR;
		$hR =~ /(.*)/; $hR = $1;
		$self->iEa([eval "\\\&$hR", $arg?[split /\s*,\s*/, $arg]:undef ]);
	}
}

# end of bAa::dLaA
1;
