# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 1350 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/tMa.al)"
sub tMa {
 my ($self, $input) = @_;
 $self->tJa() if not $self->eVa();

 my $id = $input->{uVa};
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->zQz($self->{cgi});

 my $af = new aLa("vZa", \@wFa, $self->{cgi});
 my $dupc = $input->{_aef_multi_kc};
 my $idx=0;
 $af->iEa("wEa", \&bAa::be_id);
 $af->iEa("uLa", \&bAa::be_set);
 for(;$idx <$dupc; $idx++) {
 $af->aAa($input, 0, $idx);
 error("inval", "Invalid form id $input->{uVa}, must be alphanumeric") if  ($idx==0 && not rJa($id) );
 error("inval", "Invalid form id, must start with a letter") if  $id !~ /^[a-z_]/i;
 my @miss = $af->cHa();
 if(@miss) {
	next if ($idx >0);
	sVa::gYaA "Content-type: text/html\n\n";
	print $self->{header};
	print $af->form(0, undef, 1);
	print $self->{footer};
	sVa::iUz();
 }
 my $nfe = [$af->{wEa}, $af->{uLa}, 
		$af->{vKa}, $af->{vRa}, $af->{vDa},
		$af->{fieldverifier}, $af->{fieldrequired}, $af->{fielddbtype}, $af->{fieldsizemax}, $af->{fieldidxtype} ];
 if($af->{wAa} && $af->{wAa} ne $af->{wEa}) {
		$form->gGa($af->{wAa});
 }
 if($af->{wAa} eq $af->{wEa}) {
	$form->aCa($nfe);
 }else {
 if ($form->jOa($af->{wEa})) {
 my $ef = bAa::wKa("There is already a field with the same name. Field name must be unique.");
	  $af->iEa("wEa", $ef);
	  sVa::gYaA "Content-type: text/html\n\n";
	  print "<html><body>";
	  print $af->form(0, undef, 1);
	  sVa::iUz();
 }
 if($input->{beforeid} eq '') {	
 		$form->zNz($nfe);
	}else {
 		$form->add_field_before($input->{beforeid}, $nfe);
	}
 }
 }
 $form->cCa($vOa);
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print sVa::tWa();

 my $nav = $self->yMa('def', $id);
 print $nav, qq(<br>);
 $af->aCa(["vJa", "head", "Added form element"]);
 print "<center>Added form element</center>";
 print $self->dPaA($id);
 my $nform = new aLa("wHa", \@wFa, $self->{cgi});
 $nform->aCa(["vJa", "head", "Add another form element"]);
 $nform->dNa("uVa", $id);

 $nform->sRa('dupcnt', 3);
 print $nform->form();
 print "</center>";
 print $self->{footer};
}

# end of rNa::tMa
1;
