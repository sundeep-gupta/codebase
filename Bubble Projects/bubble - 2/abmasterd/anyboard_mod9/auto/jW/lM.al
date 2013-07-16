# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 6532 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/lM.al)"
sub lM{
 my ($self) = @_;
 $self->cR();
 $self->bI($abmain::gJ{fM}, $abmain::gJ{oA});
 if($self->{oA} eq "" && not $abmain::g_is_root) {
		my $cook = abmain::bC($hW, "$cI:$aN", '/');
 		$self->jI(\@abmain::bO, "bV", "You must change admin password first", 0, 0, undef, undef, $cook);
 		return;
 }
 $self->aU();
 $self->yTa(1) if $self->{takepop};
 $self->qXa();
}

# end of jW::lM
1;
