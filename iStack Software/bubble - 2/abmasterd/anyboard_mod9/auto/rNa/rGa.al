# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 633 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/rGa.al)"
sub rGa{
 my ($self, $xZa, $dataid) = @_;
 my $uXa = $self->uFa($xZa, "idx");

 my $vOa = $self->uFa($xZa, "def");
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($xZa, "fmt");
 $design->zOz();
 $design->load($fmtf);
 
 my $DBT = $design->{usedb} ? 'zGa' : 'jEa';
 require zGa if $design->{usedb};
 my $uNa = $DBT->new($uXa, {schema=>"FMDataIndex"});
 $uNa->jLa([$dataid]);

 my $form = new aLa($xZa);
 $form->cDa($vOa);
 my $wGa = $form->pKa(1);
 $form->sRa('usedb', $design->{usedb});
 $form->sRa('bBaA', $xZa);
 $form->rGa($self->rXa($xZa, $dataid),{aefpid=>$dataid} );
}

# end of rNa::rGa
1;
