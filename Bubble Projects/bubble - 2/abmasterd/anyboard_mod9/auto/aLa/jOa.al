# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 114 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/jOa.al)"
sub jOa{
 my ($self, $xO) = @_;
 my $aJa = $self->{zKz};
 return if not $aJa->{jF};
 for(my $i=0; $i< @{$aJa->{jF}}; $i++) {
 my $p =${$aJa->{jF}}[$i];
 next if not $p; 
 if($p->[0] eq $xO) {
 	return ${$aJa->{jF}}[$i];
		}
 }
}

# end of aLa::jOa
1;
