# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dDa;

#line 69 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dDa/eBaA.al)"
sub eBaA {
	my ($self, $fho) = @_;
	my $nA = $self->{sock};
	my $buf;
	my $len =0;
	my $cnt =0;
	while(($cnt=read($nA, $buf, 4096*4)) >0) {
		print $fho $buf;
		$len += $cnt;
		last if ($self->{max_recv_size} >0 && $len >= $self->{max_recv_size});
 }
	return $len;
}

# end of dDa::eBaA
1;
