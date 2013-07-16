# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3037 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/jP.al)"
sub jP{
 my ($self, $fI, $jIz, $recur) = @_; 
 if($recur>2000) {
	print STDERR "exceeded recursion limit, in gac\n";
	return;
 }
 my $entry = $self->{dA}->{$fI};
 foreach (@{$entry->{bE}}) {
	  next if $_->{fI} <=0;
	  next if $_->{fI} <= $fI;
 push @{$jIz}, $_;
	  $self->jP($_->{fI}, $jIz, 1+$recur);
 }
}

# end of jW::jP
1;
