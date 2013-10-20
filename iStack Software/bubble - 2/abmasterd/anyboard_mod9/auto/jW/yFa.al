# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5373 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yFa.al)"
sub yFa {
	my ($self, $xZa, $cG) = @_;
 my ($is_root, $root) = abmain::eVa() ;
 abmain::error('inval', "Invalid message id") if $cG <=0;
 my $msg= $self->pO($cG); 	

 my $name;
	my $bRaA = $self->wPa();	
	$name = $bRaA->{wOa};

	if ($name ne $msg->{hC}) {
		abmain::error('deny', "Only the author ($msg->{hC}) of the message can modify it ($name)")
 unless $is_root || ($self->{admin_ed} && ($name eq $self->{admin} || $self->{moders}->{$name}));
	}
 
 my $link= abmain::cUz($self->nGz($cG, $msg->{aK}, 0, 0, $msg->qRa()), $msg->{subject});

 my $form = $bRaA->yOa($xZa, 0, undef, {_ab_attach2mno=>$cG});
	sVa::gYaA "Content-type: text/html\n\n";
	print $self->yLa($link."<br/>".$form->form());
}

# end of jW::yFa
1;
