# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4799 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gI.al)"
sub gI{
 my ($self, $verbose)= @_;
 my @msgs = values %{$self->{dA}};
 $self->{_regened_mnos} = {};
 for my $msg(sort {$a->{aK} <=> $b->{aK}} @msgs) {
	     if(scalar (@{$msg->{bE}})== 0) { 
	     	$self->bT($msg->{fI});
	     	if($verbose) {
			print ": Regened message ($msg->{fI}, $msg->{jE}, $msg->{aK})\n";
		}
 }
 }
 $self->{_regened_mnos} = {};
}

# end of jW::gI
1;
