# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3018 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fOa.al)"
sub fOa {
 my ($self, $ent, $keepdate, $recur) = @_;
 $ent->{mM} = time() if not $keepdate;
 if($ent->{kRa}) {
 	$self->mO(split /\t/, $ent->nJa());
	$ent->store($self);
 }else {
 	$self->xB($ent->{fI}, $ent->{_data});
 }
 my $ent2;
 if($recur>2000) {
	print STDERR "exceeded recursion limit, in lDa\n";
	return;
 }
 foreach $ent2 (@{$ent->{bE}}) {
	$self->fOa($ent2, $keepdate, 1+$recur);
 }
 $self->bT($ent->{fI}) if not $ent2;
}

# end of jW::fOa
1;
