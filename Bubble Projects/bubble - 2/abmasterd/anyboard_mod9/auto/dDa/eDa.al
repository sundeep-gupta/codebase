# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dDa;

#line 93 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dDa/eDa.al)"
sub eDa{
	my ($self) = @_;
	my $s = $self->{sock};
	my $lkey;
	my $cnt=0;
 $self->{eTa}= {};
	do {
		$_ = <$s>;
		print $dDa::LOG $_ if ($dDa::LOG ne "");
 defined($_) or return;
		last if length($_) > 1024*256;
 $_ =~ s/\r\n/\n/;
		if(/^([^:]+):\s+(.*)$/) {
			my $k = $1;
			my $v = $2;
			if(exists $self->{eTa}->{lc($k)}) {
				$self->{eTa}->{lc($k)} .="\0".$v;
				print $dDa::LOG "got header $k=$v\n" if ($dDa::LOG ne "");
			}else {
				$self->{eTa}->{lc($k)}=$v;
				print $dDa::LOG "got header2 $k=$v\n" if ($dDa::LOG ne "");
			}
			$lkey=lc($k);
		}
		/^\s+(\S+)$/ and $lkey and $self->{eTa}->{$lkey} .=$_;
		last if $cnt++ > 200;
	} until /^\s*$/;
}

# end of dDa::eDa
1;
