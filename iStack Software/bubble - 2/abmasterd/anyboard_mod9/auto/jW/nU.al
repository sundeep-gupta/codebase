# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 6545 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nU.al)"
sub nU {
 my ($self, $cO, $hIz, $hJz, $zA) = @_; 
 $self->cR();
 $self->bI() if ($zA);
 my $lck = jPa->new($self->nDz('msglist'), jPa::LOCK_EX());
 if($self->{aWz}) {
 	$self->{aGz}=1;
 	$self->{aIz}=0;
 $self->aQz();
 }
 if($cO) {
 my $sti = time() - $hIz* 24 * 3600;
 $sti = -1 if not $hIz;
 my $eti = time() - $hJz* 24 * 3600;
 my $yM;
 $yM = sub { my ($e)=@_; 
 return ($e->{mM}>=$sti && $e->{mM} <= $eti);
 };
 	$self->aT('A', 0, 0, $yM, undef, undef, $sti, $eti);
 if($zA) {
 $self->zF();
 }
 $self->oF(LOCK_EX,13);
 	$self->gI($self->{_verbose});
 $self->pG(13);
 }
 $self->aT();
 $self->eG();
};

# end of jW::nU
1;
