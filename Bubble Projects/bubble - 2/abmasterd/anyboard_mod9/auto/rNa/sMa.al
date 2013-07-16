# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 668 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/sMa.al)"
sub sMa {
 my ($self, $id, $dataid) = @_;
 my $vOa = $self->uFa($id, "def");
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);

 if($design->{wBa}) {
		$self->tHa();
 }
 my $isadm = $self->eVa();
 if(not ($isadm  || $design->{vAa} || $design->{wBa})) {
 		error("deny", "Access to data is restricted to administrator");
 }

 my $usrok = $self->tDa($design->{allowedreaders});
 my $curusr = lc($self->{wOa});
 if(not $usrok) {
 	my $uXa = $self->uFa($id, "idx");
 	my $DBT = $design->{usedb} ? 'zGa' : 'jEa';
 	my $uNa = $DBT->new($uXa, {schema=>"FMDataIndex"});
 	my $jKa = $uNa->iQa({noerr=>1, where=>"form_id = '$id' and data_id=$dataid", filter=>sub {return $_[0]->[0] == $dataid;} });
 	error('deny', "You are not allowed to view data")  if ((scalar(@$jKa)<1) || lc($jKa->[0]->[4]) ne $curusr);
 }

 my $form = new aLa($id);
 $form->cDa($vOa);
 my $wGa = $form->pKa(1);
 $form->sRa('usedb', $design->{usedb});
 $form->sRa('bBaA', $id);
 $form->load($self->rXa($id, $dataid), undef, {aefpid=>$dataid} );
 $form->bSa($design->{fullview}||$wGa);
 $form->pFa('file', $self->sAa($id));
 $form->pFa('ifile', $self->sAa($id,1));
 sVa::gYaA "Content-type: text/html\n\n";
 print $design->{uRa}? $self->{header} : ($design->{uOa}||"<html><body>");
 print sVa::tWa();
 my $nav = $self->yMa('didx', $id);
 print $nav, qq(<hr width="100%" noshade><br>);
 print $form->form(1);
 print $design->{uRa}? $self->{footer} : ($design->{uZa}||"</body></html>");
 
}

# end of rNa::sMa
1;
