# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 1253 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/sGa.al)"
sub sGa{
 my ($self, $input) = @_;
 my $af = new aLa("vUa", \@uBa, $self->{cgi});
 $af->aAa($input);
 $af->{vNa} =~ s/<_COMMAND_>/{_COMMAND_}/g;
 $af->{fullview} =~ s/<_COMMAND_>/{_COMMAND_}/g;
 $af->{vFa} =~ s/<_COMMAND_>/{_COMMAND_}/g;
 my $id = $af->{uVa};
 error("inval", "Invalid form id $input->{uVa}, must be alphanumeric") if $id =~ /\W/ || not $id;

 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->aSa();
 my $uPa = $form->pKa(1);

 $af->{vNa} = "" if $af->{vNa} eq  $form->{zKz}->{wGa};
 $af->{fullview} = "" if $af->{fullview} eq $uPa;
 $af->{vFa} = "" if $af->{vFa} eq $uPa;
 

 my $fmtf = $self->uFa($id, "fmt");
 $af->store($fmtf);
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 my $nav = $self->yMa('conf', $id);
 print $nav, 
 qq(<br>);
 print "<center><h1>The following settings have benn stored</h1></center>";
 print $af->form(1);
 print qq(<hr width="90%" noshade><br>), $nav;
 print $self->{footer};
 $self->tIa();
}

# end of rNa::sGa
1;
