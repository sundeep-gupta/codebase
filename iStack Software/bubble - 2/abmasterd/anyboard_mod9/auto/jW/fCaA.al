# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2683 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fCaA.al)"
sub fCaA{
	my($self, $kQz, $force) = @_;
 return $self->{_cached_docman} if(ref($self->{_cached_docman}) && not $force);
	require eUaA;
	$self->gCz(1);
	my $isadm = $self->yXa();
 	my ($is_root, $root) = abmain::eVa() ;
 $self->eMaA( [qw(other_header other_footer)]);
	my $docman;
	my $rootdir;
	if($kQz ne '') {
			$rootdir = $self->gTaA($kQz); 
	}elsif($self->{fTz}->{reg} && !$self->{no_user_doc} ) {
			$rootdir = $self->gTaA($self->{fTz}->{name}); 
	}
	elsif($is_root || $isadm) {
			$rootdir=$self->{eD}, 
 }
	return if ($rootdir eq "" || not -d $rootdir);
	$docman = eUaA->new({
			rootdir=>$rootdir, 
			cgi=>$abmain::jT, cgi_full=>$abmain::dLz, 
			home=>$self->{eD}, 
			header=>"<html><head>$self->{sAz}\n$self->{other_header}", 
			footer=>$self->{other_footer},
			kQz=>$kQz||$self->{fTz}->{name},
			jW=>$self
 });

	if($self->{fTz}->{reg} && !$self->{no_user_doc}) {
		$docman->cFaA($self->{fTz}->{name});
		$docman->setShortView(1);
		$docman->setNoPermission(1);
		$docman->setQuota(1024*$self->{user_doc_quota});
	}elsif($is_root || $isadm) {
		$docman->cFaA($self->{admin});
	}
	$docman->bUaA($self->sLa());
	$docman->bWaA($self->rIa());
	$docman->bTaA($self->fC());
 if($self->{fTz}->{reg}) {
		$docman->cJaA($self->{fTz}->{name});
 } elsif($is_root) {
		$docman->cJaA($root);
		$docman->cFaA($root);
 }elsif($isadm) {
		$docman->cJaA($self->{admin});
 }
 $self->{_cached_docman} = $docman;
 return $docman;
}

# end of jW::fCaA
1;
