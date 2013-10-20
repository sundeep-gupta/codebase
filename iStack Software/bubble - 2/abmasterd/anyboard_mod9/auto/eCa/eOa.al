# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 352 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/eOa.al)"
sub eOa {
#            hash-ref  hash-ref   hash-ref    array-ref   array-ref
	my ( $match,   $filesdb,  $titlesdb,  $words,     $ignored  ) = @_; 
	my $result = {
		searched =>  $words,
		ignored  =>  $ignored,
		files	 =>  []
	};
	my $key;
 	my %match2=();
	local *F;
	my $klen = length(pack("xn", 9999));
	foreach $key (keys %$match) {
		my $ckey = pack("xn",$key);
		$match2{$ckey} = $key;
	} 
	
	my ($k, $v);
	my $res={};
	open F, "<$filesdb";
	while (<F>) {
		chomp;
		#($k, $v) = split /\t/, $_;
		$k = substr $_, 0, $klen;
		next if not exists $match2{$k}; 
		$v = substr $_, $klen+1;
		my $okey = $match2{$k};
		$res->{$okey}->[0] = $v;
		$res->{$okey}->[1] = $match->{$okey};
	}
	close F;

	open F, "<$titlesdb";
	while (<F>) {
		chomp;
		($k, $v) = split /\t/, $_, 2;
		next if not exists $match2{$k}; 
		my $okey = $match2{$k};
		$res->{$okey}->[2] = $v;
	}
	close F;	
	for(values %$res) {
		push @{$result->{files}}, {filename=>$_->[0], score=>$_->[1], title=>$_->[2]};
	}
	return $result;
}

# end of eCa::eOa
1;
