# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 617 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/dEaA.al)"
sub dEaA {
 my ($self, $hashref) = @_;
 my $where;
 my @bindvarrs;
 for my $k (keys %$hashref) {
	push @bindvarrs, $k;
 }
 $where = join (" and ", map { "$_ = ?" } @bindvarrs );
 $where = " where $where" if $where;
 my @params = @{$hashref}{@bindvarrs};
 $self->sHa($where, \@params);
}   

1;

use Clone;
1;
# end of zDa::dEaA
