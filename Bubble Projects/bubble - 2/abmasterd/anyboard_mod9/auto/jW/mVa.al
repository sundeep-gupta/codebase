# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9164 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mVa.al)"
sub mVa{
 my ($self, $mail, $cat) = @_;

	my $gP = $self->iU();
 my $bXz = $self->{bXz} = {};

 my $from = $mail->{From};
 my $wW = $mail->{Subject}||"(No subject)";
 my $body = $mail->{qGa};
	$wW =~ s/\s+$//;
 
 $from =~ /$abmain::uD/o;
	my $email = $1;
	my $eusr = $2;
	$from =~ s/$email//g;
	$from =~ s/<|>|'|"//g;
	$from =~ s/\s+$//g;
	$from =~ s/^\s+//g;
 
 $mail->{'In-reply-to'} =~ /<(.*)>/;
	my $emid = $1;
	my ($tag, $aK, $jE) = split ('\.', $emid);
	

 my $uidarr = $self->pWa($email);
	my $gJz; $gJz = $uidarr->[0] if $uidarr;

 $bXz->{wW} = $wW;
 $bXz->{body}= $body;
 if($tag eq 'abp' && $aK>0) {
 	$bR =$aK;
 	$pF = $jE||0;
 }else {
 	$bR =$gP;
 	$pF = 0;
 }

	my @ups;
 for(@{$mail->{xattach}}) {
		next if ref($_) ne 'ARRAY';
 		my $fattach = $_;
		my $f =  $fattach->[0] || time().".txt";
		$f =~ s/\s+/_/g;
		$f =~ s/\//-/g;
 		my $cA = $self->cPz($f);
 		open(kE, ">$cA" ) or next;
 		binmode kE;
 		print kE $fattach->[1];
 		close kE;
		push @ups, $f;
 }
 
	$self->hGa(aK=>$bR, jE=>$pF, fI=> $gP, email=>$email, wW=>$wW, eZz=>join(" ", @ups),
 mM=>time(), size=>length($body), hC=>$gJz||$from||$eusr, scat=>$cat, kRa=>$abmain::VERSION||8); 
	$self->kA(1,1);
 
}

# end of jW::mVa
1;
