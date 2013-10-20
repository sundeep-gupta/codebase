# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 10170 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/bEz.al)"
sub bEz {
 my $self = shift;
 $self->cR();
 my ($is_root, $root) = abmain::eVa() ;
 if($is_root && $root ne "") {
 	    $self->oXa($root);
 }else {
 $self->gCz();
 }
 abmain::error('inval', "User deletion of message not enabled") 
 if not ($is_root || $self->{bGz} || $self->{allow_del_priv}) ;
 $self->{aGz}=1;
 $self->{aIz}=1;
 my $title = $self->{name};

 my $name;
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
	}
 $self->fSa($name, "Delete");
	my $cG = $abmain::gJ{cG};
	my $act = $abmain::gJ{action};
	abmain::error('inval', "Invalid message id") if $cG <=0;
 my $msg = $self->pO($cG);
	abmain::error('inval', "Message #$cG not found") if (!$msg);
 my $isadm = $name eq $self->{admin} || $self->{moders}->{$name} || $is_root;
	abmain::error('deny', "Only the author of the message or admin can delete or modify it") 
 unless ($name eq $msg->{hC} || $isadm);
 abmain::error('inval', "Post is too old to be modified") 
		if $self->{nCz}>0 && (time()-$msg->{mM}) > $self->{nCz}*3600 && not $isadm;
 if("" eq "$act") {
 	abmain::error('inval', "User deletion of message not enabled") 
 	      if not ($self->{bGz} || $msg->{to}) ;
 	my $e = $self->qNa(["$cG $msg->{aK}"], $abmain::gJ{thread} && $isadm);
		$self->nU();
		abmain::cTz("<h1> Message #$cG deleted </h1><pre>$e</pre>", "Response", $self->fC());
		return;
	}
 $self->gSa($cG, $abmain::gJ{bpos}, $act);
	$self->nU();
 sVa::hCaA "Location: ", $self->fC(), "\n\n";
}

# end of jW::bEz
1;
