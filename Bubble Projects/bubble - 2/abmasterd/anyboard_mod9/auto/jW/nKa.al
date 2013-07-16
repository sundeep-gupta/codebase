# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9221 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nKa.al)"
sub nKa{
	my ($self) = @_;
 $self->cR();

return;

require mOa;
	my $mail_cnt=0;
 my ($popserv, $popu, $passwd) = ($self->{qFa}, $self->{qCa}, $self->{qDa});
 	my $pop = mOa->new($popu, $passwd, $popserv);
 return "$popu fail to logon POP server $popserv: ${\($pop->State())}, ${\($pop->nIa())}"
	  unless ($pop->State() =~ /^TRANS/);
 my @mnos = $pop->qIa();
	return "Successfully logged in POP3 server" if not scalar(@mnos);
	my @tT;
 for(@mnos) {
		my ($cG, $sz, $gJz) = @$_;
		my %mail =  $pop->qEa($cG, $gJz);
		push @tT, $mail{Subject}||$mail{subject};
		if($mail{From} ne $self->{notifier}) {
			$self->mVa(\%mail, "");
		}
		$pop->pGa($cG);
		$mail_cnt ++;
 }
	return ("Successfully retrieved emails:<br/>".join("<br/>\n",@tT), $mail_cnt) if scalar(@mnos);
}

# end of jW::nKa
1;
