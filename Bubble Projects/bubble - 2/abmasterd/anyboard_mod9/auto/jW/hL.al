# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1542 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/hL.al)"
sub hL {
 my($self, $cL, $noids) = @_;

	$self->{forum_header}=undef;
	$self->{forum_footer}=undef;
	$self->{forum_layout}=undef;
	$self->{other_header}=undef;
	$self->{other_footer}=undef;
	$self->{msg_header}=undef;
	$self->{msg_footer}=undef;

 my @eE;
 for(values %abmain::eO) {
 push @eE, $_->[1];
 }
 $cL = $self->nDz('fU') if not $cL;
 if($noids) {
 	$self->cW($cL, @eE);
 }else {
 	$self->jLz;
 	$self->cW($cL, @eE, \@abmain::bO, \@abmain::vC);
 }
 if($cL eq $self->nDz('fU') && $abmain::shadow_cfg) {
	$self->shadow_cfg();
 }
}

# end of jW::hL
1;
