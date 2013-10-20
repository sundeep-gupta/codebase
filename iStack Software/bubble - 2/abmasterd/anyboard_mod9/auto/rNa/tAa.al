# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 1307 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/tAa.al)"
sub tAa{
 my ($self, $input) = @_;
 $self->tJa() if not $self->eVa();
 my ($id, $fldid) = ($input->{uVa}, $input->{xZa});
 error("inval", "Invalid form id $input->{uVa}, must be alphanumeric") if $id =~ /\W/ || not $id;
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 my $f = $form->jOa($fldid);
 error('inval', "Field $fldid not found") if not $f;
 my $af = new aLa("vZa", \@wFa, $self->{cgi});
 $af->dNa("wEa", $f->[0]);
 $af->dNa("uLa", $f->[1]);
 $af->dNa("vKa", $f->[2]);
 $af->dNa("vRa", $f->[3]);
 $af->dNa("vDa", $f->[4]);
 $af->dNa("fieldverifier", $f->[5]);
 $af->dNa("fieldrequired", $f->[6]);
 $af->dNa("fielddbtype", $f->[7]);
 $af->dNa("fieldsizemax", $f->[8]);
 $af->dNa("fieldidxtype", $f->[9]);
 $af->dNa('wAa', $fldid);
 $af->dNa('uVa', $id);
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print $af->form();
 print $self->{footer};
}

# end of rNa::tAa
1;
