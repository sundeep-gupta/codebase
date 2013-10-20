# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 697 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/fXa.al)"
sub fXa {
	my $self = shift;
	my $aJa = $self->{zKz};
 my @miss;
	foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		next if($ele->{type} eq 'head'); 
		next if($ele->{type} eq 'const'); 
		push @miss, $p->[0];
	}
	return @miss;
}

# end of aLa::fXa
1;
