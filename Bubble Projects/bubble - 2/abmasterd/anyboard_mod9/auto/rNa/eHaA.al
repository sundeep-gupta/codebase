# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 749 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/eHaA.al)"
sub eHaA {
 my ($self, $input) = @_;
 my $id = $input->{xZa};
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->eHaA($id);
 sVa::cTz("Table $id created");
}

# end of rNa::eHaA
1;
