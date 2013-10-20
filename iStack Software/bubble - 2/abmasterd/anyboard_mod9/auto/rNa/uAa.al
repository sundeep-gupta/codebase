# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 1422 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/uAa.al)"
sub uAa{
 my ($self, $input) = @_;
 $self->tJa() if not $self->eVa();
 my $id = $input->{uVa};
 error('inval', "Can't delete primary key") if $input->{xZa} eq 'aefpid';	
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->zQz($self->{cgi});
 $form->gGa($input->{xZa});
 $form->cCa($vOa);
 $self->rVa($id);
}

# end of rNa::uAa
1;
