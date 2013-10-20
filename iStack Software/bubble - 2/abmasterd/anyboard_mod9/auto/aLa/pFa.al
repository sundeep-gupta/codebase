# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 253 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/pFa.al)"
sub pFa{
	my ($self, $type, $sfunc) = @_;
	my $aJa = $self->{zKz};
	foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		next if($ele->{type} ne $type); 
		$ele->nLa($sfunc);
	}
}

# end of aLa::pFa
1;
