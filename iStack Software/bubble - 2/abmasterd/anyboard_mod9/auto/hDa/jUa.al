# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package hDa;

#line 41 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/hDa/jUa.al)"
sub jUa{
	my ($self, $line) = @_;
	return if not $line;
	my @fs = split /\t/, $line;
	my $idx = shift @fs;
	$self->{entry_hash}->{$idx} = [@fs];
	if($idx > $self->{jSa}) {
		$self->{jSa} = $idx;
	}
}

# end of hDa::jUa
1;
