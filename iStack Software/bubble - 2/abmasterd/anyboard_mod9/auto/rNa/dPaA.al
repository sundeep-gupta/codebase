# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 1470 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/dPaA.al)"
sub dPaA {
 my ($self, $id, $capt) = @_;
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 my $aJa = $form->{zKz};

 my ($p, $k, $i);
 my $zDz;

 $i =1;
 my @rows;
 foreach $p (@{$aJa->{jF}}) {
 next if not $p;
 next if $p->[1] eq 'skip';
		if($p->[1] eq 'head') {
 			my $h = $p->[2];
 push @rows, [$p->[0], "Form heading", $h, 
 sVa::cUz(sVa::sTa($self->{cgi}, { _aefcmd_=>'delfield', uVa=>$id, xZa=>$p->[0]}), "Delete").'&nbsp;&nbsp; '.
 sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'modfield', uVa=>$id, xZa=>$p->[0]}), "Modify")
 ];
 			next;
		}
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		my ($k, $t, $d) =  @{$ele}{qw(name type desc)};
 if (not $d) {
 $d = $k;
 $d =~ s/_/ /g;
 $d = ucfirst($d);
 }
 push @rows, [$k, $d, $ele->aYa, 
 sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'delfield', uVa=>$id, xZa=>$p->[0]}), "Delete").'&nbsp;&nbsp; '.
 		     sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'cCaA', uVa=>$id, beforeid=>$p->[0]} ), "Insert before"). " ".
 sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'modfield', uVa=>$id, xZa=>$p->[0]}), "Modify")
 ];
	}
 if(@rows) {
 		return sVa::fMa(ths=>[map{ qq(<font color="white">$_</font>) } ("Field name", "Description", "HTML", "Commands" )], rows=>\@rows, sVa::oVa($tabattr), capt=>$capt);
 }
 	return;
 
}

# end of rNa::dPaA
1;
