# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8516 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nTa.al)"
sub nTa{
	my ($self, $notime) = @_;
 	my $f = $self->nDz('lastmsg');
 return if not -f $f;
	my $ent = lB->new();
 $ent->load($self, 0, $f);
 return if $ent->{body} eq "";
 my $text= $ent->{body};
	$text =~ s/&nbsp;/ /gi;
	$text =~ s!<br/>|<p>!\n!gi;
 $text =~ s/<[^>]*>//gs;   
 $text =~ s/<//gs;   
	my $abs = substr $text, 0, 200;
 	if($self->{auto_href_abs}) {
 		&jW::jEz(\$abs, $self->{xZz});
 }
 my $wW = $ent->{wW};
 $self->fZa(\$wW); 
	if($notime) {
		return "<b>$wW</b>-- $ent->{hC}<br/>"
 .$abs; 
	}else {
		return "<b>$wW</b> -- $ent->{hC} (".abmain::dU('STD', $ent->{mM}, 'oP'). ")<br/>"
 .$abs; 

	}

}

# end of jW::nTa
1;
