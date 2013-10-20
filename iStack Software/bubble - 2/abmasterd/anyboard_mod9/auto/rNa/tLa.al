# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 392 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/tLa.al)"
sub tLa{
 my ($self, $input) = @_;
 my $isadm = $self->eVa();
 my $xZa = $input->{uVa};
 error("inval", "Invalid form id, must be alphanumeric") if $xZa =~ /\W/;
 my $vOa = $self->uFa($xZa, "def");
 my $form = new aLa($xZa);
 $form->cDa($vOa);

 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($xZa, "fmt");
 $design->zOz();
 $design->load($fmtf);

 my $seqno = $input->{vMa};

 my $uXa = $self->uFa($xZa, "idx");

 my $DBT = $design->{usedb} ? 'zGa' : 'jEa';
 require zGa if $design->{usedb};
 my $uNa = $DBT->new($uXa, {schema=>"FMDataIndex"});

 my $jRa = $uNa->kCa($seqno);
 my $usrok = $self->tDa($design->{extraeditors});
 if(not ($isadm || $usrok)) {
 if($design->{modbyuser}) {
	   my ($did, $xZa, $t, $mt, $kQz) = @$jRa;
	   error("deny", "") if  lc($kQz) ne lc($self->{wOa});
 }else {
	   error("deny", "");
 }
 }

 error('deny', "Form originating from unauthorized page") 
		if $design->{vQa} && not $ENV{HTTP_REFERER} =~ /$design->{vQa}/; 

 $form->aAa($input);
 $form->cOa([split /\W+/, $design->{wJa}], 1);
 my @miss = $form->cHa();
 if(@miss) {
	$self->uIa($xZa, $form, "<center><h2>The data you input was not accepted, please make corrections and resubmit</h2>".join("<br>", @miss)."</center>");
	sVa::iUz();
 }

 my $cPz;
 for(values %$input) {
		next if not ref($_) eq 'ARRAY';
		$cPz = $self->sOa($xZa, $_->[0]);
 		error('inval', "Attempt to upload a file that exists") if -f $cPz && not $design->{qDz};
		open(kE, ">$cPz" ) || error($!. ": $cPz");
		binmode kE;
		print kE $_->[1];
		close kE;
 }

 $form->sRa('usedb', $design->{usedb});
 $form->sRa('bBaA', $xZa);
 $form->store($self->rXa($xZa, $seqno), undef, {aefpid=>$seqno});

 my @idxes = split /\W+/, $design->{uSa};
 my @vals = map {undef} 0..9;
 my $i=0;
 for(@idxes) {
	next if not $_;
	$vals[$i] = $form->{$_};
 $i++;	
	last if $i>=9; 
 }
 if($design->{usedb}) {
 	$uNa->jHa ([$jRa->[0], $jRa->[1], $jRa->[2], time(), $jRa->[4], $jRa->[5], $jRa->[6]]);
 }else {
 	$uNa->jHa ([$jRa->[0], $jRa->[1], $jRa->[2], time(), $jRa->[4], $jRa->[5], $jRa->[6], @vals]);
 }
 
 sVa::gYaA "Content-type: text/html\n\n";
 print $design->{uRa}? $self->{header} : ($design->{vBa}||"<html><body>");
 my $nav = $self->yMa('submit', $xZa);
 print $nav, qq(<br>);
 print "<center><h1>Thank you!</h1>\nThe following information has been accepted:</center><p>";
 $form->pFa('file', $self->sAa($xZa));
 $form->pFa('ifile', $self->sAa($xZa, 1));
 print $form->form(1);
 print $design->{uRa}? $self->{footer} : ($design->{vTa}||"</body></html>");
 if($input->{_ab_attach2mno} && $self->{jW}) {
	$self->{jW}->dMaA($input->{_ab_attach2mno});
 }
}

# end of rNa::tLa
1;
