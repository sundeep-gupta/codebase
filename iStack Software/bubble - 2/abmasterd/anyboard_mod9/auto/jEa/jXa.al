# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jEa;

#line 33 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jEa/jXa.al)"
sub jXa{
 my ($self, $rowrefs, $opts) =@_;
 my $lck = jPa->new($self->{tb}, jPa::LOCK_EX());
 return jQa($self->{tb}."_upd", $rowrefs, $opts);
}

# end of jEa::jXa
1;
