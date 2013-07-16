# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5395 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yGa.al)"
sub yGa{
 my ($self, $cG, $xZa, $objid, $msgstr, $design) = @_;
 my ($is_root, $root) = abmain::eVa() ;
 if($is_root && $root ne "") {
 	    $self->oXa($root);
 }else {
 $self->gCz(1);
 }

 $self->{aGz}=1;
 $self->{aIz}=1;
 my $title = $self->{name};

	abmain::error('inval', "Invalid message id") if $cG <=0;
	$self->pO($cG, undef, 1, 0);
	my $msg = $self->{dA}->{$cG};

 my $name;
	if($self->{fWz} || $is_root) {
	     $name = $self->{fTz}->{name};
	}

	if ($name ne $msg->{hC}) {
		abmain::error('deny', "Only the author ($msg->{hC}) of the message can modify it ($name)")
 unless $is_root || ($self->{admin_ed} && ($name eq $self->{admin} || $self->{moders}->{$name}));
 }

	$msg->load($self, 1);
	$msg->{attached_objtype} =$xZa;
	$msg->{attached_objid} = $objid;
	$msg->{status} = "ok";
	if($design->{allowedreaders} ne "") {
		my $oldto = $msg->{to};
	        my $th = jW::eFaA($oldto);	
	        my $th2 = jW::eFaA($design->{allowedreaders});	
		my (@nus, $nu);
		for my $u (keys %$th2) {
			push @nus, $u if not $th->{$u};
		}
		$nu = join(", ", @nus);
		$msg->{to} = join(", ", keys %$th, keys %$th2) if $nu ne "";
		$self->cMaA($msg, $nu) if $nu ne '';
	}
	$msg->store($self);
 $self->vWz($msg);
	$self->bT($cG);
	my $aK = $self->{dA}->{$cG}->{aK};
	my $sub = $self->{dA}->{$cG}->{wW};
 my $murl= $msg->nH($self, -1);
 my $link= abmain::cUz($murl, "<small>$sub</small>");
 $self->rSz(-10);
	abmain::cTz("<h1> Posted data to $link </h1><p>$msgstr", "Response", $murl);
}

# end of jW::yGa
1;
