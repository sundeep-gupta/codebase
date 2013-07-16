# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7759 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/zEa.al)"
sub zEa {
 my ($self, $cG, $aCz, $wt) = @_;
 $wt = 1 if not $wt;
	$self->gOaA();
	if(!$abmain::fPz{zN} && !$abmain::fPz{$self->{vcook}}){
	   abmain::error('iT', "Please send Cookies to $self->{name}");
	} 
 	$self->gCz() if $self->{rRz};
 $self->oF(LOCK_EX, 9);
 my $df = $self->gN($cG);
 my $cloc = (-f $df) ? undef: "a";
 $self->aFz($cG, $cloc);
 $self->aFz($cG) if $cloc && not $self->{ratings2}->{$cG};
 my ($aUz, $cnt, $ovis, $fpos, $loc, $readers) =  split "\t", $self->{ratings2}->{$cG};
 $aUz = ($aUz*$cnt + $aCz*$wt)/($cnt+$wt); 
 $cnt += $wt;
 $self->{ratings2}->{$cG}=join("\t", $aUz, $cnt, $ovis, $fpos, $loc, $readers);
 $self->aKz($cG, $loc);
 $self->pG(9);
 	$self->rSz();
}

# end of jW::zEa
1;
