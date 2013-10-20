# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 127 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/tKa.al)"
sub tKa{
 my ($self, $xO) = @_;
 my $aJa = $self->{zKz};
 return if not $aJa->{jF};
 for(my $i=0; $i< @{$aJa->{jF}}; $i++) {
 my $p =${$aJa->{jF}}[$i];
 next if not $p; 
 if($p->[0] eq $xO) {
			return $aJa->{bLa}->{$p->[0]};
		}
 }
}

# end of aLa::tKa
1;
