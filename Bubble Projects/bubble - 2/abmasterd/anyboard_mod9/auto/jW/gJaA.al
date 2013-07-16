# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9326 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gJaA.al)"
sub gJaA{
 my ($self, $vH, $noderef, $hO) = @_;
 return if $vH->{jE} <=0;
 return if $hO > 500;
 my $pF = $vH->{jE};
 my $aI = $self->{dA}->{$pF};
 if(ref($aI) ne 'lB') {
	$aI = $self->pO($pF, undef, 1);
 $self->{dA}->{$pF} = $aI;
 }
 push @{$noderef}, $aI;
 return $self->gJaA($aI, $noderef, $hO+1);
}

# end of jW::gJaA
1;
