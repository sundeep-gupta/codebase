# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package hDa;

#line 26 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/hDa/kKa.al)"
sub kKa {
	my ($self, $idx,  $tm,  $ent) = @_;
	return if not $ent;
	$self->{entry_hash}->{$idx} = [$tm, $ent->dHa()];
	if($idx > $self->{jSa}) {
		$self->{jSa} = $idx;
	}
}

# end of hDa::kKa
1;
