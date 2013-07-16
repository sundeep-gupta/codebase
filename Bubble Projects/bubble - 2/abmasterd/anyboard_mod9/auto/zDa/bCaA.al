# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 589 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/bCaA.al)"
sub bCaA {
	my ($self, $fm, $where, $params) = @_;
 my @modfs=();
 my @ids = $fm->fXa();
 for my $k ( @ids ) {
		next if not exists $self->{$k};
		next if $self->{$k} eq $fm->{$k};
		push @modfs, $k;
		$self->{$k} = $fm->{$k};
 }
 return if not scalar(@modfs); 
	$self->rRa(\@modfs, $where, $params);
 
}

# end of zDa::bCaA
1;
