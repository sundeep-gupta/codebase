# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 604 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/dGaA.al)"
sub dGaA {
 my ($self, $fm, $hashref) = @_;
 my $where;
 my @bindvarrs;
 for my $k (keys %$hashref) {
	push @bindvarrs, $k;
 }
 $where = join (" and ", map { "$_ = ?" } @bindvarrs );
 $where = " where $where" if $where;
 my @params = @{$hashref}{@bindvarrs};
 $self->bCaA($fm, $where, \@params);
}

# end of zDa::dGaA
1;
