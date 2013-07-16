# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7623 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/xHz.al)"
sub xHz {
 my ($self) = @_;
 $self->oF(LOCK_SH, 7);
	my $uf = $self->nDz('update');
 my $linesref = $bYaA->new($uf, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($uf)})->iQa({noerr=>1} );
	return if not $linesref;
 if(@$linesref) {
 	my $updf = $self->nDz('msglist')."_upd";
 $bYaA->new($updf, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($updf) })->kEa($linesref);
 	unlink $self->nDz('update');
 }
 $self->pG(7);
}

# end of jW::xHz
1;
