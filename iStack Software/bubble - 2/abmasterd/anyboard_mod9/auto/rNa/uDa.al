# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 520 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/uDa.al)"
sub uDa {
 my ($self, $input) = @_;
 my $xZa = $input->{uVa};
 error("inval", "Invalid form id, must be alphanumeric") if $xZa =~ /\W/;
 my $vOa = $self->uFa($xZa, "def");
 my $form = new aLa($xZa);
 $form->cDa($vOa);

 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf =$self->uFa($xZa, "fmt");
 $design->zOz();
 $design->load($fmtf);

 error('deny', "Form originating from unauthorized page") 
		if $design->{vQa} && not $ENV{HTTP_REFERER} =~ /$design->{vQa}/; 

 if($design->{vCa}) {
		$self->tHa();
 }

 my $usrok = $self->tDa($design->{allowedusers});
 error('deny', "You are not allowed to submit data")  if not $usrok;

 $form->cOa([split /\W+/, $design->{wJa}], 1);
 my $dupc = $input->{_aef_multi_kc};
 my $idx=0;
 my $acnt=0;
 my @strs;

 my $seqno;

 for(; $idx<$dupc; $idx++) {
 $form->aAa($input, 0, $idx);
 my @miss = $form->cHa();
 if(scalar(@miss) ==1 && $miss[0] eq 'aefpid') {
 if(@miss) {
	next if $idx >0;
 	if($input->{_ab_attach2mno} && $self->{jW}) {
		$form->zNz([_ab_attach2mno=>"hidden", "", "", $input->{_ab_attach2mno}]);
	}
	$self->uIa($xZa, $form, "<center><h2>The data you input was invalid, please make corrections and resubmit</h2>".join("<br>", @miss)."</center>");
	sVa::iUz();
 }
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

 $seqno = sVa::nextseq($self->{iC});
 $form->dNa('aefpid', $seqno);
 $form->sRa('usedb', $design->{usedb});
 $form->sRa('bBaA', $xZa);
#x2
 my $uXa = $self->uFa($xZa, "idx");
 my $DBT = $design->{usedb} ? 'zGa' : 'jEa';
 require zGa if $design->{usedb};
 my $uNa = $DBT->new($uXa, {schema=>"FMDataIndex"});
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
 	$uNa->iSa([$seqno, $xZa, time(), undef, $self->{wOa}, $ENV{REMOTE_ADDR}, undef]);
 }else {
 	$uNa->iSa([$seqno, $xZa, time(), undef, $self->{wOa}, $ENV{REMOTE_ADDR}, undef, @vals]);
 }
 $acnt ++;
 push @strs, $form->form(1);
 }


 $form->bSa($design->{fullview}||$form->pKa());
 $form->pFa('file', $self->sAa($xZa));
 $form->pFa('ifile', $self->sAa($xZa,1));
 my $cTa= join("", @strs);
 if($design->{notify}) {
 	my %mail;
 $mail{sendmail_cmd} = $abmain::sendmail_cmd if $abmain::use_sendmail;
 $mail{Smtp} = $abmain::smtp_server;
 	$mail{To} = $design->{wN};
 	$mail{From} = $design->{notifier};
 	$mail{Bcc} = $design->{bcc};
 	$mail{Subject} = "Form submission: ".$design->{name};
 	$mail{Body} = "See attached html file for details.";
 	my $e = sVa::mXz(\%mail, time().".html", join("", "<html><body>",  $cTa, "<br/>$ENV{HTTP_REFERER}<p></body></html>"));
 	error('sys', "When sending mail: $e") if $e; 
 }
 if($input->{_ab_attach2mno} && $self->{jW}) {
	$self->{jW}->yGa($input->{_ab_attach2mno}, $xZa, $seqno, $cTa, $design);
	return;
 } 

 sVa::gYaA "Content-type: text/html\n\n";
 my $nav = $self->yMa('submit', $xZa);
 print $design->{uRa}? $self->{header} : ($design->{vBa}||"<html><body>");
 print $nav;
 print "<center><h1>Thank you!</h1>\nThe following information has been accepted:</center><p>";
 print $cTa;
 print $design->{uRa}? $self->{footer} : ($design->{vTa}||"</body></html>");
}

# end of rNa::uDa
1;
