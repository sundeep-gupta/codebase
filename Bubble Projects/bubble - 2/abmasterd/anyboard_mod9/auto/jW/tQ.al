# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3052 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/tQ.al)"
sub tQ{
 my ($self, $jPz, $fI, $aK, $recur) = @_; 
 if($recur>2000) {
	print STDERR "exceeded recursion limit, in gac\n";
	return;
 }
 my $entry = $self->{dA}->{$fI};
 if (!$aK) {
 $aK = $fI ;
	$entry->{jE}=0;
 }
 $entry->{aK} = $aK;
 push @{$jPz}, $entry;
 foreach (@{$entry->{bE}}) {
	  $self->tQ($jPz, $_->{fI}, $aK, 1+$recur);
 }
}

# end of jW::tQ
1;
