# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 397 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/sZa.al)"
sub sZa{
 my ($self) = @_;
 my @gHz;
 $self->{eJz} = "unamed_data" if not $self->{eJz};
 unless (@{$self->{parts}}) {
 push @gHz, qq(<$self->{eJz}>);
 push @gHz, rLa($self->nDa());
 push @gHz, qq(</$self->{eJz}>\n);
 	       return join ("", @gHz);
 }
 push @gHz, qq(<$self->{eJz}>);
 
 for(@{$self->{parts}}) {
	next if not $_;
 push @gHz, $_->sZa();
 }
 push @gHz, qq(</$self->{eJz}>\n);
 return join ("", @gHz);
}

# end of dZz::sZa
1;
