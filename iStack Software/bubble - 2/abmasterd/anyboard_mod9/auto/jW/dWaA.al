# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7878 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dWaA.al)"
sub dWaA{
 my ($self, $cG) = @_;
 $self->oF(LOCK_EX, 9);
 my $df = $self->gN($cG);
 my $cloc = (-f $df) ? "": "a";
 $self->aFz($cG, $cloc, 1);
 $self->aFz($cG, undef, 1) if $cloc && not $self->{ratings2}->{$cG};
 my ($aUz, $cnt, $ovis, $ofval, $oloc, $rds) = split /\t/, $self->{ratings2}->{$cG};
 $self->{ratings2}->{$cG}= join("\t", $aUz, $cnt, $ovis, $ofval, $oloc, undef);
 $self->aKz($cG, $oloc, 1);
 $self->pG(9);
}

# end of jW::dWaA
1;
