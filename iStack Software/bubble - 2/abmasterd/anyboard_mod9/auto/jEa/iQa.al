# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jEa;

#line 39 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jEa/iQa.al)"
sub iQa{
 my ($self, $opts) =@_;
 my $jTa = $self->{tb};
 my $lck = jPa->new($self->{tb}, jPa::LOCK_SH);
 $opts->{index} = $self->{index};
 return jEa::jZa($jTa, $opts);
} 

# end of jEa::iQa
1;
