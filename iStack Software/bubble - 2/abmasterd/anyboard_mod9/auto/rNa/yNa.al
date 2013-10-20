# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 712 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/yNa.al)"
sub yNa {
 my ($self, $id, $dataid, $mod) = @_;
 my $vOa = $self->uFa($id, "def");

 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);
 
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->sRa('usedb', $design->{usedb});
 $form->sRa('bBaA', $id);
 $form->zOz();
 $form->load($self->rXa($id, $dataid), undef, {aefpid=>$dataid} );
 my $wGa = $form->pKa(1);

 $form->bSa($design->{fullview}||$wGa);
 $form->pFa('file', $self->sAa($id));
 $form->pFa('ifile', $self->sAa($id, 1));
 return $form->form(1);
 
}

# end of rNa::yNa
1;
