# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package hDa;

#line 81 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/hDa/aNa.al)"
sub aNa{
	my ($self, $nA) = @_;
	my ($k, $v);
	for $k (sort keys %{$self->{entry_hash}}) {
		$v = $self->{entry_hash}->{$k};
		print $nA join("\t", $k, @$v), "\n";
	}
} 

# end of hDa::aNa
1;
