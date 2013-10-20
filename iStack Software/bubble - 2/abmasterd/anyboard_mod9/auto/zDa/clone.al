# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 354 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/clone.al)"
sub clone {
 my $self = shift;
 my $nobj = $self->SUPER::clone();
 $nobj->{aHaA} = $self->{aHaA};
 $nobj->{_dbh} = $self->{_dbh};
 return $nobj;
}

# end of zDa::clone
1;
