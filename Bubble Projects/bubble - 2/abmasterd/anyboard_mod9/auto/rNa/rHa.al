# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 759 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/rHa.al)"
sub rHa{
 my ($self, $input) = @_;
 my $isadm = $self->eVa();
 $self->tJa() if not ($isadm || $input->{byusr});
 my $id = $input->{uVa};
 my $dataid = $input->{idx};
 error("inval", "Invalid form id, must be alphanumeric") if $id =~ /\W/;
 my $vOa = $self->uFa($id, "def");
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);

 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->sRa('usedb', $design->{usedb});
 $form->sRa('bBaA', $id);

 $form->zNz([_aefcmd_=>"hidden", "", "", "modify"]);
 $form->zNz([uVa=>"hidden", "", "", "$id"]);
 $form->zNz([vMa=>"hidden", "", "", "$dataid"]);
 $form->zQz($self->{cgi});
 $form->load($self->rXa($id, $dataid), undef, {aefpid=>$dataid} );

 my $wGa = $form->pKa();
 if($input->{byusr} && not $isadm) {
 my $uXa = $self->uFa($id, "idx");
 	my $DBT = $design->{usedb} ? 'zGa' : 'jEa';
 	require zGa if $design->{usedb};
 	my $uNa = $DBT->new($uXa, {schema=>"FMDataIndex"});
 my $jRa = $uNa->kCa($dataid);
	my ($did, $xZa, $t, $mt, $kQz) = @$jRa;
 	error("deny", "") if  lc($kQz) ne lc($self->{wOa});
	
 }

 $form->bSa($design->{vNa}||$wGa);
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print sVa::tWa();
 print $form->form();
 print $self->{footer};
} 

# end of rNa::rHa
1;
