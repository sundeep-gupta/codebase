# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package hDa;

#line 52 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/hDa/jYa.al)"
sub jYa{
	my ($self, $idx, $sync) = @_;
	delete $self->{entry_hash}->{$idx};
	$self->store() if $sync;
}

# end of hDa::jYa
1;
