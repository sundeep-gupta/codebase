# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 10104 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/vF.al)"
sub vF {
 my $self = shift;
 $self->cR();
 my ($is_root, $root) = abmain::eVa() ;
 if($is_root && $root ne "") {
 	    $self->oXa($root);
 }else {
 $self->gCz();
 }

 $self->{aGz}=1;
 $self->{aIz}=1;
 my $title = $self->{name};

	$self->yA(\%abmain::gJ, 1);
 my $name = $self->{bXz}->{name};
	if($self->{fWz} || $is_root) {
	     $name = $self->{fTz}->{name};
	}else {
	      $name = $abmain::gJ{name};
	      $self->fZz($name);
	      my $auth_stat = $self->auth_user($name, $abmain::gJ{passwd});
	      if($auth_stat eq 'NOUSER') {
 		my $tP= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=yV", $self->{sK});
	  		abmain::error('inval', "To be able to edit your message, you must $tP")
	       }
 	       $iG = abmain::lKz($abmain::gJ{passwd}, 'ne') if $abmain::gJ{passwd};
	       $iG = $abmain::fPz{iG} unless $iG;
 abmain::error('dM', "Correct password required for registered user <b>$name</b>") if $auth_stat ne 'AUTHOK';
 	       $self->oXa($name);
	}
	my $cG = $abmain::gJ{cG};
	abmain::error('inval', "Invalid message id") if $cG <=0;
	$self->pO($cG, undef, 1, 0, 1);
	my $msg = $self->{dA}->{$cG};
	if ($name ne $msg->{hC}) {
		abmain::error('deny', "Only the author of the message can modify it")
 unless $is_root || ($self->{admin_ed} && ($name eq $self->{admin} || $self->{moders}->{$name}));
 }
	if ($name eq $msg->{hC}) {
 	abmain::error('deny', "Access restricted.") if $self->{fTz}->{type} ne 'E';
		
	}
	$msg->load($self, 1);
 $msg->{size} = length($self->{bXz}->{body});
 	$msg->{wW}=$self->{bXz}->{wW};
	$msg->{scat} = $abmain::gJ{scat} if defined $abmain::gJ{scat} && $abmain::gJ{changescat};
 $self->{bXz}->{body} = $self->fGz($self->{bXz}->{body}, 'fHz');
 $msg->{modifier} = $name;
 $msg->{body} = $self->{bXz}->{body};
 $msg->{tP} = $self->{bXz}->{url};
 $msg->{rlink_title} = $self->{bXz}->{url_title};
 $msg->{mtime} =  time();
	$msg->{sort_key} = $self->{bXz}->{sort_key};
	$msg->{key_words} = $self->{bXz}->{key_words};
	$msg->{xE} |= $pTz if ( $pTz & $jUz);
	$msg->{xE} |= $FHASLNK if ( $FHASLNK & $jUz);
	$msg->store($self);
 $self->vWz($msg);
	$self->bT($cG);
	my $aK = $self->{dA}->{$cG}->{aK};
	my $sub = $self->{dA}->{$cG}->{wW};
 my $link= abmain::cUz($self->nGz($cG, $aK, 0, 0, $msg->qRa()), "<small>$sub</small>");
 $self->rSz(-10);
	abmain::cTz("<h1> $link modified</h1>", "Response", $self->fC());
}

# end of jW::vF
1;
