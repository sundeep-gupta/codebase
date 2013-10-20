# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 249 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/yVa.al)"
sub yVa{
 my ($self, $inboard,  $all) = @_;
 my $uNa = jEa->new($self->tTa(), {schema=>"vEa"});
 my $jKa = $uNa->iQa({noerr=>1});
 my $isadm = $self->eVa();
 my @ids; 
 for my $jRa (@$jKa) {
	my ($xZa, $xO, $publish, $vAa, $wBa, $vCa, $finb) = @$jRa;
 next if not  -f $self->uFa($xZa, "def");
	next if not ($isadm || $publish);
	next if ($inboard && not $finb);
	next if ($vCa && not ($self->{wOa} || $all));
	push @ids, [$xZa, $xO];
 }
 return @ids;
}

# end of rNa::yVa
1;
