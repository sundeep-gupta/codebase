# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2734 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/wPa.al)"
sub wPa{
	my($self, $force) = @_;
 return $self->{_cached_fmagic} if(ref($self->{_cached_fmagic}) && not $force);
	require rNa;
	my $iC = $self->nDz('dbdir');
	mkdir $iC, 0755 if not -d $iC; 
	$self->gCz(1);
	my $isadm = $self->yXa();
 $self->eMaA( [qw(other_header other_footer)]);
	my $bRaA = rNa->new({
			iC=>$iC, 
			tmpldir =>$abmain::master_dbdef_dir,
			cgi=>$abmain::jT, cgi_full=>$abmain::dLz, 
			home=>$iC, 
			header=>"<html><head>$self->{sAz}\n$self->{other_header}", 
			footer=>$self->{other_footer},
			jW=>$self
 });

	#return if(($abmain::yCa/9 != $abmain::kQa[4] && ($abmain::kQa[4])) && ($abmain::yAa+8*2024*1024) <$abmain::yDa);
	$bRaA->cFaA($self->{admin});
	$bRaA->bUaA($self->sLa());
	$bRaA->bWaA($self->rIa());
	$bRaA->bTaA($self->fC());
 if($isadm) {
		$bRaA->cJaA($self->{admin});
 }elsif($self->{fTz}->{reg}) {
		$bRaA->cJaA($self->{fTz}->{name});
 }
 $self->{_cached_fmagic} = $bRaA;
 return $bRaA;
}

# end of jW::wPa
1;
