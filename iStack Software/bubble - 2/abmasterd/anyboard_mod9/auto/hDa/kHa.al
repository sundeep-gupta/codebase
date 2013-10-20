# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package hDa;

#line 73 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/hDa/kHa.al)"
sub kHa{
	my ($self, $idx, $ent)=@_;
	my @vals = $self->mSa($idx);
	my $len = @vals;
 $ent->dFa(@vals[1..$len-1]);
	return $ent;
}

# end of hDa::kHa
1;
