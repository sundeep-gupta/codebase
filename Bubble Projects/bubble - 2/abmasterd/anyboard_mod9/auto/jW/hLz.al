# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9846 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/hLz.al)"
sub hLz{
 my ($self, $upfiles)=@_;
 for(values %{$upfiles}) {
 	my $fattach = $_;
	next if not $_->[0];
 	my $cA = $self->cPz($fattach->[0]);
 	open(kE, ">$cA" ) || abmain::error($!. ": $cA");
 	binmode kE;
 	print kE $fattach->[1];
 	close kE;
 	chmod 0600, $cA if $self->{oLz};
 }
}

# end of jW::hLz
1;
