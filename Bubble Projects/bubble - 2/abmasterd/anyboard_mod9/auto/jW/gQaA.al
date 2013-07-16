# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4790 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gQaA.al)"
sub gQaA {
	my ($self, $msg_arr, $jK, $depth, $here, $linkit, $nocat) = @_;
	my $msg = lB->new();
	for my $m(@$msg_arr) {
		$msg->gKaA($self, $m);
	}
	return $self->gNaA($msg, $jK, $depth, $here, $linkit, $nocat);
}

# end of jW::gQaA
1;
