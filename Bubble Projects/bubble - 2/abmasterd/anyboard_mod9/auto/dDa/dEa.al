# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dDa;

#line 44 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dDa/dEa.al)"
sub dEa {
	my ($self) = @_;
	my $nA = $self->{sock};
	return if not $nA;
	my @arr;
	my $buf;
	my $len =0;
	my $cnt =0;
 my $maxlen =int($self->{eTa}->{'content-length'}) || $self->{max_recv_size};
	my $bsize=4096*4;
	while(($cnt=read($nA, $buf, $bsize)) >0) {
		push @arr, $buf;
		$len += $cnt;
		if ($maxlen >0 && $len >= $maxlen){
			last;
		}
		if($maxlen > 0 && $maxlen-$len < $bsize) {
			$bsize = $maxlen - $len;
		}
 }
	my $d = join("", @arr);
	#eVaA($d, $self->{dYa});
	return $d;
}

# end of dDa::dEa
1;
