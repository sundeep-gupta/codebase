# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7810 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dIaA.al)"
sub dIaA{
 my ($self, $cG, $fpos, $val) = @_;

	$self->gOaA();
	if(!$abmain::fPz{zN} && !$abmain::fPz{$self->{vcook}}){
#	   abmain::error('iT', "Please send Cookies to $title");
	} 
#       	$self->gCz() if $self->{rRz};
 $self->oF(LOCK_EX, 9);
 my $df = $self->gN($cG);
 my $cloc = (-f $df) ? "": "a";
 $self->aFz($cG, $cloc, 1);
 $self->aFz($cG, undef, 1) if $cloc && not $self->{ratings2}->{$cG};
 my ($aUz, $cnt, $ovis, $ofval, $oloc, $rds) = split /\t/, $self->{ratings2}->{$cG};
	my $nfval = $ofval;
	my $f = 1<<($fpos -1);
 if($val) {
 $nfval |= $f;
 }else {
		$nfval &= ~$f;
 }
		
	if ($ofval == $nfval) {
 	$self->pG(9);
		return;
	}
 $self->{ratings2}->{$cG}= join("\t", $aUz, $cnt, $ovis, $nfval, $oloc, $rds);
 $self->aKz($cG, $oloc, 1);
 $self->pG(9);
 	$self->rSz();
}

# end of jW::dIaA
1;
