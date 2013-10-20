# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 266 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/uCa.al)"
sub uCa{
 my ($self, $input) = @_;
 my $iC = $self->{iC};
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print sVa::tWa();

 my $isadm = $self->eVa();
 my $colsel=[0,1,2,3];
 if($isadm) {
 }else {
	$colsel = [0, 1, 2];
 }
 if(not $self->{wOa}) {
 print "<center>You are not logged in, only public information is displayed.</center> ";
 }

 $self->tIa() if not -f $self->tTa();

 my $uNa = jEa->new($self->tTa(), {schema=>"vEa"});
 my $jKa = $uNa->iQa({noerr=>1});

 my $nav = $self->yMa('allforms');
 print $nav, qq(<br>);
 my @rows;
 for my $jRa (@$jKa) {
 
	my ($xZa, $xO, $publish, $vAa, $wBa, $vCa) = @$jRa;
 next if not  -f $self->uFa($xZa, "def");
	next if not ($isadm || $publish);
	next if ($vCa && not $self->{wOa});
 
 my $uXa = $self->uFa($xZa, "idx");
 my $t = (stat($uXa))[9];
 
 push @rows, [ 
	sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'uYa', uVa=>$xZa}), $xO), 
	sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'dataidx', uVa=>$xZa}), "Data index"), 
 $t>0? sVa::dU('LONG', $t, 'oP') :"",
	sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"wLa", uVa=>$xZa}), "Admin"), 
 ];
 }
 if(@rows) {
 	my @ths = map { qq(<font color="#ffcc00">$_</font>) } ("Form Name", "Data", "Last submit", "Command");
 	print sVa::fMa(ths=>\@ths, rows=>\@rows, colsel=>$colsel, sVa::oVa($tabattr));
 }else {
 print "<center>";
 print "No active forms available.<br>";
 print sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"uYa", uWa=>"lXa"}), "Create a new form") if $isadm;
 print "</center>";
 }
	
 print $self->{footer};

}

# end of rNa::uCa
1;
