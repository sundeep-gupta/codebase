# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package hDa;

#line 63 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/hDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/hDa/mSa.al)"
sub mSa{
	my ($self, $idx)=@_;
 return if not ref($self->{entry_hash}->{$idx});
 my @vals = @{$self->{entry_hash}->{$idx}};
 for(@vals) {
		$_ = sVa::oDa($_);
 }
	return @vals;
}

# end of hDa::mSa
1;
