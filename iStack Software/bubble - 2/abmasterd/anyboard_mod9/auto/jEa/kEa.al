# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jEa;

#line 47 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jEa/kEa.al)"
sub kEa{
 my ($self, $rowrefs, $opts, $clear) =@_;
 my $lck = jPa->new($self->{tb}, jPa::LOCK_EX());
 $self->oMz();
 return jEa::jQa($self->{tb}, $rowrefs, $opts, $clear);
}

# end of jEa::kEa
1;
