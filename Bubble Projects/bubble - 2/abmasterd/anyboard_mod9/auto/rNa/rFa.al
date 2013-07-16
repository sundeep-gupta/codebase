# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 657 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/rFa.al)"
sub rFa{
 my ($self, $input) = @_;
 $self->tJa() if not $self->eVa();
 $self->rGa($input->{uVa}, $input->{idx});
 $self->tCa($input);
}

# end of rNa::rFa
1;
