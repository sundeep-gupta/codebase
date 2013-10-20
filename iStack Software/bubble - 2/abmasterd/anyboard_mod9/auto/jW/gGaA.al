# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1640 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gGaA.al)"
sub gGaA {
	my ($self, $input) = @_;
 	my @all_cfgs;
 	for(values %abmain::qJa) {
 	     push @all_cfgs, @{$_->[1]};
 	}
 my @ocfgs;
 $self->cR();
	$self->gRaA();
	for(@all_cfgs) {
		if($_->[1] eq 'head') {
			push @ocfgs, $_;
		}else {
			my $v = $self->{_core_opts}->{$_->[0]} ? $_->[0] : undef;
			
			push @ocfgs, ['_baseopts', 'checkbox', "value=".$_->[0], $_->[3], undef, $v];
		}
 }
 	$self->jI(\@ocfgs, "gHaA", "Choose basic forum options");

}

# end of jW::gGaA
1;
