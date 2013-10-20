# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8504 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mYa.al)"
sub mYa{
	my ($self, $kQz) = @_;
 	return if not $kQz;
 	my $f = $self->bJa($kQz, 'msg');
 return if not -f $f;
	my $ent = lB->new();
 $ent->load($self, 0, $f);
 return if $ent->{hC} eq $ent->{to};
	return "$self->{qLa} from <b>$ent->{hC}</b>:<br/><b>$ent->{wW}</b> <br/>".abmain::dU('STD', $ent->{mM}, 'oP'). "<br/>Click to view: "
 .abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=myforum", "$self->{kRz}");

}

# end of jW::mYa
1;
