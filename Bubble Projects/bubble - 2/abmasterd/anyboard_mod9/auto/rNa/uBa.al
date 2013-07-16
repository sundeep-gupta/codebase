# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 1436 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/uBa.al)"
sub uBa{
 my ($self, $input) = @_;
 $self->tJa() if not $self->eVa();
 my $id = $input->{uVa};
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->aSa();
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);
 $form->{zKz}->{wGa} =~ s/{_COMMAND_}/<_COMMAND_>/g;
 my $uPa = $form->pKa(1);
 $design->dNa('fields', join("\&nbsp; ", map{ qq(<b><font size="+1">$_</font></b>) } $form->fXa()));
 $design->dNa('vLa', $form->{zKz}->{wGa});
 $design->dNa('vPa', $uPa);
 $design->dNa('uVa', $id);
 $design->dNa('_aefcmd_', 'vUa');
 my @fids = $self->yVa();
 my $sel = join("\n", map { $_->[0].'='.$_->[1] } @fids);
 $design->aCa([frepfids=>"checkbox", $sel, "Allowed forms for reply. The selected forms can be used to reply to a message with this form attached."]);
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 my $nav = $self->yMa('conf', $id);
 print $nav,
 qq(<br>);
 print sVa::tWa();
 $design->sRa('pvhtml', 1);
 print $design->form();
 print $self->{footer};

}

# end of rNa::uBa
1;
