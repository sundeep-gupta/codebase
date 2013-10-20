# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7696 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/zCa.al)"
sub zCa{
 my ($self, $cG, $loc, $one) = @_;
	if(0&&$one) {
		my $hsh = ($cG%$jW::hash_cnt) || 0;
 	my @rata = split /\t/, $self->{ratings2}->{$cG};
		my $i;
		for($i=0; $i<6; $i++) {
			$rata[$i]= undef if not defined($rata[$i]);
		}
 	my $db = $bYaA->new($self->mZa($hsh, $loc), {schema=>"AbRatings"});
 if($rata[2]>1) {
 		$db->jXa([[$cG, @rata]]);
 }else {
 		$db->kEa([[$cG, @rata]]);
 }
		return;
 }

 my %rat_hash;
 for (keys %{$self->{ratings2}}) {
 next if not $_;
 my $hash_code=  ($_%$jW::hash_cnt) || 0;
 my @rata = split /\t/, $self->{ratings2}->{$_}||"";
 my $oloc = $rata[4];
	   my $i;
	   for($i=0; $i<6; $i++) {
			$rata[$i]= undef if not defined($rata[$i]);
	   }
 push @{$rat_hash{$hash_code}}, [$_, @rata] if $loc eq $oloc;
 }

 my @nums;
	if(defined $cG) {
		push @nums, ($cG%$jW::hash_cnt) || 0;
	}else {
		@nums = keys %rat_hash;
 }
 for(@nums) {
 	$bYaA->new($self->mZa($_, $loc), {schema=>"AbRatings"})->iRa($rat_hash{$_});
	}
}

# end of jW::zCa
1;
