# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 857 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/yOa.al)"
sub yOa{
 my ($self, $id, $vYa, $form, $extras) = @_;
 error("inval", "Invalid form id, must be alphanumeric") if $id =~ /\W/;

 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);
 if($design->{vCa}) {
		$self->tHa();
 }
 my $usrok = $self->tDa($design->{allowedusers});
 error('deny', "You are not allowed to submit data")  if not $usrok;
 if(not $form) {
 	my $vOa = $self->uFa($id, "def");
 	$form = new aLa($id);
 	$form->cDa($vOa);
 	$form->cOa([split /\W+/, $design->{wJa}], 1);
 }
 $form->zNz([_aefcmd_=>"hidden", "", "", "submit"]);
 $form->zNz([uVa=>"hidden", "", "", "$id"]);
 $form->zQz($self->{cgi});
 if($extras) {
	for my $k (keys %$extras) {
 		$form->zNz([$k=>"hidden", "", "", $extras->{$k}]);
 }

 }
 my $wGa = $form->aSa();
 $form->bSa($vYa?$wGa:($design->{vNa}||$wGa));
 return $form;
} 

# end of rNa::yOa
1;
